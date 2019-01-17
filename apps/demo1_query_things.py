#!/usr/bin/python3

import cx_Oracle
import getpass
from datetime import datetime

def make_connection(p_password):
    v_connection = cx_Oracle.connect('canary_app',v_password,'mfhsrc02_pdb1')
    v_cursor = v_connection.cursor()
    v_cursor.execute("select sys_context('USERENV', 'SESSION_EDITION_NAME') from dual")
    v_edition = v_cursor.fetchone()[0]
    v_start_time = datetime.now()
    return v_connection, v_cursor, v_edition, v_start_time

v_edition_results = {}
v_password = getpass.getpass('Enter password: ')
v_connection, v_cursor, v_edition, v_start_time = make_connection(v_password)
v_cursor.execute ('select object_id from all_objects');
v_object_keys = v_cursor.fetchall()
v_counter = 0
# Reset start time to clear out time spent getting keys.
v_start_time = datetime.now()
for v_object_key in v_object_keys:
    v_counter += 1
    v_cursor.execute('select * from canary_sch.ebr_things_with_attributes where thing_id = :thing',
                     {'thing': v_object_key[0]})
    v_thing = v_cursor.fetchone()
    if v_counter == 1000:
        v_total_time = datetime.now()-v_start_time
        if v_edition in v_edition_results.keys():
            v_edition_results[v_edition]['executions'] += 1
            v_edition_results[v_edition]['run_time'] += v_total_time
        else:
            v_edition_results[v_edition] = {'executions': 1,
                                            'run_time': v_total_time}
        print(v_edition.ljust(30) + str(v_total_time))
        v_counter = 0
        # Close and re-open the connection for demo purposes.
        v_connection.close()
        v_connection, v_cursor, v_edition, v_start_time = make_connection(v_password)

print ('Edition'.ljust(30)
       + ' Runs   '
       + 'Total Run Time   '
       + '  Avg Run Time')
for v_edition in v_edition_results.keys():
    print (v_edition.ljust(30) 
           + str(v_edition_results[v_edition]['executions']).rjust(5)
           + '   '
           + str(v_edition_results[v_edition]['run_time'])
           + '   '
           + str(v_edition_results[v_edition]['run_time']/v_edition_results[v_edition]['executions']))
