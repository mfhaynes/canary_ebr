connect canary_sch@&database
DELETE FROM canary_sch.edition_router 
WHERE edition_name = 'ORA$BASE';
UPDATE canary_sch.edition_router
set percentage = 1
where edition_name = 'release1';

PAUSE Once we commit, the change will take effect.
COMMIT;
