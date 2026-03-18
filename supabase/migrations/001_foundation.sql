-- Promise Tracker for Power
-- Migration 001: Foundation schema

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";  -- fuzzy text search

-- ============================================================
-- ENTITIES: The people and institutions who make promises
-- ============================================================

CREATE TYPE entity_type AS ENUM ('td', 'senator', 'mep', 'minister', 'commissioner', 'executive', 'institution', 'agency', 'local_councillor', 'other');

CREATE TABLE entities (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL,
    entity_type entity_type NOT NULL,
    title TEXT,                          -- "Senator", "CEO of X", "Secretary General"
    jurisdiction TEXT,                   -- "US Federal", "California", "EU", "Global"
    party TEXT,                          -- political party, if applicable
    organization TEXT,                   -- company/agency/org name
    wikipedia_url TEXT,
    image_url TEXT,
    bio TEXT,
    active BOOLEAN DEFAULT true,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_entities_name_trgm ON entities USING gin (name gin_trgm_ops);
CREATE INDEX idx_entities_type ON entities (entity_type);

-- ============================================================
-- PROMISES: The core unit — a specific, trackable commitment
-- ============================================================

CREATE TYPE promise_status AS ENUM (
    'made',           -- recorded but not yet due
    'in_progress',    -- active work toward fulfillment
    'kept',           -- delivered as promised
    'broken',         -- deadline passed or explicitly abandoned
    'compromised',    -- partially delivered, materially different
    'pivoted',        -- openly changed course with explanation
    'expired',        -- time-bound promise where the window closed quietly
    'disputed'        -- conflicting evidence about fulfillment
);

CREATE TYPE promise_specificity AS ENUM (
    'precise',        -- "We will hire 10,000 workers by Q3 2025"
    'measurable',     -- "We will reduce emissions" (direction clear, magnitude unclear)
    'vague',          -- "We will work to improve the economy"
    'aspirational'    -- "We will be the best" (barely trackable)
);

CREATE TABLE promises (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    entity_id UUID NOT NULL REFERENCES entities(id) ON DELETE CASCADE,

    -- What was said
    quote TEXT NOT NULL,                 -- exact words, verbatim
    summary TEXT NOT NULL,               -- plain-language distillation
    context TEXT,                        -- surrounding circumstances

    -- When
    date_made DATE NOT NULL,
    deadline DATE,                       -- explicit deadline if stated
    implied_deadline TEXT,               -- "by the end of my term", "soon"

    -- Classification
    status promise_status DEFAULT 'made',
    specificity promise_specificity NOT NULL,
    category TEXT NOT NULL,              -- "economy", "healthcare", "environment", etc.
    tags TEXT[] DEFAULT '{}',

    -- Scoring inputs
    magnitude INTEGER CHECK (magnitude BETWEEN 1 AND 10),  -- how big is this promise?
    public_interest INTEGER DEFAULT 0,   -- community votes on importance

    -- What actually happened
    outcome_summary TEXT,
    outcome_date DATE,
    outcome_notes TEXT,

    -- Metadata
    submitted_by UUID,                   -- user who submitted (nullable for seed data)
    verified BOOLEAN DEFAULT false,      -- editor-reviewed
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_promises_entity ON promises (entity_id);
CREATE INDEX idx_promises_status ON promises (status);
CREATE INDEX idx_promises_category ON promises (category);
CREATE INDEX idx_promises_date_made ON promises (date_made);
CREATE INDEX idx_promises_summary_trgm ON promises USING gin (summary gin_trgm_ops);

-- ============================================================
-- EVIDENCE: Sources that prove a promise was made or kept/broken
-- ============================================================

CREATE TYPE evidence_type AS ENUM (
    'speech_transcript',
    'press_release',
    'social_media',
    'interview',
    'official_document',
    'legislation',
    'financial_filing',
    'news_report',
    'video',
    'court_record',
    'other'
);

CREATE TYPE evidence_role AS ENUM (
    'promise_source',    -- proves the promise was made
    'progress_update',   -- shows progress toward/away from fulfillment
    'outcome_proof',     -- proves kept or broken
    'context'            -- provides background
);

CREATE TABLE evidence (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    promise_id UUID NOT NULL REFERENCES promises(id) ON DELETE CASCADE,

    evidence_type evidence_type NOT NULL,
    role evidence_role NOT NULL,

    url TEXT,                            -- link to source
    title TEXT NOT NULL,
    publication TEXT,                    -- "New York Times", "SEC.gov", etc.
    author TEXT,
    date_published DATE,

    excerpt TEXT,                        -- relevant quote/section
    archived_url TEXT,                   -- Wayback Machine or archive.org link
    file_hash TEXT,                      -- SHA-256 of archived content (tamper-proof)

    submitted_by UUID,
    verified BOOLEAN DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_evidence_promise ON evidence (promise_id);
CREATE INDEX idx_evidence_role ON evidence (role);

-- ============================================================
-- TIMELINE: Chronological events related to a promise
-- ============================================================

CREATE TABLE timeline_events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    promise_id UUID NOT NULL REFERENCES promises(id) ON DELETE CASCADE,
    event_date DATE NOT NULL,
    description TEXT NOT NULL,
    evidence_id UUID REFERENCES evidence(id),
    status_change promise_status,        -- if this event changed the promise status
    created_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_timeline_promise ON timeline_events (promise_id);
CREATE INDEX idx_timeline_date ON timeline_events (event_date);

-- ============================================================
-- ACCOUNTABILITY SCORES: Computed per-entity scorecard
-- ============================================================

CREATE TABLE accountability_scores (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    entity_id UUID NOT NULL REFERENCES entities(id) ON DELETE CASCADE,
    computed_at TIMESTAMPTZ DEFAULT now(),

    -- Raw counts
    total_promises INTEGER DEFAULT 0,
    kept INTEGER DEFAULT 0,
    broken INTEGER DEFAULT 0,
    compromised INTEGER DEFAULT 0,
    pivoted INTEGER DEFAULT 0,
    in_progress INTEGER DEFAULT 0,
    expired INTEGER DEFAULT 0,

    -- Weighted score (0-100)
    -- Formula: see scoring function below
    overall_score NUMERIC(5,2),

    -- Breakdown
    precision_score NUMERIC(5,2),        -- do they make specific promises?
    follow_through_score NUMERIC(5,2),   -- do they deliver?
    transparency_score NUMERIC(5,2),     -- do they acknowledge changes?

    UNIQUE(entity_id, computed_at)
);

CREATE INDEX idx_scores_entity ON accountability_scores (entity_id);
CREATE INDEX idx_scores_computed ON accountability_scores (computed_at DESC);

-- ============================================================
-- COMMUNITY: Users, submissions, votes
-- ============================================================

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email TEXT UNIQUE,
    display_name TEXT,
    reputation INTEGER DEFAULT 0,
    role TEXT DEFAULT 'contributor',      -- contributor, editor, admin
    created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE votes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id),
    promise_id UUID NOT NULL REFERENCES promises(id),
    vote_type TEXT NOT NULL CHECK (vote_type IN ('important', 'needs_attention', 'dispute')),
    created_at TIMESTAMPTZ DEFAULT now(),
    UNIQUE(user_id, promise_id, vote_type)
);

CREATE TABLE comments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id),
    promise_id UUID NOT NULL REFERENCES promises(id),
    parent_id UUID REFERENCES comments(id),  -- threaded
    body TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now(),
    updated_at TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_comments_promise ON comments (promise_id);

