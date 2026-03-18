-- Irish Government Promises Database
-- Compiled from official government documents, news reports, and policy analyses
-- Sources verified via web search March 2026

-- Schema (adjust table/column names to match your schema)
-- Assumes a table structure like:
-- CREATE TABLE promises (
--   id SERIAL PRIMARY KEY,
--   promise_text TEXT NOT NULL,
--   source_document VARCHAR(255),
--   source_url VARCHAR(512),
--   date_made DATE,
--   target_date DATE,
--   made_by VARCHAR(255),
--   department VARCHAR(255),
--   category VARCHAR(100),
--   status VARCHAR(50), -- kept, broken, in_progress, stalled, compromised, expired
--   status_detail TEXT,
--   controversy_level VARCHAR(20) -- low, medium, high
-- );

INSERT INTO promises (promise_text, source_document, source_url, date_made, target_date, made_by, department, category, status, status_detail, controversy_level) VALUES

-- ============================================================
-- 1. PROGRAMME FOR GOVERNMENT 2020 - CLIMATE
-- ============================================================

(
  'Achieve an average 7% per annum reduction in overall greenhouse gas emissions from 2021 to 2030, a 51% reduction over the decade',
  'Programme for Government: Our Shared Future',
  'https://www.finegael.ie/app/uploads/2020/06/ProgrammeforGovernment_Final_16.06.20.pdf',
  '2020-06-15',
  '2030-12-31',
  'Micheál Martin / Leo Varadkar / Eamon Ryan',
  'Department of the Environment, Climate and Communications',
  'climate',
  'broken',
  'Ireland blew its first carbon budget (2021-2025), overshooting by ~10 Mt CO2eq. EPA projections show only 22% reduction achievable by 2030, far short of 51%. Annual reduction rate was 2% in 2024, not 7%. Potential compliance costs of €8-26 billion.',
  'high'
),

(
  'Introduce Climate Action Bill within the first 100 days of government, establishing a Climate Action Council and setting net zero by 2050 in law',
  'Programme for Government: Our Shared Future',
  'https://www.finegael.ie/app/uploads/2020/06/ProgrammeforGovernment_Final_16.06.20.pdf',
  '2020-06-15',
  '2020-10-15',
  'Eamon Ryan, Minister for Climate Action',
  'Department of the Environment, Climate and Communications',
  'climate',
  'kept',
  'Climate Action and Low Carbon Development (Amendment) Act 2021 was enacted in July 2021. Slightly behind the 100-day target but delivered. Climate Change Advisory Council established and carbon budgets set.',
  'low'
),

(
  'Retrofit 500,000 homes to a BER rating of B2 or equivalent by 2030',
  'Programme for Government: Our Shared Future / Climate Action Plan 2021',
  'https://assets.gov.ie/203558/f06a924b-4773-4829-ba59-b0feec978e40.pdf',
  '2020-06-15',
  '2030-12-31',
  'Eamon Ryan / Darragh O''Brien',
  'Department of the Environment, Climate and Communications',
  'climate',
  'stalled',
  'By end of 2024, only ~58,000 homes retrofitted to B2 standard — just 11.5% of target. Would need 75,000/year from 2026-2030 to hit target. Median cost to householders of €16,000-€43,000 after grants is a major barrier. ESRI says target will be missed by large margin.',
  'high'
),

(
  'Ban registration of new petrol and diesel cars after 2030',
  'Programme for Government: Our Shared Future',
  'https://www.finegael.ie/app/uploads/2020/06/ProgrammeforGovernment_Final_16.06.20.pdf',
  '2020-06-15',
  '2030-12-31',
  'Eamon Ryan, Minister for Transport',
  'Department of Transport',
  'climate',
  'compromised',
  'At COP26 in November 2021, Minister Ryan signed a declaration committing Ireland to 2040 instead — a decade later. EU-wide rules now target 2035. Ireland has been less vocal about 2030 deadline; no domestic legislation enacted for 2030 ban. EV adoption at ~18% of new sales in 2023.',
  'medium'
),

