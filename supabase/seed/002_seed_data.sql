-- Promise Tracker: Seed Data
-- Real promises from Irish government, 2020-2025
-- Sources: Programme for Government 2020, Housing for All 2021,
--          Climate Action Plan 2024, Slaintecare, Budget speeches

-- ============================================================
-- ENTITIES: Irish political figures and institutions
-- ============================================================

INSERT INTO entities (id, name, entity_type, title, jurisdiction, party, organization, active) VALUES

-- Taoiseach / Former Taoisigh
('a0000001-0000-0000-0000-000000000001', 'Simon Harris',       'td',       'Taoiseach',                    'ireland',  'Fine Gael',        'Government of Ireland', true),
('a0000001-0000-0000-0000-000000000002', 'Leo Varadkar',       'td',       'Former Taoiseach / Tanaiste',  'ireland',  'Fine Gael',        'Government of Ireland', true),
('a0000001-0000-0000-0000-000000000003', 'Micheal Martin',     'td',       'Former Taoiseach / Tanaiste',  'ireland',  'Fianna Fail',      'Government of Ireland', true),

-- Key Ministers
('a0000001-0000-0000-0000-000000000004', 'Darragh O''Brien',   'minister', 'Minister for Housing',         'ireland',  'Fianna Fail',      'Department of Housing', true),
('a0000001-0000-0000-0000-000000000005', 'Eamon Ryan',         'minister', 'Former Minister for Transport, Environment & Climate', 'ireland', 'Green Party', 'Department of Transport', true),
('a0000001-0000-0000-0000-000000000006', 'Stephen Donnelly',   'minister', 'Former Minister for Health',   'ireland',  'Fianna Fail',      'Department of Health', true),
('a0000001-0000-0000-0000-000000000007', 'Paschal Donohoe',    'minister', 'Minister for Finance',         'ireland',  'Fine Gael',        'Department of Finance', true),
('a0000001-0000-0000-0000-000000000008', 'Michael McGrath',    'commissioner', 'EU Commissioner',          'eu',       'Fianna Fail',      'European Commission', true),

-- Opposition leaders
('a0000001-0000-0000-0000-000000000009', 'Mary Lou McDonald',  'td',       'President of Sinn Fein',       'ireland',  'Sinn Fein',        'Sinn Fein', true),
('a0000001-0000-0000-0000-000000000010', 'Ivana Bacik',        'td',       'Leader of the Labour Party',   'ireland',  'Labour',           'Labour Party', true),
('a0000001-0000-0000-0000-000000000011', 'Holly Cairns',       'td',       'Leader of the Social Democrats','ireland', 'Social Democrats', 'Social Democrats', true),

-- Institutions
('a0000001-0000-0000-0000-000000000020', 'Government of Ireland',       'institution', NULL,              'ireland',  NULL,  'Government of Ireland', true),
('a0000001-0000-0000-0000-000000000021', 'HSE',                         'agency',      NULL,              'ireland',  NULL,  'Health Service Executive', true),
('a0000001-0000-0000-0000-000000000022', 'European Commission',         'institution', NULL,              'eu',       NULL,  'European Commission', true);


-- ============================================================
-- PROMISES: Real, trackable commitments
-- ============================================================

-- ──────────────────────────────────────────────
-- HOUSING
-- ──────────────────────────────────────────────

INSERT INTO promises (id, entity_id, quote, summary, context, date_made, deadline, implied_deadline, status, specificity, category, tags, magnitude, outcome_summary, verified) VALUES

-- Housing for All targets
('b0000001-0000-0000-0000-000000000001',
 'a0000001-0000-0000-0000-000000000020',
 'The Government''s Housing Plan – Housing for All commits to an average of 33,000 homes per year up to 2030, including an average of 10,000 social homes, 4,000 affordable purchase homes and 2,000 cost rental homes per year.',
 'Deliver an average of 33,000 new homes per year to 2030',
 'Housing for All plan launched September 2021 as the government''s flagship housing strategy. Ireland was in the middle of a severe housing crisis with record homelessness.',
 '2021-09-02', '2030-12-31', NULL,
 'compromised', 'precise', 'housing',
 ARRAY['housing-for-all', 'construction', 'targets'],
 10,
 'Housing completions have consistently fallen short of the 33,000 target. 2022: ~30,000. 2023: ~32,000. Social and affordable targets significantly missed. Homelessness continued to rise to record levels.',
 true),

