prompt Connect as system ID
@../private/connect_system.sql
set echo on
create edition release1 as child of Ora$Base;
grant use on edition release1 to canary_sch, canary_app;

pause show DEFAULT_EDITION is unchanged.
select property_value
from database_properties
where property_value = 'DEFAULT_EDITION';
