connect canary_sch@&database
select property_value
from database_properties
where property_value = 'DEFAULT_EDITION';
