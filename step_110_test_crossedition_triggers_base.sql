PAUSE connect to canary_app and override edition to ORA$BASE
connect canary_app@&database
set echo on
alter session set edition=ORA$BASE;

PAUSE First, show we are in original edition
select attribute1
from canary_sch.ebr_things
where thing_id = -123;

select thing_attribute_value
from canary_sch.ebr_thing_atributes
where thing_id = -123
  and thing_attribute_type = 'attribute1';

PAUSE Now go to other edition and run same queries.

PAUSE Start Testing Forward Cross-Edition Triggers
PAUSE show information about the attribute for one THING
select attr.*
from canary_sch.ebr_thing_attributes attr
join canary_sch.ebr_things t on attr.thing_id = t.thing_id
where t.thing_name = 'GUMBALL'
  and attr.thing_attribute_type = 'attribute1';

PAUSE switch to other window and run first query
PAUSE update the data here
update canary_sch.ebr_thing_attributes attr
set thing_attribute_value = 'YELLOW'
where thing_id in (select thing_id from canary_sch.ebr_things where thing_name = 'GUMBALL')
  and thing_attribute_type = 'attribute1';

select attr.*
from canary_sch.ebr_thing_attributes attr
join canary_sch.ebr_things t on attr.thing_id = t.thing_id
where t.thing_name = 'GUMBALL'
  and attr.thing_attribute_type = 'attribute1';

PAUSE Switch to other window to run pre-commit query
PAUSE execute commit
commit;
PAUSE switch to other window to run post-commit query

PAUSE Show that no THING called EBR_TEST_THING exists yet.
select * from canary_sch.ebr_things where thing_name = 'EBR_TEST_THING';

PAUSE INSERT new thing and attributes.
insert into canary_sch.ebr_things values(-999,'EBR_TEST_THING',sysdate);
insert into canary_sch.ebr_thing_attributes values (-999,'attribute1','ORANGE');
insert into canary_sch.ebr_thing_attributes values (-999,'attribute2','OBLONG');
insert into canary_sch.ebr_thing_attributes values (-999,'attribute3','COLUMBUS MANUFACTURERS');
insert into canary_sch.ebr_thing_attributes values (-999,'flag1','Y');
insert into canary_sch.ebr_thing_attributes values (-999,'flag2','N');
insert into canary_sch.ebr_thing_attributes values (-999,'flag3','N');
commit;

PAUSE Switch to other window to look at EBR_TEST_THING data.
PAUSE DELETE one attribute for EBR_TEST_THING and update another.
delete from canary_sch.ebr_thing_attributes where thing_id = -999 and thing_attribute_type = 'attribute2';
update canary_sch.ebr_thing_attributes set thing_attribute_value = 'DENVER AMALGAMATED PARTNERS'
where thing_id = -999 and thing_attribute_type = 'attribute3';
commit;

PAUSE Switch to other window to look at updated EBR_TEST_THING data.

PAUSE Start to Test Reverse Cross-Edition Triggers

PAUSE check the color of our gumball before making change in other window.
SELECT * from canary_sch.ebr_thing_attributes where thing_id = -123;

PAUSE check the color of our gumball after making change in other window.
SELECT * from canary_sch.ebr_thing_attributes where thing_id = -123;

PAUSE check the number of attributes showing up for TEST_THING before deleting in release1 edition
select count(*) From canary_sch.ebr_thing_attributes where thing_id = -999;

PAUSE check the number of attributes showing up for TEST_THING after deleting in release1 edition
select count(*) From canary_sch.ebr_thing_attributes where thing_id = -999;

PAUSE check for rows in both tables with thing_id = -2319 before performing insert in release1
select * from canary_sch.ebr_things where thing_id = -2319;
select * from canary_sch.ebr_thing_attributes where thing_id = -2319;

PAUSE check for rows in both tables with thing_id = -2319 after performing insert in release1
select * from canary_sch.ebr_things where thing_id = -2319;
select * from canary_sch.ebr_thing_attributes where thing_id = -2319;
