connect canary_sch@&database edition=release1
pause Create the Forward Cross-Edition Trigger
CREATE OR REPLACE TRIGGER ebr_thing_attr_fwd_xed_trig
BEFORE INSERT OR UPDATE OR DELETE ON ebr_thing_attributes_b
FOR EACH ROW
FORWARD CROSSEDITION DISABLE
BEGIN
    IF DELETING THEN
        CASE :old.thing_attribute_type
        WHEN 'attribute1'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET attribute1 = NULL
                 WHERE thing_id = :old.thing_id;
             END;
        WHEN 'attribute2'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET attribute2 = NULL
                 WHERE thing_id = :old.thing_id;
             END;
        WHEN 'attribute3'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET attribute3 = NULL
                 WHERE thing_id = :old.thing_id;
             END;
        WHEN 'attribute4'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET attribute4 = NULL
                 WHERE thing_id = :old.thing_id;
             END;
        WHEN 'flag1'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET flag1 = NULL
                 WHERE thing_id = :old.thing_id;
             END;
        WHEN 'flag2'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET flag2 = NULL
                 WHERE thing_id = :old.thing_id;
             END;
        WHEN 'flag3'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET flag3 = NULL
                 WHERE thing_id = :old.thing_id;
             END;
        WHEN 'flag4'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET flag4 = NULL
                 WHERE thing_id = :old.thing_id;
             END;
        END CASE;
    END IF;

    IF INSERTING OR UPDATING THEN
        CASE :new.thing_attribute_type
        WHEN 'attribute1'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET attribute1 = :new.thing_attribute_value
                 WHERE thing_id = :new.thing_id;
             END;
        WHEN 'attribute2'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET attribute2 = :new.thing_attribute_value
                 WHERE thing_id = :new.thing_id;
             END;
        WHEN 'attribute3'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET attribute3 = :new.thing_attribute_value
                 WHERE thing_id = :new.thing_id;
             END;
        WHEN 'attribute4'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET attribute4 = :new.thing_attribute_value
                 WHERE thing_id = :new.thing_id;
             END;
        WHEN 'flag1'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET flag1 = :new.thing_attribute_value
                 WHERE thing_id = :new.thing_id;
             END;
        WHEN 'flag2'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET flag2 = :new.thing_attribute_value
                 WHERE thing_id = :new.thing_id;
             END;
        WHEN 'flag3'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET flag3 = :new.thing_attribute_value
                 WHERE thing_id = :new.thing_id;
             END;
        WHEN 'flag4'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET flag4 = :new.thing_attribute_value
                 WHERE thing_id = :new.thing_id;
             END;
        END CASE;
    END IF;
END;
/


pause Create Reverse Cross-Edition Trigger to DELETE all attributes BEFORE deleting a THING.
CREATE OR REPLACE TRIGGER ebr_thing_attr_rev_xed_trig_d
BEFORE DELETE on ebr_things_b
FOR EACH ROW
REVERSE CROSSEDITION DISABLE
BEGIN
    DELETE from ebr_thing_attributes_b
    WHERE thing_id = :old.thing_id;
END;
/

pause Create Reverse Cross-Edition Trigger to INSERT or UPDATE attributes applied to a THING.
CREATE OR REPLACE TRIGGER ebr_thing_attr_rev_xed_trig_iu
AFTER INSERT OR UPDATE ON ebr_things_b
FOR EACH ROW
REVERSE CROSSEDITION DISABLE
BEGIN
    IF INSERTING THEN
        IF :new.attribute1 is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'attribute1', :new.attribute1);
        END IF;
        IF :new.attribute2 is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'attribute2', :new.attribute2);
        END IF;
        IF :new.attribute3 is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'attribute3', :new.attribute3);
        END IF;
        IF :new.attribute4 is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'attribute4', :new.attribute4);
        END IF;
        IF :new.flag1 is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'flag1', :new.flag1);
        END IF;
        IF :new.flag2 is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'flag2', :new.flag2);
        END IF;
        IF :new.flag3 is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'flag3', :new.flag3);
        END IF;
        IF :new.flag4 is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'flag4', :new.flag4);
        END IF;
    END IF;

    IF UPDATING THEN
        IF :new.attribute1 is NOT NULL THEN
            if :old.attribute1 is NULL THEN
                INSERT into ebr_thing_attributes_b
                VALUES (:new.thing_id, 'attribute1', :new.attribute1);
            ELSE
                UPDATE ebr_thing_attributes_b
                SET thing_attribute_value = :new.attribute1
                WHERE thing_id = :new.thing_id
                  AND thing_attribute_type = 'attribute1';
            END IF;
        ELSE
            DELETE from ebr_thing_attributes_b
            WHERE thing_id = :new.thing_id
              AND thing_attribute_type = 'attribute1';
        END IF;
        IF :new.attribute2 is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'attribute2', :new.attribute2);
        ELSE
            DELETE from ebr_thing_attributes_b
            WHERE thing_id = :new.thing_id
              AND thing_attribute_type = 'attribute2';
        END IF;
        IF :new.attribute3 is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'attribute3', :new.attribute3);
        ELSE
            DELETE from ebr_thing_attributes_b
            WHERE thing_id = :new.thing_id
              AND thing_attribute_type = 'attribute3';
        END IF;
        IF :new.attribute4 is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'attribute4', :new.attribute4);
        ELSE
            DELETE from ebr_thing_attributes_b
            WHERE thing_id = :new.thing_id
              AND thing_attribute_type = 'attribute4';
        END IF;
        IF :new.flag1 is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'flag1', :new.flag1);
        ELSE
            DELETE from ebr_thing_attributes_b
            WHERE thing_id = :new.thing_id
              AND thing_attribute_type = 'flag1';
        END IF;
        IF :new.flag2 is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'flag2', :new.flag2);
        ELSE
            DELETE from ebr_thing_attributes_b
            WHERE thing_id = :new.thing_id
              AND thing_attribute_type = 'flag2';
        END IF;
        IF :new.flag3 is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'flag3', :new.flag3);
        ELSE
            DELETE from ebr_thing_attributes_b
            WHERE thing_id = :new.thing_id
              AND thing_attribute_type = 'flag3';
        END IF;
        IF :new.flag4 is NOT NULL THEN
            INSERT into ebr_thing_attributes_b
            VALUES (:new.thing_id, 'flag4', :new.flag4);
        ELSE
            DELETE from ebr_thing_attributes_b
            WHERE thing_id = :new.thing_id
              AND thing_attribute_type = 'flag4';
        END IF;
    END IF;
END;
/
