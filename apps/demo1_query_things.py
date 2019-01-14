#!/usr/bin/python3

import cx_Oracle
import getpass
from datetime import datetime

v_password = getpass.getpass('Enter password: ')
v_connection = cx_Oracle.connect('canary_app',v_password,'mfhsrc02_pdb1')
v_cursor = v_connection.cursor()
v_cursor.execute ('select object_id from all_objects');
v_object_keys = v_cursor.fetchall()
v_counter = 0
v_start_time = datetime.now()
for v_object_key in v_object_keys:
    v_counter += 1
    v_cursor.execute('select * from canary_sch.ebr_things_with_attributes where thing_id = :thing',
                     {'thing': v_object_key[0]})
    v_thing = v_cursor.fetchone()
    if v_counter == 1000:
        v_total_time = datetime.now()-v_start_time
        print(str(v_total_time))
        # Close and re-open the connection for demo purposes.
        v_connection.close()
        v_connection = cx_Oracle.connect('canary_app',v_password,'mfhsrc02_pdb1')
        v_cursor = v_connection.cursor()
        v_counter = 0
        v_start_time = datetime.now()
