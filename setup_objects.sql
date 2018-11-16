create table ebr_test_tab (field1 varchar2(30), field2 number)
tablespace canary_ts;
insert into ebr_test_tab
(SELECT object_name, object_id FROM dba_objects);
commit;
insert into ebr_test_tab (select * from ebr_test_tab);
commit;
