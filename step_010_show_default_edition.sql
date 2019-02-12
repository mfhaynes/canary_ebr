connect canary_sch@&database
select property_value
from database_properties
where property_name = 'DEFAULT_EDITION';
