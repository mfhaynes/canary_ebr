prompt connect as Canary Schema ID
connect canary_sch@&database
CREATE TABLE ebr_things_b
(thing_id number NOT NULL,
 thing_name varchar2(128),
 thing_create_date date)
tablespace canary_ts;
CREATE UNIQUE INDEX ebr_things_pkidx
ON ebr_things_b (thing_id)
tablespace canary_ts;
ALTER TABLE ebr_things_b
ADD CONSTRAINT ebr_things_pk PRIMARY KEY (thing_id)
    USING INDEX ebr_things_pkidx;
INSERT INTO ebr_things_b
(SELECT object_id, object_name, created FROM dba_objects
 WHERE object_id IS NOT NULL);
COMMIT;
CREATE TABLE ebr_thing_attributes_b
(thing_id number NOT NULL,
 thing_attribute_type varchar2(30) NOT NULL,
 thing_attribute_value varchar2(30))
tablespace canary_ts;
ALTER TABLE ebr_thing_attributes_b
ADD CONSTRAINT thing_id_fk
FOREIGN KEY (thing_id)
REFERENCES ebr_things_b (thing_id);
INSERT INTO ebr_thing_attributes_b
(SELECT object_id, 'object_type', object_type
 FROM dba_objects
 WHERE object_id IN (SELECT thing_id FROM ebr_things_b));
INSERT INTO ebr_thing_attributes_b
(SELECT object_id, 'editionable_flag', editionable
 FROM dba_objects
 WHERE object_id IN (SELECT thing_id FROM ebr_things_b));
COMMIT;
