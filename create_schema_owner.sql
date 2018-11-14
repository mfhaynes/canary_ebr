create user canary_sch
identified by "&canary_schema_password";
grant resource to canary_sch;
grant create session to canary_sch;
grant unlimited_tablespace to canary_sch;
