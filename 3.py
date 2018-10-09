#!/usr/bin/env python

import os
import re
import sys

def countpatt(patt,fname):
    db={}
    with file(name) as f:
        for eachline in f:
            m = re.search(patt,eachline)
            if m is not None:
            dbkey = m.group()
            db[dbkey] = db.get(dbkey) + 1
    return db
    
