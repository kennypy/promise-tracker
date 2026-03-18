# Data Sourcing, Presentation & Search

**Scope: Ireland & Europe**

The initial focus is Ireland (national + local government, Irish business) and EU institutions. This keeps the dataset manageable, the sources consistent, and the editorial team focused.

---

## Where Do Promises Come From?

Three tiers, from most reliable to most scalable.

### Tier 1: Official Public Records (seed data, highest trust)

**Ireland**

| Source | What we get | How |
|---|---|---|
| Dail Eireann & Seanad debates | TDs' and Senators' stated commitments on the record | Oireachtas API / debates archive (oireachtas.ie) |
| Programme for Government | Coalition commitments at the start of each government | Published PDF, structured manually |
| Ministerial press releases | Specific pledges from government departments | gov.ie, department websites |
| Party manifestos (general & local elections) | Election promises in parties' own words | Party websites, archived PDFs (Internet Archive) |
| Local authority meeting minutes | County/city council commitments | Council websites |
| CRO / Companies Registration Office filings | Corporate governance commitments | CRO.ie |
| Irish corporate sustainability reports | ESG pledges, net-zero targets from Irish companies | Company IR pages |

**EU / European**

| Source | What we get | How |
|---|---|---|
| European Parliament plenary debates | MEPs' stated commitments | europarl.europa.eu, legislative observatory |
| European Commission press releases | Policy commitments from Commissioners | ec.europa.eu |
| European Council conclusions | Heads-of-state commitments after summits | consilium.europa.eu |
| EU legislative proposals & impact assessments | Promised outcomes of proposed legislation | EUR-Lex |
| ECB policy statements | Monetary policy commitments | ecb.europa.eu |
| EU member state government programmes | National commitments across Europe | National government sites |

These get bulk-imported as seed data. Each promise gets a `specificity` rating and a primary `evidence` record linking to the original source.

### Tier 2: Curated Media Sources (ongoing, editor-reviewed)

Editors monitor key Irish and European outlets and extract promises:

- **Irish media**: RTE, Irish Times, Irish Independent, Irish Examiner, TheJournal.ie, Newstalk
- **EU/European media**: Politico Europe, EUobserver, Reuters, Financial Times, The Guardian (Europe desk)
- **Events**: Budget speeches, Ard Fheiseanna (party conferences), EU summits, European Council meetings, Davos
- Dail committee hearings and EU Parliament committee sessions
- Interviews and press conferences where commitments are made

Each submission requires: **exact quote**, **source URL**, **date**, and **context**. Editors classify specificity and category before approval.

### Tier 3: Community Submissions (scalable, moderated)

Any authenticated user can submit a promise they've spotted. The flow:

1. User fills out: who said it, what they said, where/when, link to source
2. System runs duplicate detection (trigram similarity against existing promises)
3. Submission enters the review queue
4. An editor verifies the source, classifies it, and approves/rejects
5. On approval, the promise enters the main database

Community submissions are how the system scales beyond what any editorial team could cover alone.

### Automated Discovery (n8n workflows)

- **News monitoring**: Every 6 hours, search Irish and European news APIs for tracked entities + keywords like "pledge", "commit", "promise", "will deliver", "by 2030". Surface matches for editor review.
- **Oireachtas monitoring**: Check for new debate transcripts. Flag speeches containing commitment language from tracked TDs and Senators.
- **EU monitoring**: Track new European Commission press releases and European Council conclusions for commitment language.
- **Source archival**: Every new URL gets submitted to the Wayback Machine automatically. Sources can't be silently deleted.

---

## How Are Promises Presented?

### Promise Card (the core UI unit)

Every promise appears as a card with:

```
┌─────────────────────────────────────────────────┐
│  [BROKEN] ●                          Housing    │
│                                                 │
│  "We will deliver 33,000 homes per year"        │
│                                                 │
│  Taoiseach · Ireland                            │
│  Made: Oct 2020  ·  Deadline: Dec 2025          │
│                                                 │
│  ██████████░░░░  3 sources  ·  7 evidence       │
│                                                 │
│  ▲ 142 important   ⚑ Flag   + Add evidence     │
└─────────────────────────────────────────────────┘
```

- **Status badge**: Color-coded pill (green=kept, red=broken, yellow=in progress, grey=expired, blue=pivoted)
- **Exact quote**: The promise in their own words
- **Who + where**: Entity name, title, jurisdiction
- **Timeline bar**: Visual progress from date-made to deadline
- **Evidence count**: How well-sourced is this promise?
- **Community actions**: Vote importance, flag inaccuracies, add evidence

### Promise Detail Page

Expands to show:
- Full context and background
- **Evidence chain**: Timeline of every source and outcome, oldest to newest
- Status history (every change with reason and who changed it)
- Related promises (same entity, same category)
- Comments/discussion

