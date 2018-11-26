#!/usr/bin/python3

import cx_Oracle
import getpass

v_password = getpass.getpass('Enter password: ')
v_connection = cx_Oracle.connect('canary_app',v_password,'mfhsrc02_pdb1')
