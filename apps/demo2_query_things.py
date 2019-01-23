#!/usr/bin/python3

import cx_Oracle
import getpass
from datetime import datetime

def make_connection(p_password):
    v_connection = cx_Oracle.connect('canary_app',v_password,'mfhsrc02_pdb1',edition='ORA$BASE')
    v_cursor = v_connection.cursor()
    v_cursor.execute("select sys_context('USERENV', 'SESSION_EDITION_NAME') from dual")
    v_edition = v_cursor.fetchone()[0]
    v_start_time = datetime.now()
    return v_connection, v_cursor, v_edition, v_start_time

v_password = getpass.getpass('Enter password: ')
v_iteration_counter = 0
while [ 1 == 1 ]:
    v_iteration_counter += 1
    v_edition_results = {}
    v_connection, v_cursor, v_edition, v_start_time = make_connection(v_password)
    v_cursor.execute ('select object_id from all_objects where rownum <= 5000');
    v_object_keys = v_cursor.fetchall()
    v_counter = 0
    # Reset start time to clear out time spent getting keys.
    v_start_time = datetime.now()
    for v_object_key in v_object_keys:
        v_counter += 1
        v_app_query = """select t.thing_id, t.thing_name, t.thing_create_date,
                          (SELECT ta.thing_attribute_value
                           FROM canary_sch.ebr_thing_attributes ta
                           WHERE ta.thing_id = t.thing_id
                             AND ta.thing_attribute_type = 'object_type') AS object_type,
                          (SELECT ta.thing_attribute_value
                           FROM canary_sch.ebr_thing_attributes ta
                           WHERE ta.thing_id = t.thing_id
                             AND ta.thing_attribute_type = 'editionable_flag') AS editionable_flag,
                          (SELECT ta.thing_attribute_value
                           FROM canary_sch.ebr_thing_attributes ta
                           WHERE ta.thing_id = t.thing_id
                             AND ta.thing_attribute_type = 'status') AS status,
                          (SELECT ta.thing_attribute_value
                           FROM canary_sch.ebr_thing_attributes ta
                           WHERE ta.thing_id = t.thing_id
                             AND ta.thing_attribute_type = 'temporary_flag') AS temporary,
                          (SELECT ta.thing_attribute_value
                           FROM canary_sch.ebr_thing_attributes ta
                           WHERE ta.thing_id = t.thing_id
                             AND ta.thing_attribute_type = 'generated_flag') AS generated,
                          (SELECT ta.thing_attribute_value
                           FROM canary_sch.ebr_thing_attributes ta
                           WHERE ta.thing_id = t.thing_id
                             AND ta.thing_attribute_type = 'secondary_flag') AS secondary,
                          (SELECT ta.thing_attribute_value
                           FROM canary_sch.ebr_thing_attributes ta
                           WHERE ta.thing_id = t.thing_id
                             AND ta.thing_attribute_type = 'timestamp') AS timestamp,
                          (SELECT ta.thing_attribute_value
                           FROM canary_sch.ebr_thing_attributes ta
                           WHERE ta.thing_id = t.thing_id
                             AND ta.thing_attribute_type = 'default_collation') AS default_collation
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
            v_connection, v_cursor, v_edition, v_start_time = make_connection(v_password)

    print ('Iteration '+str(v_iteration_counter)+' Results')
    print ('Edition'.ljust(30)
           + ' Runs   '
           + 'Avg Run Time (ms)')
    for v_edition in sorted(v_edition_results.keys()):
        v_iteration_ms = (v_edition_results[v_edition]['run_time'].total_seconds()*1000)
        v_average_ms = round(v_iteration_ms/v_edition_results[v_edition]['executions'],3)
        print (v_edition.ljust(30) 
               + str(v_edition_results[v_edition]['executions']).rjust(5)
               + '   '
               + str(v_average_ms).rjust(16))
    print ('---------------------------------------------------------------------')
