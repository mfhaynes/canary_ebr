CREATE OR REPLACE TRIGGER ebr_thing_attr_fwd_xed_trig
BEFORE INSERT OR UPDATE OR DELETE ON ebr_thing_attributes_b
FOR EACH ROW
FORWARD CROSSEDITION DISABLE
BEGIN
    IF INSERTING THEN
        CASE :new.thing_attribute_type
        WHEN 'object_type'
        THEN BEGIN
                 UPDATE ebr_things_b
                 SET object_type = :new.thing_attribute_value
                 WHERE thing_id = :new.thing_id;
             END;
        END CASE;
    END IF;
END;
/
