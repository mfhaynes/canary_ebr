CREATE EDITIONING VIEW ebr_things AS
SELECT thing_id, thing_name, thing_create_date
FROM ebr_things_b;
CREATE EDITIONING VIEW ebr_thing_attributes AS
SELECT thing_id, thing_attribute_type, thing_attribute_value
 FROM ebr_thing_attributes_b;
