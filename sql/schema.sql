-- Portable SQL subset: executed on SQLite; use equivalent types on PostgreSQL.
CREATE TABLE IF NOT EXISTS dim_date(date TEXT NOT NULL UNIQUE, date_key INTEGER PRIMARY KEY, month TEXT NOT NULL);
CREATE TABLE IF NOT EXISTS dim_segment(segment TEXT NOT NULL UNIQUE, segment_key INTEGER PRIMARY KEY);
CREATE TABLE IF NOT EXISTS fact_observation(observation_id INTEGER PRIMARY KEY,
 converted INTEGER NOT NULL CHECK(converted IN (0,1)),
 revenue REAL NOT NULL CHECK(revenue>=0),
 variable_cost REAL NOT NULL CHECK(variable_cost>=0),
 offer_cost REAL NOT NULL CHECK(offer_cost>=0),
 contribution REAL NOT NULL,
 date_key INTEGER NOT NULL REFERENCES dim_date(date_key),
 segment_key INTEGER NOT NULL REFERENCES dim_segment(segment_key));
CREATE INDEX IF NOT EXISTS idx_fact_date_segment ON fact_observation(date_key,segment_key);