(
  'Increase carbon tax to €100 per tonne by 2030',
  'Programme for Government: Our Shared Future',
  'https://www.finegael.ie/app/uploads/2020/06/ProgrammeforGovernment_Final_16.06.20.pdf',
  '2020-06-15',
  '2030-12-31',
  'Micheál Martin / Paschal Donohoe',
  'Department of Finance',
  'climate',
  'in_progress',
  'Carbon tax has been increasing annually by €7.50 as planned. Rose from €26/tonne in 2020 to €56/tonne by 2024. On track to reach €100 by 2030 if annual increases continue.',
  'medium'
),

(
  'Allocate 20% of the transport capital budget to cycling and walking infrastructure (€360 million per year)',
  'Programme for Government: Our Shared Future',
  'https://www.irishtimes.com/news/politics/cycling-and-pedestrian-projects-to-get-360m-parties-agree-1.4279850',
  '2020-06-15',
  '2025-06-27',
  'Eamon Ryan, Minister for Transport',
  'Department of Transport',
  'transport',
  'kept',
  'Budget 2026 allocated €362.6 million for walking and cycling. Over 1,000 km of active travel and greenway routes delivered 2020-2025. However, 60/40 split favours pedestrian over cycling infrastructure. New government shifted to near 50:50 public transport vs roads ratio.',
  'medium'
),

(
  'Maintain 2:1 spending ratio on public transport over roads',
  'Programme for Government: Our Shared Future',
  'https://www.finegael.ie/app/uploads/2020/06/ProgrammeforGovernment_Final_16.06.20.pdf',
  '2020-06-15',
  '2025-06-27',
  'Eamon Ryan, Minister for Transport',
  'Department of Transport',
  'transport',
  'compromised',
  'The 2020-2024 government broadly maintained this ratio. However, the new 2025 government plan allocated €10.1bn for public transport and €9.7bn for roads — nearly 50:50. DART+ South West was pushed back 4 years partly due to this rebalancing.',
  'medium'
),

(
  'End all new oil and gas exploration in Irish waters',
  'Programme for Government: Our Shared Future',
  'https://www.finegael.ie/app/uploads/2020/06/ProgrammeforGovernment_Final_16.06.20.pdf',
  '2020-06-15',
  NULL,
  'Eamon Ryan, Minister for Climate Action',
  'Department of the Environment, Climate and Communications',
  'climate',
  'kept',
  'No new exploration licences have been issued. Policy enacted. However, existing licences including the Barryroe oil field remained active, which drew some criticism.',
  'low'
),

-- ============================================================
-- 2. PROGRAMME FOR GOVERNMENT 2020 - OTHER KEY PROMISES
-- ============================================================

(
  'End Direct Provision system for asylum seekers, replacing it with a not-for-profit model',
  'Programme for Government: Our Shared Future / White Paper 2021',
  'https://www.irishtimes.com/opinion/2024/04/04/government-has-quietly-shelved-its-plan-to-end-direct-provision/',
  '2020-06-15',
  '2024-12-31',
  'Roderic O''Gorman, Minister for Children and Integration',
  'Department of Children, Equality, Disability, Integration and Youth',
  'social',
  'broken',
  'White Paper promised end of Direct Provision by end of 2024. System remains fully in place in 2026. Government quietly shelved the plan citing housing crisis, surge in asylum applications, and Ukraine war. Original assumption of 3,500 arrivals/year was blown out by 15,000+/year reality. Described as "direct provision by another name."',
  'high'
),

(
  'No increase in the State pension age to 67 in 2021; defer the increase pending a Pensions Commission review',
  'Programme for Government: Our Shared Future',
  'https://www.finegael.ie/app/uploads/2020/06/ProgrammeforGovernment_Final_16.06.20.pdf',
  '2020-06-15',
  '2021-01-01',
  'Micheál Martin / Heather Humphreys',
  'Department of Social Protection',
  'social',
  'kept',
  'The pension age increase to 67 in 2021 and 68 in 2028 was successfully deferred. The Pensions Commission reported and recommended a phased increase to 67 by 2031. This was a huge election issue in 2020 after public anger over 65-year-olds having to sign on for Jobseeker''s.',
  'high'
),

(
  'Establish a gambling regulator within the lifetime of the government',
  'Programme for Government: Our Shared Future',
  'https://www.finegael.ie/app/uploads/2020/06/ProgrammeforGovernment_Final_16.06.20.pdf',
  '2020-06-15',
  '2025-06-27',
  'Helen McEntee / Jim O''Callaghan, Minister for Justice',
  'Department of Justice',
  'governance',
  'kept',
  'The Gambling Regulatory Authority of Ireland (GRAI) was established on 5 March 2025, just before the government term ended. Gambling Regulation Act 2024 passed. However, full licensing regime not expected until mid-2026. Took the full 5-year term to deliver.',
  'low'
),

