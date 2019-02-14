prompt Connect to canary_sch
connect canary_sch@&database
set echo on
select property_value
from database_properties
where property_name = 'DEFAULT_EDITION';
