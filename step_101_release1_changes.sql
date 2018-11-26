connect canary_sch@&database edition=release1
CREATE INDEX ebr_test_idx_01 on ebr_test_tab_01 (field2) tablespace canary_ts;
CREATE OR REPLACE FUNCTION get_max_field2 RETURN number
IS
  max_field2 number;
BEGIN
  SELECT max(field2) INTO max_field2 FROM ebr_test_tab_01;
  RETURN max_field2;
END;
/
