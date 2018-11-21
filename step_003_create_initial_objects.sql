prompt connect as Canary Schema ID
connect canary_sch@&database
CREATE TABLE ebr_test_tab 
(field1 varchar2(128),
 field2 number,
 field3 char(1000))
tablespace canary_ts;
INSERT INTO ebr_test_tab
(SELECT object_name, object_id, object_name FROM dba_objects);
COMMIT;
INSERT INTO ebr_test_tab (SELECT * FROM ebr_test_tab);
COMMIT;
CREATE OR REPLACE FUNCTION get_max_field2 RETURN number
IS
  max_field2 number;
BEGIN
  SELECT max(field2) INTO max_field2 FROM ebr_test_tab;
  RETURN max_field2;
END;
/