-- ============================================================
-- SCORING FUNCTION
-- ============================================================

CREATE OR REPLACE FUNCTION compute_accountability_score(p_entity_id UUID)
RETURNS NUMERIC AS $$
DECLARE
    v_total INTEGER;
    v_kept INTEGER;
    v_broken INTEGER;
    v_compromised INTEGER;
    v_pivoted INTEGER;
    v_expired INTEGER;
    v_precise_total INTEGER;
    v_precise_count INTEGER;
    v_pivoted_transparent INTEGER;
    v_follow_through NUMERIC;
    v_precision NUMERIC;
    v_transparency NUMERIC;
    v_overall NUMERIC;
BEGIN
    -- Count promises by status
    SELECT
        COUNT(*),
        COUNT(*) FILTER (WHERE status = 'kept'),
        COUNT(*) FILTER (WHERE status = 'broken'),
        COUNT(*) FILTER (WHERE status = 'compromised'),
        COUNT(*) FILTER (WHERE status = 'pivoted'),
        COUNT(*) FILTER (WHERE status = 'expired')
    INTO v_total, v_kept, v_broken, v_compromised, v_pivoted, v_expired
    FROM promises
    WHERE entity_id = p_entity_id;

    IF v_total = 0 THEN
        RETURN NULL;
    END IF;

    -- Precision: what fraction of promises are specific/measurable vs vague?
    SELECT
        COUNT(*),
        COUNT(*) FILTER (WHERE specificity IN ('precise', 'measurable'))
    INTO v_precise_total, v_precise_count
    FROM promises
    WHERE entity_id = p_entity_id;

    -- Follow-through: weighted delivery rate
    -- kept = 1.0, compromised = 0.5, pivoted = 0.3, broken/expired = 0
    v_follow_through := CASE WHEN v_total > 0
        THEN (v_kept * 1.0 + v_compromised * 0.5 + v_pivoted * 0.3) / v_total * 100
        ELSE 0 END;

    -- Precision score: are they making trackable promises?
    v_precision := CASE WHEN v_precise_total > 0
        THEN v_precise_count::NUMERIC / v_precise_total * 100
        ELSE 0 END;

    -- Transparency: of broken/changed promises, how many were openly acknowledged?
    -- (pivoted = transparent change, expired = silent drop)
    v_pivoted_transparent := v_pivoted;
    v_transparency := CASE WHEN (v_broken + v_expired + v_pivoted) > 0
        THEN v_pivoted_transparent::NUMERIC / (v_broken + v_expired + v_pivoted) * 100
        ELSE 100 END;  -- no broken promises = full transparency score

    -- Overall: weighted combination
    -- 60% follow-through, 20% precision, 20% transparency
    v_overall := (v_follow_through * 0.6) + (v_precision * 0.2) + (v_transparency * 0.2);

    -- Upsert the score
    INSERT INTO accountability_scores (
        entity_id, total_promises, kept, broken, compromised, pivoted, expired,
        overall_score, follow_through_score, precision_score, transparency_score
    ) VALUES (
        p_entity_id, v_total, v_kept, v_broken, v_compromised, v_pivoted, v_expired,
        v_overall, v_follow_through, v_precision, v_transparency
    );

    RETURN v_overall;
