connect canary_sch@&database edition=release1
ALTER TABLE ebr_things_b
ADD (object_type varchar2(30),
     editionable_flag varchar2(1),
     status varchar2(7),
     temporary_flag varchar2(1),
     generated_flag varchar2(1),
     secondary_flag varchar2(1),
     timestamp varchar2(19),
     default_collation varchar2(100));
UPDATE ebr_things_b thing
SET object_type = (SELECT thing_attribute_value
                   FROM ebr_thing_attributes_b attr
                   WHERE thing.thing_id = attr.thing_id
                     AND thing_attribute_type = 'object_type'),
    editionable_flag = (SELECT thing_attribute_value
                        FROM ebr_thing_attributes_b attr
                        WHERE thing.thing_id = attr.thing_id
                          AND thing_attribute_type = 'editionable_flag'),
    status = (SELECT thing_attribute_value
              FROM ebr_thing_attributes_b attr
              WHERE thing.thing_id = attr.thing_id
                AND thing_attribute_type = 'status'),
    temporary_flag = (SELECT thing_attribute_value
                      FROM ebr_thing_attributes_b attr
                      WHERE thing.thing_id = attr.thing_id
                        AND thing_attribute_type = 'temporary_flag'),
    generated_flag = (SELECT thing_attribute_value
                      FROM ebr_thing_attributes_b attr
                      WHERE thing.thing_id = attr.thing_id
                        AND thing_attribute_type = 'generated_flag'),
    secondary_flag = (SELECT thing_attribute_value
                      FROM ebr_thing_attributes_b attr
                      WHERE thing.thing_id = attr.thing_id
                        AND thing_attribute_type = 'secondary_flag'),
    timestamp = (SELECT thing_attribute_value
                 FROM ebr_thing_attributes_b attr
                 WHERE thing.thing_id = attr.thing_id
                   AND thing_attribute_type = 'timestamp'),
    default_collation = (SELECT thing_attribute_value
                         FROM ebr_thing_attributes_b attr
                         WHERE thing.thing_id = attr.thing_id
                           AND thing_attribute_type = 'default_collation');
COMMIT;
CREATE OR REPLACE EDITIONING VIEW ebr_things AS 
SELECT thing_id, thing_name, thing_create_date,
       object_type, editionable_flag, status,
       temporary_flag, generated_flag, secondary_flag,
       timestamp, default_collation
FROM ebr_things_b;
CREATE OR REPLACE VIEW ebr_things_with_attributes AS
SELECT thing_id, thing_name, thing_create_date,
       object_type, editionable_flag, status,
       temporary_flag, generated_flag, secondary_flag,
       timestamp, default_collation
FROM ebr_things;
