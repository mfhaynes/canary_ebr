#!/usr/bin/python3

import getpass
import demo1_library
import imp
import hashlib

def get_file_checksum(p_file_name):
    v_hasher_object = hashlib.md5()
    with open(p_file_name, 'rb') as v_library_file:
        v_file_chunk = v_library_file.read()
        v_hasher_object.update(v_file_chunk)
    return v_hasher_object.hexdigest()

v_current_checksum = get_file_checksum('demo1_library.py')
v_password = getpass.getpass('Enter password: ')
v_iteration_counter = 0
while [ 1 == 1 ]:
    v_iteration_counter += 1
    v_edition_results = demo2_library.run_app(v_password)

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
    v_new_checksum = get_file_checksum('demo1_library.py')
    if v_new_checksum != v_current_checksum:
        print ('Re-importing!')
        v_current_checksum = v_new_checksum
        imp.reload(demo1_library)
