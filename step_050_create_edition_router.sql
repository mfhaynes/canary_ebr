CREATE TABLE edition_router
(edition_name varchar2(128),
 percentage number(3,2))
TABLESPACE canary_ts;
INSERT INTO edition_router
VALUES ('ORA$BASE',1);
