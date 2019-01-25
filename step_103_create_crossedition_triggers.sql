CREATE OR REPLACE TRIGGER ebr_thing_attr_fwd_xed_trig
BEFORE INSERT OR UPDATE OR DELETE ON ebr_thing_attributes_b
FOR EACH ROW
FORWARD CROSSEDITION DISABLE
BEGIN
    IF DELETING THEN
        CASE :old.thing_attribute_type
        WHEN 'object_type'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET object_type = NULL
                 WHERE thing_id = :old.thing_id;
             END;
        WHEN 'editionable_flag'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET editionable_flag = NULL
                 WHERE thing_id = :old.thing_id;
             END;
        WHEN 'status'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET status = NULL
                 WHERE thing_id = :old.thing_id;
             END;
        WHEN 'temporary_flag'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET temporary_flag = NULL
                 WHERE thing_id = :old.thing_id;
             END;
        WHEN 'generated_flag'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET generated_flag = NULL
                 WHERE thing_id = :old.thing_id;
             END;
        WHEN 'secondary_flag'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET secondary_flag = NULL
                 WHERE thing_id = :old.thing_id;
             END;
        WHEN 'timestamp'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET timestamp = NULL
                 WHERE thing_id = :old.thing_id;
             END;
        WHEN 'default_collation'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET default_collation = NULL
                 WHERE thing_id = :old.thing_id;
             END;
        END CASE;
    END IF;

    IF INSERTING OR UPDATING THEN
        CASE :new.thing_attribute_type
        WHEN 'object_type'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET object_type = :new.thing_attribute_value
                 WHERE thing_id = :new.thing_id;
             END;
        WHEN 'editionable_flag'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET editionable_flag = :new.thing_attribute_value
                 WHERE thing_id = :new.thing_id;
             END;
        WHEN 'status'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET status = :new.thing_attribute_value
                 WHERE thing_id = :new.thing_id;
             END;
        WHEN 'temporary_flag'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET temporary_flag = :new.thing_attribute_value
                 WHERE thing_id = :new.thing_id;
             END;
        WHEN 'generated_flag'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET generated_flag = :new.thing_attribute_value
                 WHERE thing_id = :new.thing_id;
             END;
        WHEN 'secondary_flag'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET secondary_flag = :new.thing_attribute_value
                 WHERE thing_id = :new.thing_id;
             END;
        WHEN 'timestamp'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET timestamp = :new.thing_attribute_value
                 WHERE thing_id = :new.thing_id;
             END;
        WHEN 'default_collation'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET default_collation = :new.thing_attribute_value
                 WHERE thing_id = :new.thing_id;
             END;
        END CASE;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER ebr_thing_attr_rev_xed_trig_d
BEFORE DELETE on ebr_things_b
FOR EACH ROW
REVERSE CROSSEDITION DISABLE
BEGIN
    DELETE from ebr_thing_attributes_b
    WHERE thing_id = :old.thing_id;
END;
/

CREATE OR REPLACE TRIGGER ebr_thing_attr_rev_xed_trig_iu
AFTER INSERT OR UPDATE ON ebr_things_b
FOR EACH ROW
REVERSE CROSSEDITION DISABLE
BEGIN
    IF INSERTING THEN
        IF :new.object_type is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'object_type', :new.object_type);
        END IF;
        IF :new.editionable_flag is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'editionable_flag', :new.editionable_flag);
        END IF;
        IF :new.status is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'status', :new.status);
        END IF;
        IF :new.temporary_flag is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'temporary_flag', :new.temporary_flag);
        END IF;
        IF :new.generated_flag is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'generated_flag', :new.generated_flag);
        END IF;
        IF :new.secondary_flag is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'secondary_flag', :new.secondary_flag);
        END IF;
        IF :new.timestamp is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'timestamp', :new.timestamp);
        END IF;
        IF :new.default_collation is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'default_collation', :new.default_collation);
        END IF;
    END IF;
END;
/
