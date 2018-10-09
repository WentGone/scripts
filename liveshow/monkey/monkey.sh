#!/bin/bash
counts=1
for i in {1..9}
do
#	counts=`echo "(${counts} + 1) * 2" | bc -l`
	#counts=$[(counts+1)*2]
	counts=$(((counts+1)*2))
done

echo -n "The amount of peach is: "
echo ${counts}
