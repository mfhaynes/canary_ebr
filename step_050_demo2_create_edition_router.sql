pause create a table to store edition routing information
CREATE TABLE edition_router
(edition_name varchar2(128) NOT NULL,
 percentage number(3,2) NOT NULL,
 CONSTRAINT check_percentage
 CHECK (percentage >=0 and percentage <= 1))
TABLESPACE canary_ts;

pause create a primary key on the table
CREATE UNIQUE INDEX edition_router_pkidx
ON edition_router (edition_name)
TABLESPACE canary_ts;

ALTER TABLE edition_router
ADD CONSTRAINT edition_router_pk PRIMARY KEY (edition_name)
    USING INDEX edition_router_pkidx;

pause Add the default edition to the router.
INSERT INTO edition_router
VALUES ('ORA$BASE',1);