('b0000001-0000-0000-0000-000000000002',
 'a0000001-0000-0000-0000-000000000004',
 'We will end the use of hotels and B&Bs for homeless families.',
 'End use of hotels and B&Bs for homeless families',
 'Repeated commitment from Minister O''Brien during Housing for All launch and subsequent Dail debates.',
 '2021-09-02', NULL, 'by end of government term',
 'broken', 'measurable', 'housing',
 ARRAY['homelessness', 'emergency-accommodation'],
 9,
 'Hotels and B&Bs remain widely used for homeless families. Homelessness figures reached record highs exceeding 14,000 people in 2024.',
 true),

('b0000001-0000-0000-0000-000000000003',
 'a0000001-0000-0000-0000-000000000020',
 'A new affordable purchase scheme will be put in place, with a target of delivering affordable homes on State lands.',
 'Deliver affordable purchase homes on State lands',
 'Programme for Government 2020 and Housing for All plan.',
 '2020-06-15', NULL, 'during government term',
 'stalled', 'vague', 'housing',
 ARRAY['affordable-housing', 'state-lands'],
 8,
 'Very limited delivery of affordable purchase homes. The Land Development Agency was slow to begin construction. First completions trickled out years behind schedule.',
 true),

('b0000001-0000-0000-0000-000000000004',
 'a0000001-0000-0000-0000-000000000020',
 'A Commission on Housing will be established within the first 6 months to examine issues such as land availability, the cost of construction, and the provision of social and affordable housing.',
 'Establish a Commission on Housing within 6 months',
 'Programme for Government, June 2020.',
 '2020-06-15', '2020-12-15', 'within the first 6 months',
 'kept', 'precise', 'housing',
 ARRAY['commission', 'housing-policy'],
 4,
 'The Housing Commission was established, chaired by John O''Connor. It produced reports on housing policy reform.',
 true),

('b0000001-0000-0000-0000-000000000005',
 'a0000001-0000-0000-0000-000000000020',
 'Introduce a referendum on housing, as recommended by the Housing Commission.',
 'Hold a referendum on the right to housing',
 'Programme for Government commitment, later supported by Housing Commission recommendation.',
 '2020-06-15', NULL, 'during government term',
 'kept', 'measurable', 'housing',
 ARRAY['referendum', 'right-to-housing', 'constitutional'],
 7,
 'The housing referendum was held on 8 March 2024. However, it was defeated by voters, partly blamed on poor wording by the government.',
 true),

-- ──────────────────────────────────────────────
-- HEALTH & HSE
-- ──────────────────────────────────────────────

('b0000001-0000-0000-0000-000000000010',
 'a0000001-0000-0000-0000-000000000006',
 'Slaintecare will be fully implemented... delivering universal healthcare based on need rather than ability to pay.',
 'Fully implement Slaintecare universal healthcare',
 'Programme for Government 2020. Slaintecare was the cross-party Oireachtas committee plan for health reform, agreed in 2017.',
 '2020-06-15', '2030-12-31', 'within ten years',
 'stalled', 'vague', 'health',
 ARRAY['slaintecare', 'universal-healthcare', 'reform'],
 10,
 'Slaintecare implementation has been beset by delays. The Slaintecare Implementation Office head Laura Magahy resigned in 2021 citing lack of government commitment. Key pillars like removing private practice from public hospitals have not been achieved.',
 true),

('b0000001-0000-0000-0000-000000000011',
 'a0000001-0000-0000-0000-000000000006',
 'We will reduce hospital waiting lists significantly and ensure no patient waits longer than 12 months for treatment.',
 'No patient waiting longer than 12 months for hospital treatment',
 'Commitment made by Minister Donnelly, echoing Slaintecare targets.',
 '2020-06-15', NULL, 'during government term',
 'broken', 'measurable', 'health',
 ARRAY['waiting-lists', 'hospitals', 'slaintecare'],
 9,
 'Hospital waiting lists remained at record levels. As of 2024, over 900,000 people were on some form of hospital waiting list, with many waiting well over 12 months.',
 true),

('b0000001-0000-0000-0000-000000000012',
 'a0000001-0000-0000-0000-000000000020',
 'Free GP care will be extended to all children aged 6 and 7.',
 'Extend free GP care to children aged 6 and 7',
 'Programme for Government 2020, as part of phased expansion of free GP care.',
 '2020-06-15', NULL, 'during government term',
 'kept', 'precise', 'health',
 ARRAY['gp-care', 'children', 'free-healthcare'],
 6,
 'Free GP care was extended to children aged 6 and 7 in 2022-2023, and subsequently extended further to all children under 8.',
 true),

