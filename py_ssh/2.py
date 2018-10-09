#!/usr/bin/env python
with open('1.txt') as f:
    file_names = f.readlines()
    for file_name in file_names:
        file_name = file_name.rstrip('\n')
        print file_name
