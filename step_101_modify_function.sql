connect canary_sch@&database edition=release1
CREATE OR REPLACE FUNCTION get_max_field2 (in_field1 in varchar2)
RETURN number
IS
  max_field2 number;
BEGIN
  SELECT max(field2) INTO max_field2 
  FROM ebr_test_tab
  WHERE field1 = in_field1;

  RETURN max_field2;
END;
/