('b0000001-0000-0000-0000-000000000013',
 'a0000001-0000-0000-0000-000000000020',
 'The new National Maternity Hospital will be built on the St Vincent''s campus at Elm Park.',
 'Build the new National Maternity Hospital at Elm Park',
 'Long-running project to replace Holles Street. Controversy over religious ownership of the St Vincent''s site.',
 '2020-06-15', NULL, 'during government term',
 'in_progress', 'precise', 'health',
 ARRAY['national-maternity-hospital', 'holles-street', 'construction'],
 8,
 'After years of controversy over ownership and religious ethos, construction finally began. The project has been repeatedly delayed and costs have escalated significantly.',
 true),

('b0000001-0000-0000-0000-000000000014',
 'a0000001-0000-0000-0000-000000000020',
 'We will deliver new emergency department capacity and reduce overcrowding in hospitals.',
 'Reduce emergency department overcrowding',
 'Programme for Government 2020.',
 '2020-06-15', NULL, 'during government term',
 'broken', 'measurable', 'health',
 ARRAY['emergency-departments', 'overcrowding', 'trolley-crisis'],
 9,
 'ED overcrowding worsened during the government''s term. Record numbers of patients on trolleys were recorded in 2023 and 2024. INMO trolley watch figures consistently showed crisis-level overcrowding.',
 true),

-- ──────────────────────────────────────────────
-- CLIMATE & ENERGY
-- ──────────────────────────────────────────────

('b0000001-0000-0000-0000-000000000020',
 'a0000001-0000-0000-0000-000000000005',
 'Ireland will halve its greenhouse gas emissions by 2030 and reach net zero no later than 2050.',
 'Halve greenhouse gas emissions by 2030',
 'Climate Action and Low Carbon Development (Amendment) Act 2021, championed by Minister Ryan.',
 '2021-07-23', '2030-12-31', NULL,
 'compromised', 'precise', 'climate',
 ARRAY['emissions', 'climate-act', 'net-zero', '2030-target'],
 10,
 'Ireland is significantly off track to meet its 51% emissions reduction target by 2030. EPA projections consistently show Ireland will fall far short. Agriculture emissions remain particularly resistant to reduction.',
 true),

('b0000001-0000-0000-0000-000000000021',
 'a0000001-0000-0000-0000-000000000005',
 'We will retrofit 500,000 homes to a B2 energy rating by 2030, with a target of 120,000 free upgrades for those in energy poverty.',
 'Retrofit 500,000 homes to B2 energy rating by 2030',
 'Climate Action Plan 2021 and National Retrofit Plan.',
 '2021-11-04', '2030-12-31', NULL,
 'compromised', 'precise', 'climate',
 ARRAY['retrofitting', 'energy-efficiency', 'homes', 'insulation'],
 8,
 'Retrofit rates have been well below the roughly 75,000 per year needed to hit 500,000 by 2030. SEAI completed roughly 35,000-40,000 upgrades per year. Contractors, costs, and planning bottlenecks have slowed progress.',
 true),

('b0000001-0000-0000-0000-000000000022',
 'a0000001-0000-0000-0000-000000000005',
 'No new licences for exploration or extraction of gas or oil will be issued.',
 'Ban new fossil fuel exploration licences',
 'Programme for Government 2020.',
 '2020-06-15', NULL, NULL,
 'kept', 'precise', 'climate',
 ARRAY['fossil-fuels', 'gas', 'oil', 'exploration'],
 7,
 'The government followed through on this commitment. No new fossil fuel exploration licences were issued. The policy was legislated.',
 true),

('b0000001-0000-0000-0000-000000000023',
 'a0000001-0000-0000-0000-000000000020',
 'Ireland will generate up to 80% of its electricity from renewable sources by 2030.',
 '80% renewable electricity by 2030',
 'Climate Action Plan target.',
 '2021-11-04', '2030-12-31', NULL,
 'in_progress', 'precise', 'climate',
 ARRAY['renewables', 'electricity', 'wind', 'solar'],
 9,
 'Ireland reached approximately 40% renewable electricity by 2024. Significant offshore wind capacity is planned but slow to deliver. On current trajectory, 80% by 2030 appears very ambitious.',
 true),

