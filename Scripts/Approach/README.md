# Approach
_Automated approach script using RangeFinder and PID loop_

This script is assembled from this reddit thread, piecing together the info from various comments and adjusting it to work with the Jilted.
Setup assumes a single RangeFinder for the Distance calculation and a number of RangeFinders to assist it.

*Field names*:
```
  :Approach bool   enable approach
  :Cruise   int    LeverBindSpeed FCUForward
  :Distance float  RangeFinderDistance
  :RFC      float  RangeFinderDistance of optional extra RangeFinders
```