END;
$$ LANGUAGE plpgsql;

-- ============================================================
-- VIEWS: Useful query shortcuts
-- ============================================================

-- Leaderboard view
CREATE VIEW entity_leaderboard AS
SELECT
    e.id,
    e.name,
    e.entity_type,
    e.title,
    e.organization,
    e.jurisdiction,
    s.overall_score,
    s.follow_through_score,
    s.precision_score,
    s.transparency_score,
    s.total_promises,
    s.kept,
    s.broken,
    s.computed_at
FROM entities e
LEFT JOIN LATERAL (
    SELECT * FROM accountability_scores
    WHERE entity_id = e.id
    ORDER BY computed_at DESC
    LIMIT 1
) s ON true
WHERE e.active = true;

-- Promise detail view with evidence count
CREATE VIEW promise_details AS
SELECT
    p.*,
    e.name AS entity_name,
    e.entity_type,
    e.title AS entity_title,
    (SELECT COUNT(*) FROM evidence ev WHERE ev.promise_id = p.id) AS evidence_count,
    (SELECT COUNT(*) FROM votes v WHERE v.promise_id = p.id AND v.vote_type = 'important') AS importance_votes,
    (SELECT COUNT(*) FROM timeline_events t WHERE t.promise_id = p.id) AS timeline_count
FROM promises p
JOIN entities e ON e.id = p.entity_id;

-- ============================================================
-- ROW LEVEL SECURITY
-- ============================================================

ALTER TABLE entities ENABLE ROW LEVEL SECURITY;
ALTER TABLE promises ENABLE ROW LEVEL SECURITY;
ALTER TABLE evidence ENABLE ROW LEVEL SECURITY;
ALTER TABLE timeline_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE votes ENABLE ROW LEVEL SECURITY;
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;

