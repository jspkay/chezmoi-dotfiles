#!/bin/python3 

import os 
import sys

print(sys.argv)
MAX = int(os.popen("brightnessctl m").read())
current = os.popen("brightnessctl g").read()
current = int(current)/MAX
inc = 0.05
print(current)
if sys.argv[1] == "plus":
    next = current + 1.9*inc # add `inc` percent
    next = next - (next % inc) # floor to have `inc` increment
elif sys.argv[1] == "minus":
    next = current - 0.9*inc # remove `inc` percent
    next = next - (next % inc) # floor it 
    if next <= 0.01:
        next = 0.01
else:
    raise Exception("Error! Argument not compatible!")
print(next)
os.system(f"brightnessctl s {int(next*100)}%")
