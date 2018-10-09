#!/bin/bash
cd changename
for name in `ls *.$1`
do
	na=${name%.*}
	mv ${name} ${na}.$2
done
