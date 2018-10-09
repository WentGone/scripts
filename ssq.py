#!/usr/bin/env python
from random import randint

red_balls = []
blue_balls = []

while True:
  red = randint(1,16)
  if red not in red_balls:
    red_balls.append(red)
  if len(red_balls) == 5:
    break
while True:
  blue = randint(1,16)
  if blue not in red_balls and blue not in blue_balls:
    blue_balls.append(blue)
  if len(blue_balls) == 2:
    break

print red_balls
print blue_balls
