prompt connect as Canary Schema ID
connect canary_sch@&database
CREATE TABLE ebr_test_tab_01
(field1 varchar2(128),
 field2 number,
 field3 char(1000))
tablespace canary_ts;
INSERT INTO ebr_test_tab_01
(SELECT object_name, object_id, object_name FROM dba_objects);
COMMIT;
INSERT INTO ebr_test_tab_01 (SELECT * FROM ebr_test_tab_01);
COMMIT;
CREATE OR REPLACE FUNCTION get_max_field2 RETURN number
IS
  max_field2 number;
BEGIN
  FOR test_rec IN (SELECT * FROM ebr_test_tab_01)
  LOOP
    IF test_rec.field2 > max_field2 OR max_field2 IS NULL
    THEN
      max_field2 := test_rec.field2;
    END IF;
  END LOOP;
  RETURN max_field2;
END;
/
GRANT EXECUTE ON get_max_field2 TO canary_app;
