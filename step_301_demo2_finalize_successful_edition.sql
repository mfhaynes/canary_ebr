@../private/connect_system.sql
col edition_name for a40
set echo on
alter session set edition=release1;

pause show DEFAULT_EDITION
select property_value
from database_properties
where property_name = 'DEFAULT_EDITION';

pause set DEFAULT_EDITION
ALTER DATABASE DEFAULT EDITION=release1;

pause show DEFAULT_EDITION
select property_value
from database_properties
where property_name = 'DEFAULT_EDITION';

pause drop old edition
PURGE DBA_RECYCLEBIN;
DROP EDITION ORA$BASE CASCADE;
