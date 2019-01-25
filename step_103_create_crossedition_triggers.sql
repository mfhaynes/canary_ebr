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
                 dbms_output.put_line('In WHEN/UPDATE');
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


CREATE OR REPLACE TRIGGER ebr_thing_attr_rev_xed_trig
BEFORE INSERT OR UPDATE OR DELETE ON ebr_thing_attributes_b
FOR EACH ROW
REVERSE CROSSEDITION DISABLE
BEGIN
    NULL;
END;
/