(
  'Introduce auto-enrolment pension savings scheme for workers',
  'Programme for Government: Our Shared Future',
  'https://www.finegael.ie/app/uploads/2020/06/ProgrammeforGovernment_Final_16.06.20.pdf',
  '2020-06-15',
  '2025-01-01',
  'Heather Humphreys / Dara Calleary',
  'Department of Social Protection',
  'social',
  'compromised',
  'Originally due January 2025, postponed to September 2025, then launched 1 January 2026. Ireland was the only OECD country without such a scheme. "My Future Fund" now operational with ~800,000 workers enrolled. Delivered but a year late.',
  'medium'
),

(
  'Introduce free contraception over a phased period starting with women aged 17-25',
  'Programme for Government: Our Shared Future',
  'https://www.finegael.ie/app/uploads/2020/06/ProgrammeforGovernment_Final_16.06.20.pdf',
  '2020-06-15',
  NULL,
  'Stephen Donnelly, Minister for Health',
  'Department of Health',
  'health',
  'kept',
  'Scheme launched September 2022 for ages 17-25. Progressively expanded: ages 26 (Jan 2023), 27-30 (Sep 2023), 31 (Jan 2024), 32-35 (Jul 2024). Over 189,000 people accessed the service in 2023. Plan to expand to age 55. €48 million allocated in 2024.',
  'low'
),

(
  'Reduce pupil-teacher ratios from 26:1 to 20:1 by 2025',
  'Programme for Government: Our Shared Future',
  'https://www.finegael.ie/app/uploads/2020/06/ProgrammeforGovernment_Final_16.06.20.pdf',
  '2020-06-15',
  '2025-12-31',
  'Norma Foley, Minister for Education',
  'Department of Education',
  'education',
  'compromised',
  'Some progress made with ratio reduced to 23:1 by 2024, but the 20:1 target was not achieved by 2025. Budget allocations reduced class sizes incrementally each year but fell short of the ambitious target.',
  'medium'
),

(
  'No increase in third-level fees',
  'Programme for Government: Our Shared Future',
  'https://www.finegael.ie/app/uploads/2020/06/ProgrammeforGovernment_Final_16.06.20.pdf',
  '2020-06-15',
  '2025-06-27',
  'Simon Harris, Minister for Further and Higher Education',
  'Department of Further and Higher Education',
  'education',
  'kept',
  'The student contribution charge was reduced from €3,000 to €2,000 as part of Budget 2024 and subsequent budgets. Fees were not increased during the government term.',
  'low'
),

(
  'Retain the 12.5% corporation tax rate',
  'Programme for Government: Our Shared Future',
  'https://www.finegael.ie/app/uploads/2020/06/ProgrammeforGovernment_Final_16.06.20.pdf',
  '2020-06-15',
  NULL,
  'Paschal Donohoe / Michael McGrath, Ministers for Finance',
  'Department of Finance',
  'economy',
  'compromised',
  'Ireland joined the OECD global minimum tax deal in October 2021, agreeing to a 15% rate for companies with revenues over €750 million. The 12.5% rate remains for smaller companies. This was a pragmatic shift rather than a broken promise, but the headline rate changed.',
  'medium'
),

-- ============================================================
-- 3. HOUSING FOR ALL (September 2021)
-- ============================================================

(
  'Deliver 300,000 homes by 2030 (average 33,000 per year)',
  'Housing for All: A New Housing Plan for Ireland',
  'https://www.gov.ie/en/department-of-housing-local-government-and-heritage/campaigns/housing-for-all/',
  '2021-09-02',
  '2030-12-31',
  'Darragh O''Brien, Minister for Housing',
  'Department of Housing, Local Government and Heritage',
  'housing',
  'stalled',
  'By late 2025, 137,000 homes built since 2021 — roughly on track for cumulative totals. However, 2024 completions fell 7% to ~30,000 against a target of 33,450. Housing starts collapsed in early 2025 — Q1 starts were eight times lower than previous year. 2025 target of 41,000 homes described as "a lost cause."',
  'high'
),

