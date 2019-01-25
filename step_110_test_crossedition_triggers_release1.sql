pause connect to canary_app and override edition to release1
connect canary_app@&database
set echo on
alter session set edition=release1;
