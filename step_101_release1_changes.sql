connect canary_sch@&database edition=release1
ALTER TABLE ebr_things_b
ADD (object_type varchar2(30),
     editionable_flag varchar2(1));
UPDATE ebr_things_b thing
SET object_type = (SELECT thing_attribute_value
                   FROM ebr_thing_attributes_b attr
                   WHERE thing.thing_id = attr.thing_id
                     AND thing_attribute_type = 'object_type'),
    editionable_flag = (SELECT thing_attribute_value
                        FROM ebr_thing_attributes_b attr
                        WHERE thing.thing_id = attr.thing_id
                          AND thing_attribute_type = 'editionable_flag');
COMMIT;
CREATE OR REPLACE EDITIONING VIEW ebr_things AS 
SELECT thing_id, thing_name, thing_create_date,
       object_type, editionable_flag
FROM ebr_things_b;
CREATE OR REPLACE VIEW ebr_things_with_attributes AS
SELECT thing_id, thing_name, thing_create_date,
       object_type, editionable_flag
FROM ebr_things;