-- Public read access to all core data (this is public accountability infrastructure)
CREATE POLICY "Public read access" ON entities FOR SELECT USING (true);
CREATE POLICY "Public read access" ON promises FOR SELECT USING (true);
CREATE POLICY "Public read access" ON evidence FOR SELECT USING (true);
CREATE POLICY "Public read access" ON timeline_events FOR SELECT USING (true);
CREATE POLICY "Public read access" ON votes FOR SELECT USING (true);
CREATE POLICY "Public read access" ON comments FOR SELECT USING (true);

-- Authenticated users can submit
CREATE POLICY "Auth users can insert" ON promises FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);
CREATE POLICY "Auth users can insert" ON evidence FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);
CREATE POLICY "Auth users can vote" ON votes FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Auth users can comment" ON comments FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Only editors/admins can update promise status
CREATE POLICY "Editors can update promises" ON promises FOR UPDATE USING (
    EXISTS (SELECT 1 FROM users WHERE id = auth.uid() AND role IN ('editor', 'admin'))
);

-- ============================================================
-- TRIGGERS
-- ============================================================

-- Auto-update updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_entities_updated_at BEFORE UPDATE ON entities
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER tr_promises_updated_at BEFORE UPDATE ON promises
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER tr_comments_updated_at BEFORE UPDATE ON comments
    FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Auto-recompute score when a promise status changes
CREATE OR REPLACE FUNCTION recompute_score_on_promise_change()
RETURNS TRIGGER AS $$
BEGIN
    PERFORM compute_accountability_score(NEW.entity_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_recompute_score AFTER INSERT OR UPDATE OF status ON promises
    FOR EACH ROW EXECUTE FUNCTION recompute_score_on_promise_change();

-- ============================================================
-- SEED DATA: Ireland & Europe focused
-- ============================================================

-- Jurisdictions reference (used in entities.jurisdiction)
-- Ireland: 'ireland', 'dublin', 'cork', 'galway', 'limerick', etc.
-- EU: 'eu', 'european-parliament', 'european-commission'
-- Member states: 'france', 'germany', 'spain', 'italy', 'netherlands', 'poland', etc.

-- Categories relevant to Ireland & EU
CREATE TABLE categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name TEXT NOT NULL UNIQUE,
    slug TEXT NOT NULL UNIQUE,
    description TEXT,
    sort_order INTEGER DEFAULT 0
);

INSERT INTO categories (name, slug, description, sort_order) VALUES
    ('Housing',           'housing',          'Housing supply, homelessness, rent, planning',                    1),
    ('Health & HSE',      'health',           'Health service, hospitals, waiting lists, mental health',         2),
    ('Cost of Living',    'cost-of-living',   'Prices, wages, social welfare, energy costs',                    3),
    ('Climate & Energy',  'climate',          'Emissions targets, renewables, energy policy, biodiversity',     4),
    ('Transport',         'transport',        'Public transport, roads, cycling, MetroLink, BusConnects',       5),
    ('Education',         'education',        'Schools, universities, childcare, apprenticeships',              6),
    ('Economy & Jobs',    'economy',          'Employment, enterprise, trade, budgets, taxation',               7),
    ('Agriculture',       'agriculture',      'Farming, CAP, food production, rural development',              8),
    ('Justice & Policing','justice',          'Gardai, courts, prisons, legal reform',                          9),
    ('Immigration',       'immigration',      'Asylum, direct provision, integration, work permits',           10),
    ('Foreign Affairs',   'foreign-affairs',  'EU relations, Northern Ireland, international development',     11),
    ('EU Policy',         'eu-policy',        'EU legislation, single market, digital regulation',             12),
    ('Technology',        'technology',       'Digital infrastructure, broadband, data centres, AI policy',    13),
    ('Corporate Governance','corporate',      'Business commitments, ESG, corporate accountability',           14),
    ('Water & Infrastructure','infrastructure','Irish Water, utilities, national development plan',            15),
    ('Irish Language',    'gaeilge',          'Irish language promotion, Gaeltacht, language policy',          16),
    ('Northern Ireland',  'northern-ireland', 'North-South cooperation, Good Friday Agreement, reunification', 17);

-- Promise-to-category mapping
CREATE TABLE promise_categories (
    promise_id UUID NOT NULL REFERENCES promises(id) ON DELETE CASCADE,
    category_id UUID NOT NULL REFERENCES categories(id) ON DELETE CASCADE,
    PRIMARY KEY (promise_id, category_id)
);
