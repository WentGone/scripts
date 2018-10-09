#!/usr/bin/env python
from random import randint

red_balls = []
blue_balls = []

while True:
  if len(red_balls) == 5:
    break
  else:
  	red = randint(1,33)
	if red not in red_balls:
	  red_balls.append(red)
  if len(blue_balls) == 2:
    continue
  else:
  	blue = randint(1,17)
	if blue not in red_balls and blue not in blue_balls:
	  blue_balls.append(blue)

print red_balls
print blue_balls
