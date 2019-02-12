@../private/connect_system.sql
set echo on
pause show DEFAULT_EDITION
select property_value
from database_properties
where property_value = 'DEFAULT_EDITION';

pause show DEFAULT_EDITION
select property_value
from database_properties
where property_value = 'DEFAULT_EDITION';
