pause connect to canary_app and override edition to release1
connect canary_app@&database
set lines 160
set pages 30
col thing_name for a30
col attribute4 for a30
set echo on
alter session set edition=release1;

PAUSE run first queries in other window
PAUSE Now, show we are in new edition
select *
from canary_sch.ebr_things
where thing_id = -123;

select *
from canary_sch.ebr_thing_atributes
where thing_id = -123
  and thing_attribute_type = 'attribute1';

PAUSE now go back to the other window

PAUSE show information about the attribute for one THING
select attribute1
from canary_sch.ebr_things t
where t.thing_name = 'GUMBALL';

PAUSE run updates in other window
PAUSE query here before committing in other window
select attribute1
from canary_sch.ebr_things t
where t.thing_name = 'GUMBALL';

PAUSE go commit in other window
PAUSE re-query here after commit.
select attribute1
from canary_sch.ebr_things t
where t.thing_name = 'GUMBALL';

PAUSE go do work in other window to set up new EBR_TEST_THING data.
PAUSE Query EBR_TEST_THING data after commit in other window.
select * from canary_sch.ebr_things t
where t.thing_name = 'EBR_TEST_THING';

PAUSE go do work in other window for DELETE test.
PAUSE Query EBR_TEST_THING data after commit in other window.
select * from canary_sch.ebr_things t
where t.thing_name = 'EBR_TEST_THING';

PAUSE switch to other window to check gumball color.
PAUSE UPDATE our GUMBALL
update canary_sch.ebr_things
set attribute1 = 'GREEN'
where thing_id = -123;
commit;

PAUSE switch to other window to query
PAUSE DELETE EBR_TEST_THING
delete from canary_sch.ebr_things
where thing_name = 'EBR_TEST_THING';
commit;

PAUSE switch to other window to query
PAUSE INSERT new row
insert into canary_sch.ebr_things
(thing_id, thing_name, thing_create_date,
 attribute1, attribute2, attribute3, attribute4,
 flag1, flag2, flag3, flag4)
values
(-2319, 'NEW TEST THING', sysdate,
 'GREEN', 'SQUARE', 'JONES INDUSTRIES', 'MAGICAL',
 'N', 'N', 'N', 'N');
commit;