('b0000001-0000-0000-0000-000000000024',
 'a0000001-0000-0000-0000-000000000005',
 'We will end the sale of new petrol and diesel cars by 2030 and have nearly 1 million electric vehicles on the road.',
 'Ban new petrol/diesel car sales by 2030 and reach 1 million EVs',
 'Climate Action Plan. Later softened under EU-wide timeline changes.',
 '2021-11-04', '2030-12-31', NULL,
 'compromised', 'precise', 'transport',
 ARRAY['electric-vehicles', 'ev', 'cars', 'emissions'],
 8,
 'Ireland had approximately 100,000-120,000 EVs by end of 2024, far from the trajectory needed for 1 million by 2030. The EU-wide ban on new ICE car sales was pushed to 2035. Charging infrastructure remains patchy outside Dublin.',
 true),

-- ──────────────────────────────────────────────
-- TRANSPORT & INFRASTRUCTURE
-- ──────────────────────────────────────────────

('b0000001-0000-0000-0000-000000000030',
 'a0000001-0000-0000-0000-000000000005',
 'MetroLink will be delivered, providing high-frequency metro rail from Swords to Charlemont.',
 'Deliver MetroLink from Swords to Charlemont',
 'National Development Plan. MetroLink has been planned in various forms since the early 2000s.',
 '2021-10-04', '2034-12-31', NULL,
 'in_progress', 'precise', 'transport',
 ARRAY['metrolink', 'metro', 'dublin', 'rail'],
 9,
 'MetroLink received railway order approval in 2024. Construction expected to begin, but the project has been repeatedly re-scoped and delayed over two decades. Current estimated completion is early-to-mid 2030s.',
 true),

('b0000001-0000-0000-0000-000000000031',
 'a0000001-0000-0000-0000-000000000005',
 'BusConnects will redesign the bus network in Dublin, Cork, Galway, Limerick and Waterford.',
 'Deliver BusConnects network redesign in five cities',
 'National Development Plan and Programme for Government.',
 '2020-06-15', NULL, 'during government term (phase 1)',
 'in_progress', 'measurable', 'transport',
 ARRAY['busconnects', 'bus', 'public-transport', 'dublin', 'cork'],
 7,
 'Dublin BusConnects new network launched in June 2024 after significant delays and public controversy over routes. Core Bus Corridors construction underway but behind schedule. Other cities are at earlier stages.',
 true),

('b0000001-0000-0000-0000-000000000032',
 'a0000001-0000-0000-0000-000000000020',
 'The National Broadband Plan will deliver high-speed broadband to every premises in Ireland.',
 'Deliver high-speed broadband to every premises via NBP',
 'National Broadband Plan, contract signed 2019. Programme for Government committed to delivery.',
 '2020-06-15', '2026-12-31', NULL,
 'in_progress', 'precise', 'technology',
 ARRAY['broadband', 'rural', 'national-broadband-plan', 'NBI'],
 8,
 'Rollout has been significantly slower than planned. NBI (National Broadband Ireland) has connected a fraction of the target premises. Costs have risen substantially. Originally due for completion by 2026 but expected to run well beyond that.',
 true),

('b0000001-0000-0000-0000-000000000033',
 'a0000001-0000-0000-0000-000000000020',
 'We will examine the extension of the DART network and progress the DART+ programme.',
 'Deliver DART+ expansion programme',
 'Programme for Government and National Development Plan. Includes DART+ West, DART+ South West, DART+ Coastal.',
 '2020-06-15', '2034-12-31', NULL,
 'in_progress', 'measurable', 'transport',
 ARRAY['dart', 'dart-plus', 'rail', 'dublin', 'commuter'],
 8,
 'DART+ Fleet procurement progressed with new train orders. DART+ West and South West received railway orders. Construction is underway but full completion is not expected until the early-to-mid 2030s.',
 true),

-- ──────────────────────────────────────────────
-- COST OF LIVING & ECONOMY
-- ──────────────────────────────────────────────

('b0000001-0000-0000-0000-000000000040',
 'a0000001-0000-0000-0000-000000000020',
 'We will introduce a Living Wage and move towards it becoming the minimum floor for wages.',
 'Introduce a statutory Living Wage',
 'Programme for Government 2020.',
 '2020-06-15', NULL, 'during government term',
 'kept', 'measurable', 'economy',
 ARRAY['living-wage', 'minimum-wage', 'workers'],
 7,
 'The government announced the phased introduction of a Living Wage, with the minimum wage increasing towards the living wage rate by 2026. Legislation was enacted.',
 true),

