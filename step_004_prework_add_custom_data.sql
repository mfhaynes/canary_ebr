set echo on
insert into ebr_things_b
(thing_id, thing_name, thing_create_date)
values
(-123, 'GUMBALL', sysdate);

insert into ebr_thing_attributes_b
(thing_id, thing_attribute_type, thing_attribute_value)
values
(-123, 'attribute1', 'BLUE');

insert into ebr_thing_attributes_b
(thing_id, thing_attribute_type, thing_attribute_value)
values
(-123, 'attribute2', 'ROUND');

insert into ebr_thing_attributes_b
(thing_id, thing_attribute_type, thing_attribute_value)
values
(-123, 'attribute3', 'MEGA BUBBLE INC.');

insert into ebr_thing_attributes_b
(thing_id, thing_attribute_type, thing_attribute_value)
values
(-123, 'attribute4', 'SUGAR FREE');

insert into ebr_thing_attributes_b
(thing_id, thing_attribute_type, thing_attribute_value)
values
(-123, 'flag1', 'Y');

insert into ebr_thing_attributes_b
(thing_id, thing_attribute_type, thing_attribute_value)
values
(-123, 'flag2', 'N');

insert into ebr_thing_attributes_b
(thing_id, thing_attribute_type, thing_attribute_value)
values
(-123, 'flag3', 'Y');

insert into ebr_thing_attributes_b
(thing_id, thing_attribute_type, thing_attribute_value)
values
(-123, 'flag4', 'Y');

commit;
