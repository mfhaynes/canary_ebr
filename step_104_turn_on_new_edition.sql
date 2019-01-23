ALTER TRIGGER ebr_thing_attr_fwd_xed_trig ENABLE;
UPDATE canary_sch.edition_router 
SET percentage = .75
WHERE edition_name = 'ORA$BASE';
INSERT INTO canary_sch.edition_router
VALUES ('release1', .25);
COMMIT;
