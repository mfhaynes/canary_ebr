CREATE OR REPLACE VIEW ebr_things_with_attributes AS
SELECT t.thing_id, t.thing_name, t.thing_create_date,
       (SELECT ta.thing_attribute_value
        FROM ebr_thing_attributes ta
        WHERE ta.thing_id = t.thing_id
          AND ta.thing_attribute_type = 'object_type') AS object_type,
       (SELECT ta.thing_attribute_value
        FROM ebr_thing_attributes ta
        WHERE ta.thing_id = t.thing_id
          AND ta.thing_attribute_type = 'editionable_flag') AS editionable_flag,
       (SELECT ta.thing_attribute_value
        FROM ebr_thing_attributes ta
        WHERE ta.thing_id = t.thing_id
          AND ta.thing_attribute_type = 'status') AS status,
       (SELECT ta.thing_attribute_value
        FROM ebr_thing_attributes ta
        WHERE ta.thing_id = t.thing_id
          AND ta.thing_attribute_type = 'temporary_flag') AS temporary,
       (SELECT ta.thing_attribute_value
        FROM ebr_thing_attributes ta
        WHERE ta.thing_id = t.thing_id
          AND ta.thing_attribute_type = 'generated_flag') AS generated,
       (SELECT ta.thing_attribute_value
        FROM ebr_thing_attributes ta
        WHERE ta.thing_id = t.thing_id
          AND ta.thing_attribute_type = 'secondary_flag') AS secondary,
       (SELECT ta.thing_attribute_value
        FROM ebr_thing_attributes ta
        WHERE ta.thing_id = t.thing_id
          AND ta.thing_attribute_type = 'timestamp') AS timestamp,
       (SELECT ta.thing_attribute_value
        FROM ebr_thing_attributes ta
        WHERE ta.thing_id = t.thing_id
          AND ta.thing_attribute_type = 'default_collation') AS default_collation
FROM ebr_things t;

GRANT SELECT on ebr_things_with_attributes TO canary_app;
