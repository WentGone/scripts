#!/bin/bash
cat /data/scripts/liveshow/competition/letter/letter.txt | boxes -d dog -a c | pv -qL 20
