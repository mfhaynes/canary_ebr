CREATE OR REPLACE TRIGGER edition_router_trig
AFTER LOGON ON DATABASE WHEN (user = 'CANARY_APP')
BEGIN
    dbms_session.set_edition_deferred(get_random_edition);
EXCEPTION
WHEN OTHERS THEN
    -- In reality, you would want to do some sort of logging/alerting here.
    NULL;
END;
/
