prompt Connect as System ID
@../private/connect_system.sql
CREATE OR REPLACE FUNCTION get_random_edition RETURN VARCHAR2 AS
    v_selected_edition VARCHAR2(128);
BEGIN
    WITH random_value AS (SELECT /*+ materialize */ dbms_random.value() AS result FROM dual)
    SELECT edition_name INTO v_selected_edition
    FROM (SELECT edition_name, NVL(LAG(run_tot) OVER (ORDER BY edition_name),0) AS low_pct, run_tot AS high_pct
          FROM (SELECT edition_name, percentage, SUM(percentage) OVER(ORDER BY edition_name) run_tot FROM canary_sch.edition_router))
    CROSS JOIN random_value
    WHERE random_value.result BETWEEN low_pct AND high_pct;
    RETURN v_selected_edition;
END;
/