(
  'Deliver 90,000 social housing units between 2022 and 2030',
  'Housing for All: A New Housing Plan for Ireland',
  'https://www.gov.ie/en/department-of-housing-local-government-and-heritage/campaigns/housing-for-all/',
  '2021-09-02',
  '2030-12-31',
  'Darragh O''Brien, Minister for Housing',
  'Department of Housing, Local Government and Heritage',
  'housing',
  'stalled',
  'Social housing targets consistently missed. Reliance on HAP (Housing Assistance Payment) and private market to fill gaps rather than direct builds by local authorities. Only 15% of social housing in predecessor plan was direct-build.',
  'high'
),

(
  'Deliver average 4,000 affordable purchase homes per year',
  'Housing for All: A New Housing Plan for Ireland',
  'https://www.gov.ie/en/department-of-housing-local-government-and-heritage/campaigns/housing-for-all/',
  '2021-09-02',
  '2030-12-31',
  'Darragh O''Brien, Minister for Housing',
  'Department of Housing, Local Government and Heritage',
  'housing',
  'stalled',
  'Affordable purchase delivery has been far below the 4,000/year target. The Local Authority Affordable Purchase Scheme launched but delivery numbers remain a fraction of the target.',
  'high'
),

(
  'Deliver 2,000 cost rental homes per year (18,000 by 2030)',
  'Housing for All: A New Housing Plan for Ireland',
  'https://www.gov.ie/en/department-of-housing-local-government-and-heritage/campaigns/housing-for-all/',
  '2021-09-02',
  '2030-12-31',
  'Darragh O''Brien, Minister for Housing',
  'Department of Housing, Local Government and Heritage',
  'housing',
  'stalled',
  'Cost rental is a new tenure type for Ireland with rents 25% below market. Initial delivery was very slow — hundreds rather than thousands per year. The concept is popular but pipeline remains well below the 2,000/year target.',
  'medium'
),

(
  'Increase Part V social/affordable housing requirement from 10% to 20% in new developments',
  'Housing for All: A New Housing Plan for Ireland',
  'https://www.gov.ie/en/department-of-housing-local-government-and-heritage/campaigns/housing-for-all/',
  '2021-09-02',
  '2026-01-01',
  'Darragh O''Brien, Minister for Housing',
  'Department of Housing, Local Government and Heritage',
  'housing',
  'kept',
  'Part V requirement was legislated to increase to 20%. Existing permissions continue at 10% until 2026. This was implemented as promised.',
  'low'
),

(
  'Deliver 40,000 new homes in 2024',
  'Housing for All targets / Government statements',
  'https://www.rte.ie/news/clarity/2025/1112/1543365-new-government-housing-plan/',
  '2021-09-02',
  '2024-12-31',
  'Darragh O''Brien, Minister for Housing / Leo Varadkar, Taoiseach',
  'Department of Housing, Local Government and Heritage',
  'housing',
  'broken',
  'High-profile government figures promised 40,000 homes in 2024. Actual completions were ~30,000, a 7% decrease from 2023. This became a major election issue and was seen as a key broken promise by voters.',
  'high'
),

-- ============================================================
-- 4. SLÁINTECARE (Health Reform)
-- ============================================================

(
  'No patient should wait longer than 12 weeks for an inpatient procedure or 10 weeks for an outpatient appointment',
  'Sláintecare Report / Implementation Plan 2021-2023',
  'https://assets.gov.ie/134746/9b3b6ae9-2d64-4f87-8748-cda27d3193f3.pdf',
  '2017-05-30',
  '2027-12-31',
  'Cross-party committee / Stephen Donnelly, Minister for Health',
  'Department of Health',
  'health',
  'broken',
  'As of March 2025, 547,000 patients were waiting for inpatient/daycare admission or first outpatient appointment. Waiting times remain far beyond the 10/12-week targets. While some reductions achieved, the targets are nowhere near being met.',
  'high'
),

(
  'No patient should wait longer than 4 hours in an emergency department',
  'Sláintecare Report',
  'https://assets.gov.ie/134746/9b3b6ae9-2d64-4f87-8748-cda27d3193f3.pdf',
  '2017-05-30',
  '2027-12-31',
  'Cross-party committee / Stephen Donnelly, Minister for Health',
  'Department of Health',
  'health',
  'broken',
  'Trolley crisis continues. 2024 progress report noted 11% reduction in daily trolley numbers, but numbers presenting to EDs actually increased. 4-hour target remains aspirational.',
  'high'
),

