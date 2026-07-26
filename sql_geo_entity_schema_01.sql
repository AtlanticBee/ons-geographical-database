-- settings for all of the script (note it is per-session in SQLite!)

PRAGMA foreign_keys = ON;
PRAGMA double_quoted_string_literals = OFF;

-- create FK tables for the main entity table 
-- By setting the values to be the PKs, the FKs they generate in the main entity table are automatically human readable

CREATE TABLE IF NOT EXISTS geo_entity_themes (
geo_entity_theme TEXT PRIMARY KEY
CHECK(geo_entity_theme = LOWER(geo_entity_theme))
) STRICT, WITHOUT ROWID;

CREATE TABLE IF NOT EXISTS geo_entity_coverages (
geo_entity_coverage TEXT PRIMARY KEY
CHECK(geo_entity_coverage = LOWER(geo_entity_coverage))
) STRICT, WITHOUT ROWID;

CREATE TABLE IF NOT EXISTS geo_entity_statuses (
geo_entity_status TEXT PRIMARY KEY
CHECK(geo_entity_status = LOWER(geo_entity_status))
) STRICT, WITHOUT ROWID;

CREATE TABLE IF NOT EXISTS geo_entity_owners (
geo_entity_owner_abbreviation TEXT PRIMARY KEY
CHECK(geo_entity_owner_abbreviation = LOWER(geo_entity_owner_abbreviation)),
geo_entity_owner_name TEXT UNIQUE NOT NULL
CHECK(geo_entity_owner_name = LOWER(geo_entity_owner_name)),
geo_entity_owner_note TEXT
CHECK(geo_entity_owner_note IS NULL OR (geo_entity_owner_note = LOWER(geo_entity_owner_note)))
) STRICT, WITHOUT ROWID;

-- create the main entity table to 3N normalisation, strict data type enforcement on
-- (any 1:1 relationships are kept together, any non-M:M relationships are treated with FKs)
-- Note: anything labelled a primary key will automatically be unique and not-null enforced
-- Also note: I have called the PK a "code" not an "id" to avoid confusion with integer IDs and improve descriptiveness

CREATE TABLE IF NOT EXISTS geo_entity_types (
geo_entity_code TEXT PRIMARY KEY,
geo_entity_name TEXT NOT NULL,
geo_entity_abbreviation TEXT,

-- FKs for main table

geo_entity_theme TEXT NOT NULL,
geo_entity_coverage TEXT NOT NULL,
geo_entity_status TEXT NOT NULL,
geo_entity_owner_abbreviation TEXT NOT NULL,

FOREIGN KEY (geo_entity_theme) REFERENCES geo_entity_themes (geo_entity_theme),
FOREIGN KEY (geo_entity_coverage) REFERENCES geo_entity_coverages (geo_entity_coverage),
FOREIGN KEY (geo_entity_status) REFERENCES geo_entity_statuses (geo_entity_status),
FOREIGN KEY (geo_entity_owner_abbreviation) REFERENCES geo_entity_owners (geo_entity_owner_abbreviation),

-- ensure all TEXT fields are lower case

CONSTRAINT chk_geo_entity_types_lowercase CHECK (
geo_entity_code = LOWER(geo_entity_code) AND
geo_entity_name = LOWER(geo_entity_name) AND
(geo_entity_abbreviation IS NULL OR geo_entity_abbreviation = LOWER(geo_entity_abbreviation))
))
STRICT, WITHOUT ROWID;
