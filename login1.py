#!/usr/bin/env python

print "welcome to my login program"
username = raw_input("username: ")
password = raw_input("password: ")

if username == 'bob' and password == '123456':
    print "login successful"
else:
    print "login incorrect"

