CREATE OR REPLACE VIEW ebr_things_with_attributes AS
SELECT t.thing_id, t.thing_name, t.thing_create_date,
       (SELECT ta.thing_attribute_value
        FROM ebr_thing_attributes ta
        WHERE ta.thing_id = t.thing_id
          AND ta.thing_attribute_type = 'attribute1') AS attribute1,
       (SELECT ta.thing_attribute_value
        FROM ebr_thing_attributes ta
        WHERE ta.thing_id = t.thing_id
          AND ta.thing_attribute_type = 'attribute2') AS attribute2,
       (SELECT ta.thing_attribute_value
        FROM ebr_thing_attributes ta
        WHERE ta.thing_id = t.thing_id
          AND ta.thing_attribute_type = 'attribute3') AS attribute3,
       (SELECT ta.thing_attribute_value
        FROM ebr_thing_attributes ta
        WHERE ta.thing_id = t.thing_id
          AND ta.thing_attribute_type = 'attribute4') AS attribute4,
       (SELECT ta.thing_attribute_value
        FROM ebr_thing_attributes ta
        WHERE ta.thing_id = t.thing_id
          AND ta.thing_attribute_type = 'flag1') AS flag1,
       (SELECT ta.thing_attribute_value
        FROM ebr_thing_attributes ta
        WHERE ta.thing_id = t.thing_id
          AND ta.thing_attribute_type = 'flag2') AS flag2,
       (SELECT ta.thing_attribute_value
        FROM ebr_thing_attributes ta
        WHERE ta.thing_id = t.thing_id
          AND ta.thing_attribute_type = 'flag3') AS flag3,
       (SELECT ta.thing_attribute_value
        FROM ebr_thing_attributes ta
        WHERE ta.thing_id = t.thing_id
          AND ta.thing_attribute_type = 'flag4') AS flag4
FROM ebr_things t;

GRANT SELECT on ebr_things_with_attributes TO canary_app;
