CREATE OR REPLACE VIEW ebr_things_with_attributes AS
SELECT thing_id, thing_name, thing_create_date,
       attribute1, attribute2, attribute3, attribute4,
       flag1, flag2, flag3, flag4
FROM ebr_things;

pause show current object editions
select object_name, edition_name, edition_type from dba_objects where edition_name is not null;
