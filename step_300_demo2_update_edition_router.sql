connect canary_sch@&database
DELETE FROM canary_sch.edition_router 
WHERE edition_name = 'ORA$BASE';
INSERT INTO canary_sch.edition_router
VALUES ('release1', 1);

PAUSE Once we commit, the change will take effect.
COMMIT;
