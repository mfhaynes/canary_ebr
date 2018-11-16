create user canary_sch
identified by "&canary_schema_password";
grant resource to canary_sch;
grant create session to canary_sch;
grant unlimited tablespace to canary_sch;
grant select_catalog_role to canary_sch;
