INSERT INTO geo_entity_statuses (geo_entity_status) VALUES
('current'),
('archived');

INSERT INTO geo_entity_coverages (geo_entity_coverage) VALUES
('channel islands'),
('england'),
('england and wales'),
('great britain'),
('isle of man'),
('northern ireland'),
('scotland'),
('united kingdom'),
('wales');

INSERT INTO geo_entity_owners (geo_entity_owner_abbreviation, geo_entity_owner_name) VALUES
('bcni','building control northern ireland'),
('beis','department for business, energy and industrial strategy'),
('defra','department for environment, food and rural affairs'),
('dfe','department for education'),
('dluhc','department for levelling up, housing and communities'),
('gla','greater london authority'),
('hie','highlands and islands enterprise'),
('home office','home office'),
('lgbc','local government boundary commission'),
('ms','marine scotland'),
('natural england','natural england'),
('natural england/natural resources wales','natural england/natural resources wales'),
('natural resources wales','natural resources wales'),
('nhs','national health service'),
('nhs digital','national health service digital'),
('nifrs','northern ireland fire and rescue service'),
('nisra','northern ireland statistics and research agency'),
('nrs','national records of scotland'),
('ods','organisation data service'),
('ons','office for national statistics'),
('os','ordnance survey'),
('phe','public health england'),
('psni','police service of northern ireland'),
('se','scottish executive'),
('sg','scottish government'),
('wg','welsh government'),
('wg (bc)','welsh government (boundary commission)'),
('wg (data unit)','welsh government (data unit)'),
('wg (econ)','welsh government (economy)'),
('wg (educ)','welsh government (education)'),
('wg (envt)','welsh government (environment)'),
('wg (health)','welsh government (health)'),
('wg (lgbc)','welsh government (local government boundary commission)'),
('wg (stats)','welsh government (statistics)');

UPDATE geo_entity_owners
SET geo_entity_owner_note = 'nhs'
WHERE geo_entity_owner_abbreviation = 'ods';

INSERT INTO geo_entity_themes (geo_entity_theme) VALUES
('administrative'),
('administrative/electoral'),
('census'),
('economic'),
('electoral'),
('experimental'),
('health'),
('housing and regeneration'),
('other'),
('statistical building block'),
('transport');
