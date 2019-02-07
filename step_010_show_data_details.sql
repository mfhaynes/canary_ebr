prompt Connect as canary_sch
connect canary_sch@mfhsrc02_pdb1
set echo on
select count(*) from canary_sch.ebr_things;

select count(*) from canary_sch.ebr_thing_attributes;

select * from canary_sch.ebr_things
where thing_name = 'GUMBALL';

select attr.*
from canary_sch.ebr_thing_attributes attr
join canary_sch.ebr_things t on t.thing_id = attr.thing_id
where t.thing_name = 'GUMBALL'
order by attr.thing_attribute_type;
