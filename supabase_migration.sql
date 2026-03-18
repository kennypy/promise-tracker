-- ============================================================
-- Promise Tracker — Supabase Migration
-- Run this in Supabase SQL Editor to set up the database
-- ============================================================

-- 1. ENTITIES TABLE
CREATE TABLE IF NOT EXISTS entities (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  name TEXT NOT NULL,
  title TEXT,
  party TEXT,
  entity_type TEXT NOT NULL DEFAULT 'politician',
  active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 2. PROMISES TABLE
CREATE TABLE IF NOT EXISTS promises (
  id TEXT PRIMARY KEY DEFAULT gen_random_uuid()::text,
  entity_id TEXT NOT NULL REFERENCES entities(id),
  summary TEXT NOT NULL,
  quote TEXT,
  context TEXT,
  date_made DATE,
  deadline DATE,
  category TEXT,
  status TEXT NOT NULL DEFAULT 'made',
  magnitude INTEGER DEFAULT 5 CHECK (magnitude >= 1 AND magnitude <= 10),
  specificity TEXT DEFAULT 'measurable',
  tags TEXT[] DEFAULT '{}',
  outcome_summary TEXT,
  verified BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- 3. ROW LEVEL SECURITY (allow public read, authenticated insert)
ALTER TABLE entities ENABLE ROW LEVEL SECURITY;
ALTER TABLE promises ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can read entities" ON entities FOR SELECT USING (true);
CREATE POLICY "Anyone can read promises" ON promises FOR SELECT USING (true);
CREATE POLICY "Anyone can insert promises" ON promises FOR INSERT WITH CHECK (true);

-- 4. REALTIME (enable for live updates)
ALTER PUBLICATION supabase_realtime ADD TABLE entities;
ALTER PUBLICATION supabase_realtime ADD TABLE promises;

-- 5. SEED ENTITIES
INSERT INTO entities (id, name, title, party, entity_type) VALUES
  ('e-mm',  'Micheál Martin',       'Taoiseach / Tánaiste',                  'Fianna Fail',       'politician'),
  ('e-lv',  'Leo Varadkar',         'Taoiseach / Tánaiste',                  'Fine Gael',         'politician'),
  ('e-er',  'Eamon Ryan',           'Minister for Climate & Transport',      'Green Party',        'politician'),
  ('e-dob', 'Darragh O''Brien',     'Minister for Housing',                  'Fianna Fail',       'politician'),
  ('e-sd',  'Stephen Donnelly',     'Minister for Health',                   'Fianna Fail',       'politician'),
  ('e-pd',  'Paschal Donohoe',      'Minister for Finance',                  'Fine Gael',         'politician'),
  ('e-rog', 'Roderic O''Gorman',    'Minister for Children & Integration',   'Green Party',        'politician'),
  ('e-hh',  'Heather Humphreys',    'Minister for Social Protection',        'Fine Gael',         'politician'),
  ('e-hm',  'Helen McEntee',        'Minister for Justice',                  'Fine Gael',         'politician'),
  ('e-nf',  'Norma Foley',          'Minister for Education',                'Fianna Fail',       'politician'),
  ('e-sh',  'Simon Harris',         'Taoiseach / Minister for Higher Ed',    'Fine Gael',         'politician'),
  ('e-cmc', 'Charlie McConalogue',  'Minister for Agriculture',              'Fianna Fail',       'politician'),
  ('e-sc',  'Sláintecare Committee','Cross-party Health Reform',              NULL,                'institution'),
  ('e-gov', 'Government of Ireland','Executive',                              NULL,                'institution')
ON CONFLICT (id) DO NOTHING;

-- 6. SEED PROMISES (all 45 from the research)
INSERT INTO promises (id, entity_id, summary, quote, context, date_made, deadline, category, status, magnitude, tags, outcome_summary) VALUES
  ('p1','e-er','Achieve 51% emissions reduction by 2030 (7%/year)','An average 7% per annum reduction in overall greenhouse gas emissions from 2021 to 2030','Programme for Government 2020','2020-06-15','2030-12-31','climate','broken',10,ARRAY['climate','emissions','carbon budget'],'Ireland blew its first carbon budget, overshooting by ~10 Mt CO2eq. EPA projects only 22% reduction achievable by 2030.'),
  ('p2','e-er','Introduce Climate Action Bill within 100 days','Introduce Climate Action Bill establishing a Climate Action Council and net zero by 2050 in law','Programme for Government 2020','2020-06-15','2020-10-15','climate','kept',8,ARRAY['climate','legislation'],'Climate Action and Low Carbon Development (Amendment) Act 2021 enacted. Slightly behind 100-day target but delivered.'),
  ('p3','e-er','Retrofit 500,000 homes to BER B2 by 2030','Retrofit 500,000 homes to a BER rating of B2 or equivalent by 2030','Programme for Government / Climate Action Plan 2021','2020-06-15','2030-12-31','climate','stalled',9,ARRAY['retrofit','housing','climate'],'Only ~58,000 homes retrofitted (11.5% of target). Would need 75,000/year from 2026-2030.'),
  ('p4','e-er','Ban new petrol/diesel cars after 2030','Ban registration of new petrol and diesel cars after 2030','Programme for Government 2020','2020-06-15','2030-12-31','climate','compromised',7,ARRAY['EVs','transport','climate'],'At COP26, Ryan signed declaration for 2040 instead. EU rules now target 2035.'),
  ('p5','e-mm','Increase carbon tax to €100/tonne by 2030','Increase carbon tax to €100 per tonne by 2030','Programme for Government 2020','2020-06-15','2030-12-31','climate','in_progress',7,ARRAY['carbon tax','finance'],'Rising annually by €7.50 as planned. From €26/tonne (2020) to €56/tonne (2024). On track.'),
  ('p6','e-er','20% transport budget for cycling & walking','Allocate 20% of the transport capital budget to cycling and walking infrastructure','Programme for Government 2020','2020-06-15','2025-06-27','transport','kept',7,ARRAY['cycling','walking','active travel'],'Budget 2026 allocated €362.6m. Over 1,000km of active travel routes delivered.'),
  ('p7','e-er','Maintain 2:1 public transport over roads spending','Maintain 2:1 spending ratio on public transport over roads','Programme for Government 2020','2020-06-15','2025-06-27','transport','compromised',6,ARRAY['transport','roads'],'2020-2024 broadly maintained. New government plan nearly 50:50.'),
  ('p8','e-er','End all new oil & gas exploration','End all new oil and gas exploration in Irish waters','Programme for Government 2020','2020-06-15',NULL,'climate','kept',7,ARRAY['oil','gas','exploration'],'No new exploration licences issued. Policy enacted.'),
  ('p9','e-rog','End Direct Provision system','End Direct Provision system for asylum seekers','Programme for Government / White Paper 2021','2020-06-15','2024-12-31','social','broken',9,ARRAY['asylum','direct provision','immigration'],'System remains in place in 2026. Plan shelved citing housing crisis.'),
  ('p10','e-hh','No increase in State pension age to 67','No increase in the State pension age to 67 in 2021','Programme for Government 2020','2020-06-15','2021-01-01','social','kept',8,ARRAY['pensions','social protection'],'Pension age increase successfully deferred.'),
  ('p11','e-hm','Establish a gambling regulator','Establish a gambling regulator within the lifetime of the government','Programme for Government 2020','2020-06-15','2025-06-27','governance','kept',5,ARRAY['gambling','regulation'],'GRAI established 5 March 2025.'),
  ('p12','e-hh','Introduce auto-enrolment pension scheme','Introduce auto-enrolment pension savings scheme for workers','Programme for Government 2020','2020-06-15','2025-01-01','social','compromised',7,ARRAY['pensions','auto-enrolment'],'My Future Fund launched Jan 2026 — a year late. ~800,000 enrolled.'),
  ('p13','e-sd','Free contraception phased rollout','Introduce free contraception starting with women aged 17-25','Programme for Government 2020','2020-06-15',NULL,'health','kept',6,ARRAY['contraception','health','women'],'Launched Sep 2022. Expanded to age 35. Over 189,000 accessed in 2023.'),
  ('p14','e-nf','Reduce pupil-teacher ratio to 20:1','Reduce pupil-teacher ratios from 26:1 to 20:1 by 2025','Programme for Government 2020','2020-06-15','2025-12-31','education','compromised',6,ARRAY['education','class sizes'],'Reduced to 23:1 by 2024 but 20:1 not achieved.'),
  ('p15','e-sh','No increase in third-level fees','No increase in third-level fees','Programme for Government 2020','2020-06-15','2025-06-27','education','kept',6,ARRAY['education','fees','students'],'Student contribution reduced from €3,000 to €2,000.'),
  ('p16','e-pd','Retain 12.5% corporation tax rate','Retain the 12.5% corporation tax rate','Programme for Government 2020','2020-06-15',NULL,'economy','compromised',8,ARRAY['tax','corporate','OECD'],'Joined OECD global minimum tax deal (15% for large companies).'),
  ('p17','e-dob','Deliver 300,000 homes by 2030','Deliver 300,000 homes by 2030 (average 33,000 per year)','Housing for All 2021','2021-09-02','2030-12-31','housing','stalled',10,ARRAY['housing','construction'],'137,000 built since 2021. Starts collapsed early 2025.'),
  ('p18','e-dob','Deliver 90,000 social housing units by 2030','Deliver 90,000 social housing units between 2022 and 2030','Housing for All 2021','2021-09-02','2030-12-31','housing','stalled',9,ARRAY['social housing'],'Targets consistently missed. Heavy reliance on HAP.'),
  ('p19','e-dob','4,000 affordable purchase homes per year','Deliver average 4,000 affordable purchase homes per year','Housing for All 2021','2021-09-02','2030-12-31','housing','stalled',8,ARRAY['affordable housing'],'Delivery far below target.'),
  ('p20','e-dob','2,000 cost rental homes per year','Deliver 2,000 cost rental homes per year','Housing for All 2021','2021-09-02','2030-12-31','housing','stalled',7,ARRAY['cost rental','housing'],'Hundreds rather than thousands per year delivered.'),
  ('p21','e-dob','Increase Part V requirement to 20%','Increase Part V requirement from 10% to 20%','Housing for All 2021','2021-09-02','2026-01-01','housing','kept',6,ARRAY['Part V','planning'],'Legislated as promised.'),
  ('p22','e-dob','Deliver 40,000 new homes in 2024','Deliver 40,000 new homes in 2024','Government statements','2021-09-02','2024-12-31','housing','broken',9,ARRAY['housing','targets'],'Actual completions ~30,000. Major election issue.'),
  ('p23','e-sc','Max 12-week wait for procedures','No patient should wait longer than 12 weeks for inpatient procedure','Sláintecare Report','2017-05-30','2027-12-31','health','broken',10,ARRAY['health','waiting lists'],'547,000 patients waiting as of March 2025.'),
  ('p24','e-sc','Max 4-hour wait in emergency departments','No patient should wait longer than 4 hours in an ED','Sláintecare Report','2017-05-30','2027-12-31','health','broken',9,ARRAY['health','trolley crisis','ED'],'Trolley crisis continues.'),
  ('p25','e-sd','Six surgical hubs & four elective centres','Establish six surgical hubs and four elective treatment centres','Sláintecare Implementation Plan','2021-06-01','2027-12-31','health','in_progress',7,ARRAY['health','hospitals'],'One Dublin site operational. Others in planning.'),
  ('p26','e-sd','Six new HSE Health Regions','Establish six new HSE Health Regions','Sláintecare Implementation Plan','2021-06-01','2024-03-31','health','kept',5,ARRAY['health','HSE reform'],'Six regions commenced March 2024. On time.'),
  ('p27','e-sc','Deliver universal healthcare','Move toward a single-tier system based on need','Sláintecare Report 2017','2017-05-30','2027-12-31','health','stalled',10,ARRAY['universal healthcare','two-tier'],'58% lack free primary care. Two-tier system persists.'),
  ('p28','e-sd','Free GP care for children under 8','Extend free GP care to all children under 8','Programme for Government / Sláintecare','2020-06-15','2025-12-31','health','kept',6,ARRAY['GP','children','health'],'Extended to ages 6-7 in 2023.'),
  ('p29','e-er','80% electricity from renewables by 2030','Generate 80% of electricity from renewables including 5GW offshore wind','Climate Action Plan 2021','2021-11-04','2030-12-31','climate','stalled',9,ARRAY['renewables','offshore wind','solar'],'Renewables at ~40% in 2024. No offshore wind farm built yet.'),
  ('p30','e-er','Install 600,000 heat pumps by 2030','Install 600,000 heat pumps in residential buildings by 2030','Climate Action Plan 2021','2021-11-04','2030-12-31','climate','stalled',7,ARRAY['heat pumps','retrofit'],'Growing but far below rate needed.'),
  ('p31','e-er','500,000 extra active travel journeys/day','Enable 500,000 extra walking, cycling and public transport journeys per day','Climate Action Plan 2021','2021-11-04','2030-12-31','transport','in_progress',6,ARRAY['cycling','walking','public transport'],'1,000+ km delivered. Bike trips up 23%.'),
  ('p32','e-er','Nearly 1 million EVs by 2030','Reach nearly 1 million electric vehicles on Irish roads by 2030','Climate Action Plan 2021','2021-11-04','2030-12-31','climate','stalled',7,ARRAY['EVs','electric vehicles'],'~18% of new sales electric. Far below trajectory.'),
  ('p33','e-er','Deliver MetroLink','Deliver MetroLink from Swords to Charlemont with 16 stations','NDP 2021-2030','2021-10-04',NULL,'infrastructure','stalled',10,ARRAY['MetroLink','Dublin','rail'],'First proposed 2005. Planning permission Oct 2025. Completion maybe 2034. Cost €7bn-€23bn.'),
  ('p34','e-er','Complete BusConnects corridors by 2030','Complete BusConnects core bus corridors substantially by 2030','NDP 2021-2030','2021-10-04','2030-12-31','infrastructure','in_progress',7,ARRAY['BusConnects','Dublin','bus'],'Four Dublin routes planned for completion by 2030.'),
  ('p35','e-er','Deliver DART+ programme','Double capacity and treble electrification of Dublin rail','NDP 2021-2030','2021-10-04','2030-12-31','infrastructure','stalled',8,ARRAY['DART','rail','Dublin'],'New trains delayed to Q2 2027. South West pushed back 4 years. 1984 fleet still running.'),
  ('p36','e-sd','Complete National Children''s Hospital','Complete the National Children''s Hospital','NDP / Health Capital Programme','2017-04-01','2024-12-31','infrastructure','broken',10,ARRAY['hospital','children','overrun'],'Cost: €2.24bn (was €650m). Failed deadline 15 times. Earliest patients June 2026.'),
  ('p37','e-dob','Eradicate homelessness','Eradicate homelessness through Housing for All pathways','Housing for All 2021','2021-09-02','2030-12-31','housing','broken',10,ARRAY['homelessness'],'Record: 16,766 in emergency accommodation Oct 2025, including 5,274 children.'),
  ('p38','e-dob','Deliver 50,000 additional social homes','Deliver 50,000 additional social homes over government term','Programme for Government 2020','2020-06-15','2025-06-27','housing','compromised',8,ARRAY['social housing','HAP'],'Relied on HAP/leasing/acquisitions rather than new-build.'),
  ('p39','e-rog','Reduce childcare costs with fee cap','Reduce the cost of childcare with a potential cap on creche fees','Programme for Government 2020','2020-06-15','2025-06-27','social','in_progress',7,ARRAY['childcare','costs'],'Subsidies increased. Costs reduced but still among most expensive OECD.'),
  ('p40','e-lv','Raise higher rate tax entry to €50,000','Raise the higher rate income tax entry point to €50,000','Fine Gael policy','2020-06-15','2025-06-27','economy','compromised',6,ARRAY['tax','income'],'Only reached ~€42,000 by 2024.'),
  ('p41','e-mm','Cut Capital Gains Tax to 25%','Cut Capital Gains Tax to 25%','Fianna Fáil policy','2020-06-15','2025-06-27','economy','broken',6,ARRAY['CGT','tax'],'CGT remained at 33%. Never implemented.'),
  ('p42','e-cmc','Increase organic farmland to 450,000 hectares','Increase land farmed organically to 450,000 hectares by 2030','Climate Action Plan 2021','2021-11-04','2030-12-31','climate','stalled',6,ARRAY['agriculture','organic'],'Only ~120,000 hectares currently.'),
  ('p43','e-cmc','Reduce chemical fertiliser to 300,000 tonnes/yr','Reduce agricultural chemical nitrogen fertiliser use to 300,000 tonnes per year','Climate Action Plan 2021','2021-11-04','2030-12-31','climate','in_progress',6,ARRAY['agriculture','fertiliser','emissions'],'Declining but progress "particularly slow" per EPA.'),
  ('p44','e-er','1,500 electric buses by 2030','Deliver 1,500 electric buses by 2030','Climate Action Plan 2021','2021-11-04','2030-12-31','transport','in_progress',5,ARRAY['electric buses','public transport'],'First fully electric buses in Dublin. Pace behind target.'),
  ('p45','e-gov','Invest €165 billion in infrastructure 2021-2030','Invest €165 billion in public infrastructure from 2021 to 2030','NDP 2021-2030','2021-10-04','2030-12-31','infrastructure','in_progress',8,ARRAY['NDP','infrastructure','spending'],'2026-2030 allocations increased to €102.4bn. Delivery plagued by delays.')
ON CONFLICT (id) DO NOTHING;