('b0000001-0000-0000-0000-000000000041',
 'a0000001-0000-0000-0000-000000000020',
 'Statutory Sick Pay will be introduced for all workers.',
 'Introduce statutory sick pay',
 'Programme for Government 2020. Ireland was one of the few EU countries without statutory sick pay.',
 '2020-06-15', NULL, 'during government term',
 'kept', 'precise', 'economy',
 ARRAY['sick-pay', 'workers-rights', 'employment'],
 6,
 'Statutory sick pay was introduced in 2022 starting at 3 days, increasing to 5 days in 2024, and 7 days in 2025, and will reach 10 days in 2026.',
 true),

('b0000001-0000-0000-0000-000000000042',
 'a0000001-0000-0000-0000-000000000020',
 'Auto-enrolment for pensions will be introduced to ensure all workers have access to a retirement savings scheme.',
 'Introduce auto-enrolment pension scheme',
 'Programme for Government 2020. Long-promised reform to address pension coverage gap.',
 '2020-06-15', '2024-12-31', 'by 2024',
 'compromised', 'precise', 'economy',
 ARRAY['pensions', 'auto-enrolment', 'retirement'],
 7,
 'Legislation was passed but the launch was delayed multiple times. Originally promised for 2024, then pushed back. The scheme has been enacted but actual enrolment of workers has been slower than committed.',
 true),

-- ──────────────────────────────────────────────
-- EDUCATION & CHILDCARE
-- ──────────────────────────────────────────────

('b0000001-0000-0000-0000-000000000050',
 'a0000001-0000-0000-0000-000000000020',
 'We will implement a new funding model for childcare, with the objective of delivering quality, accessible and affordable childcare.',
 'Reduce childcare costs and implement new funding model',
 'Programme for Government 2020.',
 '2020-06-15', NULL, 'during government term',
 'kept', 'measurable', 'education',
 ARRAY['childcare', 'early-years', 'affordability'],
 8,
 'The National Childcare Scheme was expanded significantly. The universal subsidy was increased substantially in Budget 2023, with fees reduced by up to 25% for many parents. Core funding model for providers introduced.',
 true),

('b0000001-0000-0000-0000-000000000051',
 'a0000001-0000-0000-0000-000000000020',
 'We will abolish college fees through a phased approach and reduce the student contribution charge.',
 'Reduce and eventually abolish college fees',
 'Programme for Government and various Fine Gael/Fianna Fail election commitments.',
 '2020-06-15', NULL, 'phased approach',
 'compromised', 'measurable', 'education',
 ARRAY['college-fees', 'third-level', 'student-contribution'],
 6,
 'The student contribution was reduced by EUR1,000 in Budget 2023 (from EUR3,000 to EUR2,000) but a full abolition has not been achieved or concretely planned.',
 true),

-- ──────────────────────────────────────────────
-- IMMIGRATION & DIRECT PROVISION
-- ──────────────────────────────────────────────

('b0000001-0000-0000-0000-000000000060',
 'a0000001-0000-0000-0000-000000000020',
 'A White Paper will be published to end the Direct Provision system and replace it with a new international protection accommodation policy, centred on a not-for-profit approach.',
 'End the Direct Provision system',
 'Programme for Government 2020. The White Paper was published in February 2021.',
 '2020-06-15', '2024-12-31', 'by end of 2024',
 'broken', 'measurable', 'immigration',
 ARRAY['direct-provision', 'asylum', 'international-protection'],
 9,
 'The Direct Provision system was not ended by the 2024 deadline. While the White Paper set out a plan, the arrival of significantly more international protection applicants from 2022 onward led the government to rely on emergency accommodation including tents and repurposed buildings. The system arguably worsened rather than improved.',
 true),

-- ──────────────────────────────────────────────
-- IRISH LANGUAGE & CULTURE
-- ──────────────────────────────────────────────