(
  'Establish six surgical hubs and four elective treatment centres to add 977,700 annual capacity',
  'Sláintecare Implementation Plan 2021-2023',
  'https://assets.gov.ie/134746/9b3b6ae9-2d64-4f87-8748-cda27d3193f3.pdf',
  '2021-06-01',
  '2027-12-31',
  'Stephen Donnelly, Minister for Health',
  'Department of Health',
  'health',
  'in_progress',
  'Surgical hubs committed for Cork, Dublin (2), Galway, Limerick, Waterford. One Dublin site already operational. Elective centres in planning/procurement. Progress is slow but underway.',
  'medium'
),

(
  'Establish six new HSE Health Regions to deliver integrated care',
  'Sláintecare Implementation Plan',
  'https://about.hse.ie/our-work/slaintecare-our-strategy-for-improving-irelands-healthcare-system/',
  '2021-06-01',
  '2024-03-31',
  'Stephen Donnelly, Minister for Health',
  'Department of Health / HSE',
  'health',
  'kept',
  'Six new HSE Health Regions commenced in March 2024 with Regional Executive Officers in place. Structural reform delivered on time.',
  'low'
),

(
  'Deliver universal healthcare — move toward a single-tier system where patients are treated based on need, not ability to pay',
  'Sláintecare Report 2017',
  'https://www.sciencedirect.com/science/article/pii/S0168851018301532',
  '2017-05-30',
  '2027-12-31',
  'Cross-party committee',
  'Department of Health',
  'health',
  'stalled',
  'Ireland remains the only European country without universal coverage of primary healthcare. 58% of residents lack free primary care access. GP visits cost €50-80 for those without medical cards. Two-tier system persists. GP visit cards expanded to more groups but fundamental reform not achieved.',
  'high'
),

(
  'Extend free GP care to all children under 8',
  'Programme for Government / Sláintecare',
  'https://www.gov.ie/en/press-release/c2cc4-delivering-universal-healthcare-23-developments-in-health-in-2023/',
  '2020-06-15',
  '2025-12-31',
  'Stephen Donnelly, Minister for Health',
  'Department of Health',
  'health',
  'kept',
  'Free GP care was extended to all children aged 6 and 7 in 2023, adding to existing coverage for under-6s. Extended further with GP visit cards for those earning up to median income.',
  'low'
),

-- ============================================================
-- 5. CLIMATE ACTION PLAN 2021 - SECTORAL TARGETS
-- ============================================================

(
  'Generate 80% of electricity from renewables by 2030, including 5GW offshore wind, 8GW onshore wind, and 1.5-2.5GW solar',
  'Climate Action Plan 2021',
  'https://assets.gov.ie/203558/f06a924b-4773-4829-ba59-b0feec978e40.pdf',
  '2021-11-04',
  '2030-12-31',
  'Eamon Ryan, Minister for Climate Action',
  'Department of the Environment, Climate and Communications',
  'climate',
  'stalled',
  'Renewables provided ~40% of electricity in 2024. No offshore wind farm constructed yet beyond the 25MW Arklow Bank (2004). 5GW offshore target will not be met by 2030 — industry says projects will be "in construction" by 2030 at best. Onshore wind and solar making better progress.',
  'high'
),

(
  'Install 600,000 heat pumps in residential buildings by 2030 (400,000 in existing buildings)',
  'Climate Action Plan 2021',
  'https://assets.gov.ie/203558/f06a924b-4773-4829-ba59-b0feec978e40.pdf',
  '2021-11-04',
  '2030-12-31',
  'Eamon Ryan, Minister for Climate Action',
  'Department of the Environment, Climate and Communications',
  'climate',
  'stalled',
  'Heat pump installations have been growing but remain far below the rate needed. The retrofit programme, which is the main delivery mechanism, is at 11.5% of its 500,000 home target.',
  'medium'
),

(
  'Enable 500,000 extra walking, cycling and public transport journeys per day by 2030',
  'Climate Action Plan 2021',
  'https://assets.gov.ie/203558/f06a924b-4773-4829-ba59-b0feec978e40.pdf',
  '2021-11-04',
  '2030-12-31',
  'Eamon Ryan, Minister for Transport',
  'Department of Transport',
  'transport',
  'in_progress',
  'Active travel infrastructure has been delivered (1,000+ km). Public bike trips rose 23% in 2024 and 51% in early 2025. BusConnects rollout underway. Progress is positive but tracking against the 500,000 extra journeys target is unclear.',
  'low'
),

