#!/usr/bin/env python
try:
    num = int(raw_input('number: '))
    res = 100 / num
except (ValueError, ZeroDivisionError),e:
    print 'error',e