('b0000001-0000-0000-0000-000000000070',
 'a0000001-0000-0000-0000-000000000020',
 'The Official Languages (Amendment) Act will ensure that 20% of new recruits to the public service will be competent in the Irish language by 2030.',
 '20% of new public service recruits to be Irish speakers by 2030',
 'Official Languages (Amendment) Act 2021.',
 '2021-12-22', '2030-12-31', NULL,
 'in_progress', 'precise', 'gaeilge',
 ARRAY['irish-language', 'gaeilge', 'public-service', 'recruitment'],
 5,
 'Legislation enacted but actual recruitment of Irish speakers to public service has been slow. Many departments have struggled to meet interim targets.',
 true),

-- ──────────────────────────────────────────────
-- NORTHERN IRELAND
-- ──────────────────────────────────────────────

('b0000001-0000-0000-0000-000000000080',
 'a0000001-0000-0000-0000-000000000003',
 'The Shared Island initiative will deepen North-South cooperation and fund cross-border projects.',
 'Deliver Shared Island initiative for North-South cooperation',
 'Programme for Government 2020. EUR500 million Shared Island Fund established.',
 '2020-06-15', NULL, 'ongoing',
 'in_progress', 'measurable', 'northern-ireland',
 ARRAY['shared-island', 'north-south', 'cross-border'],
 6,
 'The Shared Island unit was established. Various cross-border projects funded including research, infrastructure studies, and community initiatives. Critics argue it has been more about studies than concrete delivery.',
 true),

-- ──────────────────────────────────────────────
-- JUSTICE & POLICING
-- ──────────────────────────────────────────────

('b0000001-0000-0000-0000-000000000090',
 'a0000001-0000-0000-0000-000000000020',
 'The Policing, Security and Community Safety Bill will provide for a new governance and oversight framework for An Garda Siochana.',
 'Reform Garda oversight with new policing legislation',
 'Programme for Government 2020. Long-awaited reform following various Garda controversies.',
 '2020-06-15', NULL, 'during government term',
 'kept', 'measurable', 'justice',
 ARRAY['gardai', 'policing', 'reform', 'oversight'],
 6,
 'The Policing, Security and Community Safety Act was enacted in 2024, establishing a new Policing and Community Safety Authority to replace GSOC and the Policing Authority.',
 true),

('b0000001-0000-0000-0000-000000000091',
 'a0000001-0000-0000-0000-000000000020',
 'An Garda Siochana will be increased to 15,000 members.',
 'Increase Garda numbers to 15,000',
 'Programme for Government commitment. Garda strength was approximately 14,000.',
 '2020-06-15', NULL, 'during government term',
 'broken', 'precise', 'justice',
 ARRAY['gardai', 'recruitment', 'policing'],
 6,
 'Garda numbers fell during the government''s term due to retirements outpacing recruitment. Strength dropped below 14,000. Recruitment challenges and Templemore training capacity were ongoing issues.',
 true),

-- ──────────────────────────────────────────────
-- AGRICULTURE
-- ──────────────────────────────────────────────

('b0000001-0000-0000-0000-000000000095',
 'a0000001-0000-0000-0000-000000000020',
 'The agriculture sector will achieve emissions reductions of 25% by 2030.',
 'Reduce agriculture emissions by 25% by 2030',
 'Carbon budget sectoral ceiling set under Climate Action Plan. Agriculture given the lowest reduction target of any sector.',
 '2022-07-28', '2030-12-31', NULL,
 'compromised', 'precise', 'agriculture',
 ARRAY['emissions', 'farming', 'carbon-budget', 'methane'],
 9,
 'Agriculture emissions have been essentially flat. The national herd reduction debate has been politically toxic. Voluntary measures have had minimal impact. EPA projections suggest Ireland will miss even the reduced 25% target.',
 true),

-- ──────────────────────────────────────────────
-- EU LEVEL
-- ──────────────────────────────────────────────

('b0000001-0000-0000-0000-000000000100',
 'a0000001-0000-0000-0000-000000000022',
 'The European Green Deal will make Europe the first climate-neutral continent by 2050, with an intermediate target of at least 55% net greenhouse gas emissions reduction by 2030.',
 'EU climate neutrality by 2050 with 55% reduction by 2030',
 'European Green Deal, championed by European Commission President von der Leyen.',
 '2019-12-11', '2030-12-31', NULL,
 'in_progress', 'precise', 'climate',
 ARRAY['european-green-deal', 'fit-for-55', 'climate-neutrality'],
 10,
 'Legislation passed (Fit for 55 package) but implementation across member states is uneven. Political pushback has grown, with some measures diluted. Overall EU emissions declining but pace questioned.',
 true),

