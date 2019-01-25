PAUSE connect to canary_app and override edition to ORA$BASE
connect canary_app@&database
set echo on
alter session set edition=ORA$BASE;
PAUSE show information about the attribute for one THING
select attr.*
from canary_sch.ebr_thing_attributes attr
join canary_sch.ebr_things t on attr.thing_id = t.thing_id
where t.thing_name = 'V_$SESSION'
  and attr.thing_attribute_type = 'object_type';
PAUSE after showing the same data in RELEASE1, update the data here
update canary_sch.ebr_thing_attributes attr
set thing_attribute_value = 'SUPER-VIEW'
where thing_id in (select thing_id from canary_sch.ebr_things where thing_name = 'V_$SESSION')
  and thing_attribute_type = 'object_type';
select attr.*
from canary_sch.ebr_thing_attributes attr
join canary_sch.ebr_things t on attr.thing_id = t.thing_id
where t.thing_name = 'V_$SESSION'
  and attr.thing_attribute_type = 'object_type';
PAUSE Check RELEASE1 session and confirm no change since not yet committed. Then commit and re-check.
commit;
PAUSE INSERT test after showing that no EBR_TEST_THING data exists yet.
insert into canary_sch.ebr_things values(-999,'EBR_TEST_THING',sysdate);
insert into canary_sch.ebr_thing_attributes values (-999,'object_type','SUPER-DUPER-VIEW');
insert into canary_sch.ebr_thing_attributes values (-999,'editionable_flag','Y');
insert into canary_sch.ebr_thing_attributes values (-999,'status','INVALID');
insert into canary_sch.ebr_thing_attributes values (-999,'generated_flag','N');
insert into canary_sch.ebr_thing_attributes values (-999,'secondary_flag','N');
commit;
PAUSE DELETE test
delete from canary_sch.ebr_thing_attributes where thing_id = -999 and thing_attribute_type = 'status';
commit;
PAUSE check the number of attributes showing up in base edition before deleting in release1 edition
select count(*) From canary_sch.ebr_thing_attributes where thing_id = -999;
PAUSE check the number of attributes showing up in base edition after deleting in release1 edition
select count(*) From canary_sch.ebr_thing_attributes where thing_id = -999;
PAUSE check for rows in both tables with thing_id = -1234 before performing insert in release1
select * from canary_sch.ebr_things where thing_id = -1234;
select * from canary_sch.ebr_thing_attributes where thing_id = -1234;
PAUSE check for rows in both tables with thing_id = -1234 after performing insert in release1
select * from canary_sch.ebr_things where thing_id = -1234;
select * from canary_sch.ebr_thing_attributes where thing_id = -1234;
