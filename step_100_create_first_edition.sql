prompt Connect as system ID
@../private/connect_system.sql
create edition release1 as child of Ora$Base;
grant use on edition release1 to canary_sch, canary_app;
