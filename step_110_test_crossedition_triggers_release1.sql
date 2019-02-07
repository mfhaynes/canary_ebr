pause connect to canary_app and override edition to release1
connect canary_app@&database
set echo on
set lines 160
set pages 30
col thing_name for a30
col attribute4 for a30
alter session set edition=release1;

PAUSE run first query in other window
PAUSE show information about the attribute for one THING
select attribute1
from canary_sch.ebr_things t
where t.thing_name = 'V_$SESSION';

PAUSE run updates in other window
PAUSE query here before committing in other window
select attribute1
from canary_sch.ebr_things t
where t.thing_name = 'V_$SESSION';

PAUSE go commit in other window
PAUSE re-query here after commit.
select attribute1
from canary_sch.ebr_things t
where t.thing_name = 'V_$SESSION';

PAUSE go do work in other window to set up new EBR_TEST_THING data.
PAUSE Query EBR_TEST_THING data after commit in other window.
select * from canary_sch.ebr_things t
where t.thing_name = 'EBR_TEST_THING';

PAUSE go do work in other window for DELETE test.
PAUSE Query EBR_TEST_THING data after commit in other window.
select * from canary_sch.ebr_things t
where t.thing_name = 'EBR_TEST_THING';

