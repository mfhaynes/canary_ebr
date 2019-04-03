pause Connect with explicit EDITION setting
connect canary_sch@&database edition=release1

col object_name for a30
col object_type for a20
col edition_name for a30
set lines 145

pause show current object editions
select object_name, edition_name, object_type from dba_objects where edition_name is not null;

pause Add New Columns to THINGS table.
ALTER TABLE ebr_things_b
ADD (attribute1 varchar2(30),
     attribute2 varchar2(30),
     attribute3 varchar2(30),
     attribute4 varchar2(100),
     flag1 varchar2(1),
     flag2 varchar2(1),
     flag3 varchar2(1),
     flag4 varchar2(1));

pause Update editioning view with new columns.
CREATE OR REPLACE EDITIONING VIEW ebr_things AS
SELECT thing_id, thing_name, thing_create_date,
       attribute1, attribute2, attribute3, attribute4,
       flag1, flag2, flag3, flag4
FROM ebr_things_b;

pause DROP editioning view not needed in new edition
DROP VIEW ebr_thing_attributes;

pause show current object editions
select object_name, edition_name, object_type from dba_objects where edition_name is not null;