### Actor Scorecard Page

```
┌─────────────────────────────────────────────────┐
│  [Photo]  Mary Lou McDonald TD                  │
│           Sinn Fein · Dublin Central            │
│                                                 │
│  Overall Score: 67/100                          │
│  ████████████████░░░░░░░░                       │
│                                                 │
│  Follow-through: 72%  |  Precision: 61%         │
│  Transparency:   58%  |  Promises tracked: 34   │
│                                                 │
│  -- By Category ──────────────────────────       │
│  Housing         ████████████████████  85%       │
│  Health (HSE)    ████████████░░░░░░░  62%       │
│  Cost of Living  ████████░░░░░░░░░░░  41%       │
│                                                 │
│  -- Status Breakdown ─────────────────────       │
│  Kept: 14  In Progress: 8  Broken: 5            │
│  Compromised: 3  Pivoted: 2  Expired: 2         │
└─────────────────────────────────────────────────┘
```

### Leaderboard Page

Sortable table with columns:
- Rank, Name, Type, Jurisdiction, Score, Promises Tracked, Trend (90-day)
- Filterable by everything (see Search below)

---

## Search & Filtering

### Search Bar (global, on every page)

Full-text + fuzzy search using PostgreSQL `pg_trgm`. Searches across:
- Promise quotes and summaries
- Entity names
- Evidence titles

Returns grouped results: "3 actors, 12 promises, 5 evidence items"

### Filter Dimensions

Users can filter by any combination of:

| Filter | Values | UI Element |
|---|---|---|
| **Country / Jurisdiction** | Ireland, EU, France, Germany, Spain, Italy, Netherlands, Poland, etc. | Dropdown with search |
| **Level** | National, EU, Local/County, European Parliament | Toggle chips |
| **Entity Type** | Politician/TD/MEP, Minister, CEO/Executive, Institution, Government Agency, EU Body | Toggle chips |
| **Political Party** | Fianna Fail, Fine Gael, Sinn Fein, Labour, Social Democrats, Greens, PBP-Solidarity, Aontu, Independents, EPP, S&D, Renew, Greens/EFA, etc. | Dropdown (contextual to jurisdiction) |
| **Specific Person/Org** | Any tracked entity | Autocomplete search |
| **Category** | Housing, Health/HSE, Cost of Living, Climate, Transport, Education, Agriculture, Justice, Foreign Affairs, EU Policy, Corporate Governance, Technology, Immigration | Multi-select chips |
| **Status** | Made, In Progress, Kept, Broken, Compromised, Pivoted, Expired, Disputed | Status badge toggles |
| **Specificity** | Precise, Measurable, Vague, Aspirational | Slider or toggles |
| **Date Range** | When the promise was made | Date picker |
| **Deadline** | Upcoming, Overdue, No deadline | Quick filter buttons |
| **Sort By** | Most recent, Score, Most voted, Most evidence, Deadline approaching | Dropdown |

### Example Queries Users Can Run

- **"Show me all broken promises on housing by the current government"**
  → Jurisdiction: Ireland, Category: Housing, Status: Broken, Date: 2024+

- **"How are Irish MEPs doing on climate commitments in Europe?"**
  → Jurisdiction: EU, Entity Type: MEP, Category: Climate, Party: (Irish parties)

- **"What did Fianna Fail promise in their last manifesto?"**
  → Party: Fianna Fail, Source: Campaign manifesto

- **"Which EU Commissioners have the worst follow-through?"**
  → Jurisdiction: EU, Entity Type: Commissioner, Sort: Score ascending

- **"What promises have a deadline before the next general election?"**
  → Deadline: custom range, Sort: Deadline approaching

- **"Compare all party leaders on health"**
  → Category: Health/HSE, specific entities selected, side-by-side view

### URL Structure (shareable, bookmarkable)

Every filter combination produces a clean URL:

```
/promises?jurisdiction=ireland&category=housing&status=broken
/actors?type=td&party=fine-gael&sort=score-asc
/leaderboard?jurisdiction=eu&type=mep
/actors/uuid-here?category=health
```

### Comparison Mode

Select 2-4 actors and see them side-by-side:
- Score gauges next to each other
- Same-category promises aligned
- "Who promised what on X?" view

```
/compare?actors=uuid1,uuid2&category=housing
```

---

## Data Integrity

- Every promise must have at least one `promise_source` evidence record
- All source URLs are auto-archived to the Wayback Machine
- Evidence records include `file_hash` (SHA-256) for tamper detection
- Every status change is logged in `timeline_events` with the reason and who changed it
- Community submissions are moderated before entering the main dataset
- Editors and admins have reputation scores; their actions are auditable