('b0000001-0000-0000-0000-000000000101',
 'a0000001-0000-0000-0000-000000000022',
 'The Nature Restoration Law will ensure that at least 20% of the EU''s land and sea areas are restored by 2030.',
 'Restore 20% of EU land and sea areas by 2030',
 'EU Biodiversity Strategy and Nature Restoration Law. Faced significant opposition from farming lobby and EPP.',
 '2022-06-22', '2030-12-31', NULL,
 'in_progress', 'precise', 'climate',
 ARRAY['nature-restoration', 'biodiversity', 'eu-regulation'],
 8,
 'The Nature Restoration Law was narrowly passed in 2024 after intense political battles. Implementation has been contentious, with several member states pushing back on binding targets.',
 true);


-- ============================================================
-- EVIDENCE: Link promises to their sources
-- ============================================================

-- Housing for All document
INSERT INTO evidence (promise_id, evidence_type, role, url, title, publication, date_published, excerpt, verified) VALUES
('b0000001-0000-0000-0000-000000000001', 'official_document', 'promise_source',
 'https://www.gov.ie/en/publication/ef5ec-housing-for-all-a-new-housing-plan-for-ireland/',
 'Housing for All - A New Housing Plan for Ireland',
 'Government of Ireland', '2021-09-02',
 'The overall objective is to increase housing supply to an average of 33,000 per year over the next decade.',
 true),
('b0000001-0000-0000-0000-000000000002', 'official_document', 'promise_source',
 'https://www.gov.ie/en/publication/ef5ec-housing-for-all-a-new-housing-plan-for-ireland/',
 'Housing for All - A New Housing Plan for Ireland',
 'Government of Ireland', '2021-09-02',
 'End the use of hotels and B&Bs for homeless families through Housing First and increased social housing supply.',
 true);

-- Programme for Government
INSERT INTO evidence (promise_id, evidence_type, role, url, title, publication, date_published, excerpt, verified) VALUES
('b0000001-0000-0000-0000-000000000010', 'official_document', 'promise_source',
 'https://www.gov.ie/en/publication/7e05d-programme-for-government-our-shared-future/',
 'Programme for Government: Our Shared Future',
 'Government of Ireland', '2020-06-15',
 'Slaintecare will be fully implemented.',
 true),
('b0000001-0000-0000-0000-000000000040', 'official_document', 'promise_source',
 'https://www.gov.ie/en/publication/7e05d-programme-for-government-our-shared-future/',
 'Programme for Government: Our Shared Future',
 'Government of Ireland', '2020-06-15',
 'We will introduce a Living Wage.',
 true),
('b0000001-0000-0000-0000-000000000041', 'official_document', 'promise_source',
 'https://www.gov.ie/en/publication/7e05d-programme-for-government-our-shared-future/',
 'Programme for Government: Our Shared Future',
 'Government of Ireland', '2020-06-15',
 'Statutory Sick Pay will be introduced for all workers.',
 true),
('b0000001-0000-0000-0000-000000000060', 'official_document', 'promise_source',
 'https://www.gov.ie/en/publication/7e05d-programme-for-government-our-shared-future/',
 'Programme for Government: Our Shared Future',
 'Government of Ireland', '2020-06-15',
 'A White Paper to end the Direct Provision system.',
 true);

-- Climate Action Plan
INSERT INTO evidence (promise_id, evidence_type, role, url, title, publication, date_published, excerpt, verified) VALUES
('b0000001-0000-0000-0000-000000000020', 'legislation', 'promise_source',
 'https://www.irishstatutebook.ie/eli/2021/act/32/enacted/en/html',
 'Climate Action and Low Carbon Development (Amendment) Act 2021',
 'Irish Statute Book', '2021-07-23',
 'The State shall pursue the transition to a climate resilient, biodiversity-rich, environmentally sustainable and climate-neutral economy by 2050.',
 true),
('b0000001-0000-0000-0000-000000000021', 'official_document', 'promise_source',
 'https://www.gov.ie/en/publication/6223e-climate-action-plan-2021/',
 'Climate Action Plan 2021',
 'Government of Ireland', '2021-11-04',
 'Retrofit 500,000 homes to a BER of B2 or above and install 400,000 heat pumps by 2030.',
 true);

