#!/usr/bin/env python3
import pprint
import json
import sys
import os


fname = sys.argv[1]
if not os.path.exists(fname):
    print("File not Found!")
    sys.exit(2)
else:
    with open(fname) as fobj:
        data = json.loads(fobj.read())
        pprint.pprint(data)

