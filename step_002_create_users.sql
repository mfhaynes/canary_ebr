create user canary_sch
identified by "&canary_schema_password";
grant resource to canary_sch;
grant create session to canary_sch;
grant unlimited tablespace to canary_sch;
grant select_catalog_role to canary_sch;
grant create view to canary_sch;
alter user canary_sch enable editions;
create user canary_app
identified by "&canary_app_password";
grant resource, connect to canary_app;
grant select_catalog_role to canary_app;
