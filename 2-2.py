#!/usr/bin/env python

strings = raw_input('please input something: ')
yuanyin = ['a','e','i','o','u']

def guolv():
    for letter in strings:
         if letter in yuanyin:
             print letter,
             if letter == 'a':
                 numa = numa + 1
    print numa

guolv()
