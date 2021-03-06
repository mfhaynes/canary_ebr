#!/usr/bin/python3

import cx_Oracle
from datetime import datetime

def make_connection(p_password):
    v_connection = cx_Oracle.connect('canary_app',p_password,'mfhsrc02_pdb1',edition='ORA$BASE')
    v_cursor = v_connection.cursor()
    v_cursor.execute("select sys_context('USERENV', 'SESSION_EDITION_NAME') from dual")
    v_edition = v_cursor.fetchone()[0]
    v_start_time = datetime.now()
    return v_connection, v_cursor, v_edition, v_start_time

def run_app(p_password):
    v_edition_results = {}
    v_connection, v_cursor, v_edition, v_start_time = make_connection(p_password)
    v_cursor.execute ('select object_id from all_objects where rownum <= 5000');
    v_object_keys = v_cursor.fetchall()
    v_counter = 0
    # Reset start time to adjust for time spent getting keys.
    v_start_time = datetime.now()
    for v_object_key in v_object_keys:
        v_counter += 1
        v_app_query = """select t.thing_id, t.thing_name, t.thing_create_date,
                         (SELECT ta.thing_attribute_value
                          FROM canary_sch.ebr_thing_attributes ta
                          WHERE ta.thing_id = t.thing_id
                            AND ta.thing_attribute_type = 'attribute1') AS attribute1,
                         (SELECT ta.thing_attribute_value
                          FROM canary_sch.ebr_thing_attributes ta
                          WHERE ta.thing_id = t.thing_id
                            AND ta.thing_attribute_type = 'attribute2') AS attribute2,
                         (SELECT ta.thing_attribute_value
                          FROM canary_sch.ebr_thing_attributes ta
                          WHERE ta.thing_id = t.thing_id
                            AND ta.thing_attribute_type = 'attribute3') AS attribute3,
                         (SELECT ta.thing_attribute_value
                          FROM canary_sch.ebr_thing_attributes ta
                          WHERE ta.thing_id = t.thing_id
                            AND ta.thing_attribute_type = 'attribute4') AS attribute4,
                         (SELECT ta.thing_attribute_value
                          FROM canary_sch.ebr_thing_attributes ta
                          WHERE ta.thing_id = t.thing_id
                            AND ta.thing_attribute_type = 'flag1') AS flag1,
                         (SELECT ta.thing_attribute_value
                          FROM canary_sch.ebr_thing_attributes ta
                          WHERE ta.thing_id = t.thing_id
                            AND ta.thing_attribute_type = 'flag2') AS flag2,
                         (SELECT ta.thing_attribute_value
                          FROM canary_sch.ebr_thing_attributes ta
                          WHERE ta.thing_id = t.thing_id
                            AND ta.thing_attribute_type = 'flag3') AS flag3,
                         (SELECT ta.thing_attribute_value
                          FROM canary_sch.ebr_thing_attributes ta
                          WHERE ta.thing_id = t.thing_id
                            AND ta.thing_attribute_type = 'flag4') AS flag4
                         from canary_sch.ebr_things t
                         where t.thing_id = :thing
        """
        v_cursor.execute(v_app_query, {'thing': v_object_key[0]})
        v_thing = v_cursor.fetchone()
        if v_counter == 200:
            v_total_time = datetime.now()-v_start_time
            if v_edition in v_edition_results.keys():
                v_edition_results[v_edition]['executions'] += 1
                v_edition_results[v_edition]['run_time'] += v_total_time
            else:
                v_edition_results[v_edition] = {'executions': 1,
                                                'run_time': v_total_time}
            v_counter = 0
            # Close and re-open the connection for demo purposes.
            v_connection.close()
            v_connection, v_cursor, v_edition, v_start_time = make_connection(p_password)

    return v_edition_results
