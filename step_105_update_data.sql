pause Connect with explicit EDITION setting
connect canary_sch@&database edition=ORA$BASE

set echo on
pause Load the new columns on the THINGS table from the ATTRIBUTES table.
pause Do this by firing the Forward Cross-Edition Trigger from ORA$BASE session.
pause Do this in a loop with incremental commits to avoid any lengthy locks.

DECLARE
  v_percentile number := .01;
  v_upper_bound number := -99999999;
  v_lower_bound number;
BEGIN
    WHILE v_percentile < 1
    LOOP
        v_lower_bound := v_upper_bound;

        SELECT percentile_disc(v_percentile) WITHIN GROUP (ORDER BY thing_id) 
        INTO v_upper_bound 
        FROM ebr_thing_attributes;

        UPDATE ebr_thing_attributes
        SET thing_attribute_type = thing_attribute_type 
        WHERE thing_id BETWEEN v_lower_bound AND v_upper_bound;

        COMMIT;

        v_percentile := v_percentile + .01;
    END LOOP;
END;
/