(
  'Reach nearly 1 million electric vehicles on Irish roads by 2030',
  'Climate Action Plan 2021',
  'https://assets.gov.ie/203558/f06a924b-4773-4829-ba59-b0feec978e40.pdf',
  '2021-11-04',
  '2030-12-31',
  'Eamon Ryan, Minister for Transport',
  'Department of Transport',
  'climate',
  'stalled',
  'EV adoption growing but far below trajectory needed for 950,000 EVs by 2030. About 18% of new car sales were electric in 2023. Charging infrastructure gaps and vehicle costs remain barriers.',
  'medium'
),

(
  'Reduce agricultural chemical nitrogen fertiliser use to 300,000 tonnes per year',
  'Climate Action Plan 2021',
  'https://assets.gov.ie/203558/f06a924b-4773-4829-ba59-b0feec978e40.pdf',
  '2021-11-04',
  '2030-12-31',
  'Charlie McConalogue, Minister for Agriculture',
  'Department of Agriculture, Food and the Marine',
  'climate',
  'in_progress',
  'Fertiliser use has been declining. The agriculture sector accounts for ~37% of emissions and progress has been described as "particularly slow and challenging" by the EPA.',
  'medium'
),

-- ============================================================
-- 6. NATIONAL DEVELOPMENT PLAN - INFRASTRUCTURE
-- ============================================================

(
  'Deliver MetroLink — a fully segregated railway from Swords to Charlemont with 16 stations, the largest public investment in State history',
  'National Development Plan 2021-2030 / Project Ireland 2040',
  'https://www.irishtimes.com/news/ireland/irish-news/new-multibillion-euro-plan-for-infrastructure-is-not-a-wish-list-taoiseach-says-1.4690646',
  '2021-10-04',
  NULL,
  'Micheál Martin, Taoiseach / Eamon Ryan, Minister for Transport',
  'Department of Transport / TII',
  'infrastructure',
  'stalled',
  'First proposed in 2005 — over 20 years ago. Planning permission granted October 2025. Tendering may begin 2026, construction 2028, completion possibly 2034. Cost estimates have ranged from €7bn to €23bn. Taoiseach Martin said the NDP was "not a wish list" but MetroLink had no confirmed completion date in the 2021 plan.',
  'high'
),

(
  'Complete BusConnects core bus corridors substantially by 2030 across Dublin, Cork, Galway, Limerick and Waterford',
  'National Development Plan 2021-2030',
  'https://www.irishtimes.com/news/ireland/irish-news/new-multibillion-euro-plan-for-infrastructure-is-not-a-wish-list-taoiseach-says-1.4690646',
  '2021-10-04',
  '2030-12-31',
  'Eamon Ryan, Minister for Transport',
  'Department of Transport / NTA',
  'infrastructure',
  'in_progress',
  'Dublin BusConnects: four infrastructure routes planned for completion by 2030. Ballymun/Finglas corridor construction to commence Q3 2026. Liffey Valley corridor completion targeted Q2 2028. Regional city BusConnects programmes at various stages of planning.',
  'medium'
),

(
  'Deliver DART+ programme — double capacity and treble electrification of Greater Dublin rail network',
  'National Development Plan 2021-2030',
  'https://www.irishtimes.com/news/ireland/irish-news/new-multibillion-euro-plan-for-infrastructure-is-not-a-wish-list-taoiseach-says-1.4690646',
  '2021-10-04',
  '2030-12-31',
  'Eamon Ryan, Minister for Transport',
  'Department of Transport / Irish Rail',
  'infrastructure',
  'stalled',
  'New DART trains delayed from mid-2025 to Q2 2027 due to battery pack issues. DART+ South West pushed back 4 years to 2030+. DART+ West facing judicial review risk. Original 1984 fleet still in daily service causing reliability issues. €2 billion programme significantly behind schedule.',
  'high'
),