-- Outcome evidence examples
INSERT INTO evidence (promise_id, evidence_type, role, url, title, publication, date_published, excerpt, verified) VALUES
('b0000001-0000-0000-0000-000000000002', 'news_report', 'outcome_proof',
 'https://www.thejournal.ie/homeless-figures-ireland-2024/',
 'Homelessness figures reach record high',
 'TheJournal.ie', '2024-06-01',
 'The number of people in emergency accommodation has exceeded 14,000 for the first time.',
 true),
('b0000001-0000-0000-0000-000000000011', 'news_report', 'outcome_proof',
 'https://www.rte.ie/news/health/hospital-waiting-lists/',
 'Hospital waiting lists remain at record levels',
 'RTE News', '2024-03-01',
 'Over 900,000 people are on some form of hospital waiting list.',
 true),
('b0000001-0000-0000-0000-000000000014', 'news_report', 'outcome_proof',
 'https://www.rte.ie/news/health/trolley-watch/',
 'Record trolley figures in hospitals',
 'RTE News / INMO', '2024-01-15',
 'INMO trolley watch figures show record numbers of patients on trolleys in emergency departments.',
 true),
('b0000001-0000-0000-0000-000000000091', 'news_report', 'outcome_proof',
 'https://www.irishtimes.com/crime-law/garda-numbers-fall/',
 'Garda numbers continue to fall below target',
 'Irish Times', '2024-04-01',
 'Garda strength has fallen below 14,000 as retirements outpace recruitment.',
 true);


-- ============================================================
-- PROMISE-CATEGORY MAPPINGS
-- ============================================================

-- Get category IDs by slug and map promises
-- (In practice these would use real UUIDs; here we use a DO block)

DO $$
DECLARE
  cat_housing UUID;
  cat_health UUID;
  cat_climate UUID;
  cat_transport UUID;
  cat_economy UUID;
  cat_education UUID;
  cat_immigration UUID;
  cat_gaeilge UUID;
  cat_ni UUID;
  cat_justice UUID;
  cat_agriculture UUID;
  cat_eu UUID;
  cat_tech UUID;
BEGIN
  SELECT id INTO cat_housing FROM categories WHERE slug = 'housing';
  SELECT id INTO cat_health FROM categories WHERE slug = 'health';
  SELECT id INTO cat_climate FROM categories WHERE slug = 'climate';
  SELECT id INTO cat_transport FROM categories WHERE slug = 'transport';
  SELECT id INTO cat_economy FROM categories WHERE slug = 'economy';
  SELECT id INTO cat_education FROM categories WHERE slug = 'education';
  SELECT id INTO cat_immigration FROM categories WHERE slug = 'immigration';
  SELECT id INTO cat_gaeilge FROM categories WHERE slug = 'gaeilge';
  SELECT id INTO cat_ni FROM categories WHERE slug = 'northern-ireland';
  SELECT id INTO cat_justice FROM categories WHERE slug = 'justice';
  SELECT id INTO cat_agriculture FROM categories WHERE slug = 'agriculture';
  SELECT id INTO cat_eu FROM categories WHERE slug = 'eu-policy';
  SELECT id INTO cat_tech FROM categories WHERE slug = 'technology';

  -- Housing promises
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000001', cat_housing);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000002', cat_housing);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000003', cat_housing);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000004', cat_housing);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000005', cat_housing);

  -- Health promises
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000010', cat_health);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000011', cat_health);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000012', cat_health);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000013', cat_health);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000014', cat_health);

  -- Climate promises
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000020', cat_climate);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000021', cat_climate);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000022', cat_climate);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000023', cat_climate);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000024', cat_transport);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000024', cat_climate);

  -- Transport promises
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000030', cat_transport);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000031', cat_transport);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000032', cat_tech);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000033', cat_transport);

  -- Economy promises
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000040', cat_economy);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000041', cat_economy);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000042', cat_economy);

  -- Education promises
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000050', cat_education);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000051', cat_education);

  -- Immigration
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000060', cat_immigration);

  -- Irish language
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000070', cat_gaeilge);

  -- Northern Ireland
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000080', cat_ni);

  -- Justice
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000090', cat_justice);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000091', cat_justice);

  -- Agriculture
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000095', cat_agriculture);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000095', cat_climate);

  -- EU
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000100', cat_eu);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000100', cat_climate);
  INSERT INTO promise_categories VALUES ('b0000001-0000-0000-0000-000000000101', cat_eu);
END $$;
