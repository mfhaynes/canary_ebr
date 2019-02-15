pause ARE YOU IN A NEW WINDOW?
set lines 150
set pages 30
col object_name for a30
col object_type for a30
col edition_name for a30
set echo on
connect canary_sch@&database edition=ORA$BASE
select object_name, edition_name, object_type from dba_objects where edition_name is not null;
exit