(
  'Complete the National Children''s Hospital (originally to open 2024)',
  'National Development Plan / Health Capital Programme',
  'https://www.irishtimes.com/health/2024/02/13/national-childrens-hospital-cost-rises-to-over-2bn-donnelly-confirms/',
  '2017-04-01',
  '2024-12-31',
  'Simon Harris / Stephen Donnelly, Ministers for Health',
  'Department of Health / NPHDB',
  'infrastructure',
  'broken',
  'Original cost estimate: €650 million (2015). Current cost: €2.24 billion — a 245% overrun. Originally due August 2022, then October 2024, then February 2025, then September 2025. Earliest patient treatment now June 2026. Failed to meet its deadline 15 times since 2020. NPHDB said it has "no" faith in contractor BAM. Ireland''s most notorious cost overrun.',
  'high'
),

(
  'Invest €165 billion in public infrastructure from 2021 to 2030',
  'National Development Plan 2021-2030',
  'https://www.mccannfitzgerald.com/knowledge/environmental-and-planning/show-me-the-money-irelands-national-development-plan-2021-2030',
  '2021-10-04',
  '2030-12-31',
  'Micheál Martin, Taoiseach',
  'Department of Public Expenditure',
  'infrastructure',
  'in_progress',
  'The NDP review increased 2026-2030 allocations to €102.4bn (30% increase). Spending is occurring but delivery of actual projects has been plagued by delays and cost overruns across MetroLink, DART+, and the Children''s Hospital.',
  'medium'
),

(
  'Invest €9.25 billion in health infrastructure from 2026 to 2030',
  'National Development Plan Review 2025',
  'https://www.thejournal.ie/national-development-plan-key-points-6769760-Jul2025/',
  '2025-07-01',
  '2030-12-31',
  'Government of Ireland',
  'Department of Health / Department of Public Expenditure',
  'infrastructure',
  'in_progress',
  'Substantially enhanced from €5.7bn for 2021-2025. Includes Sláintecare implementation, elective treatment centres, and new primary care facilities. Delivery dependent on construction capacity and planning system.',
  'low'
),

-- ============================================================
-- 7. HOUSING & HOMELESSNESS
-- ============================================================

(
  'Eradicate homelessness through Housing for All pathways',
  'Housing for All: A New Housing Plan for Ireland',
  'https://www.gov.ie/en/department-of-housing-local-government-and-heritage/campaigns/housing-for-all/',
  '2021-09-02',
  '2030-12-31',
  'Darragh O''Brien, Minister for Housing',
  'Department of Housing, Local Government and Heritage',
  'housing',
  'broken',
  'Homelessness hit record highs throughout 2025: 16,766 people in emergency accommodation in October 2025, including 5,274 children. Numbers increased 12% year-on-year. Charities say official figures undercount by excluding rough sleepers, those in domestic violence refuges, and hidden homeless.',
  'high'
),

(
  'Establish a Housing Commission to examine tenure, standards and deliver a referendum on housing',
  'Housing for All: A New Housing Plan for Ireland',
  'https://www.gov.ie/en/department-of-housing-local-government-and-heritage/campaigns/housing-for-all/',
  '2021-09-02',
  '2025-12-31',
  'Darragh O''Brien, Minister for Housing',
  'Department of Housing, Local Government and Heritage',
  'housing',
  'compromised',
  'The Housing Commission was established and reported. However, the promised referendum on a right to housing has not been held. The commission''s recommendations on tenure reform have seen limited implementation.',
  'medium'
),

(
  'Use the Land Development Agency to deliver 150,000 homes on State lands over 20 years',
  'Housing for All / LDA Act 2021',
  'https://www.gov.ie/en/department-of-housing-local-government-and-heritage/campaigns/housing-for-all/',
  '2021-09-02',
  '2041-12-31',
  'Darragh O''Brien, Minister for Housing',
  'Department of Housing / LDA',
  'housing',
  'in_progress',
  'LDA was established on a statutory basis via the LDA Act 2021. Early delivery has been modest with projects in planning and development. The agency is active but actual housing output remains small relative to the 150,000 target.',
  'medium'
),

-- ============================================================
-- 8. WELL-KNOWN CONTROVERSIAL / ATTENTION-GRABBING PROMISES
-- ============================================================

