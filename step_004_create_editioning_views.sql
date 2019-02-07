prompt connect as Canary Schema ID
connect canary_sch@&database
set echo on
CREATE OR REPLACE EDITIONING VIEW ebr_things AS
SELECT thing_id, thing_name, thing_create_date
FROM ebr_things_b;
GRANT SELECT, INSERT, UPDATE, DELETE on ebr_things to canary_app;
CREATE OR REPLACE EDITIONING VIEW ebr_thing_attributes AS
SELECT thing_id, thing_attribute_type, thing_attribute_value
 FROM ebr_thing_attributes_b;
GRANT SELECT, INSERT, UPDATE, DELETE on ebr_thing_attributes to canary_app;
