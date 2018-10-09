#!/bin/bash
echo -n "red color balls are: "
for i in {1..5}
do
	red_num=$[RANDOM%33+1]
	echo -n ${red_num}" "
done

echo

echo -n "blue color balls are: "
for j in {1..2}
do
	blue_num=$[RANDOM%16+1]
	echo -n ${blue_num}" "
done

echo
