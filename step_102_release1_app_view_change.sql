CREATE OR REPLACE VIEW ebr_things_with_attributes AS
SELECT thing_id, thing_name, thing_create_date,
       object_type, editionable_flag, status,
       temporary_flag, generated_flag, secondary_flag,
       timestamp, default_collation
FROM ebr_things;