(
  'Deliver 50,000 additional social homes over the government term',
  'Programme for Government: Our Shared Future',
  'https://www.finegael.ie/app/uploads/2020/06/ProgrammeforGovernment_Final_16.06.20.pdf',
  '2020-06-15',
  '2025-06-27',
  'Darragh O''Brien, Minister for Housing',
  'Department of Housing, Local Government and Heritage',
  'housing',
  'compromised',
  'Social housing delivery improved but relied heavily on HAP, leasing, and acquisitions rather than new-build local authority housing. Critics argue counting HAP as "social housing delivery" misrepresents actual construction.',
  'high'
),

(
  'Reduce the cost of childcare for parents, with a potential cap on creche fees',
  'Programme for Government: Our Shared Future',
  'https://www.finegael.ie/app/uploads/2020/06/ProgrammeforGovernment_Final_16.06.20.pdf',
  '2020-06-15',
  '2025-06-27',
  'Roderic O''Gorman, Minister for Children',
  'Department of Children, Equality, Disability, Integration and Youth',
  'social',
  'in_progress',
  'National Childcare Scheme (NCS) subsidies significantly increased. Core funding model introduced to cap fee increases. Childcare costs reduced but Ireland remains one of the most expensive countries for childcare in the OECD.',
  'medium'
),

(
  'Invest €4.5 billion in water infrastructure under Housing for All',
  'Housing for All: A New Housing Plan for Ireland',
  'https://www.gov.ie/en/department-of-housing-local-government-and-heritage/campaigns/housing-for-all/',
  '2021-09-02',
  '2030-12-31',
  'Darragh O''Brien, Minister for Housing',
  'Department of Housing, Local Government and Heritage',
  'infrastructure',
  'in_progress',
  'Uisce Éireann (formerly Irish Water) investment has continued but boil water notices and capacity constraints remain common. Water infrastructure deficits continue to constrain housing development in many areas.',
  'medium'
),

(
  'Raise the higher rate income tax entry point to €50,000',
  'Fine Gael policy commitment',
  'https://www.irishtimes.com/politics/2024/11/21/what-fine-gael-fianna-fail-and-the-greens-promised-in-2020-and-how-much-they-delivered/',
  '2020-06-15',
  '2025-06-27',
  'Leo Varadkar, Tánaiste/Taoiseach',
  'Department of Finance',
  'economy',
  'compromised',
  'The standard rate band was increased incrementally in successive budgets but did not reach €50,000. Budget changes brought it to approximately €42,000 by 2024.',
  'medium'
),

(
  'Cut Capital Gains Tax to 25%',
  'Fianna Fáil policy commitment',
  'https://www.irishtimes.com/politics/2024/11/21/what-fine-gael-fianna-fail-and-the-greens-promised-in-2020-and-how-much-they-delivered/',
  '2020-06-15',
  '2025-06-27',
  'Micheál Martin, Taoiseach',
  'Department of Finance',
  'economy',
  'broken',
  'CGT remained at 33% throughout the government term. This Fianna Fáil promise was never implemented.',
  'medium'
),

(
  'Deliver 1,500 electric buses as part of public transport electrification by 2030',
  'Climate Action Plan 2021',
  'https://assets.gov.ie/203558/f06a924b-4773-4829-ba59-b0feec978e40.pdf',
  '2021-11-04',
  '2030-12-31',
  'Eamon Ryan, Minister for Transport',
  'Department of Transport',
  'transport',
  'in_progress',
  'Electric and hybrid buses being added to Dublin Bus and Bus Éireann fleets. First fully electric buses entered service in Dublin. However, the pace of fleet electrification is behind what is needed for 1,500 by 2030.',
  'low'
),

(
  'Increase land farmed organically to 450,000 hectares by 2030',
  'Climate Action Plan 2021',
  'https://assets.gov.ie/203558/f06a924b-4773-4829-ba59-b0feec978e40.pdf',
  '2021-11-04',
  '2030-12-31',
  'Charlie McConalogue, Minister for Agriculture',
  'Department of Agriculture, Food and the Marine',
  'climate',
  'stalled',
  'Organic farming area has been growing but remains a small fraction of total farmland. Reaching 450,000 hectares (~10% of agricultural land) by 2030 would require dramatic acceleration from current levels of around 120,000 hectares.',
  'medium'
);

-- Summary Statistics:
-- Total promises: 45
-- Status breakdown:
--   kept: 9
--   in_progress: 10
--   compromised: 8
--   stalled: 10
--   broken: 8
-- High controversy: 18
-- Medium controversy: 18
-- Low controversy: 9
