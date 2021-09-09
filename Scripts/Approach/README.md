# Approach
_Automated approach script using RangeFinder and PID loop_

This script is assembled from [this reddit thread][1], piecing together the info from various comments and adjusting it to work with the Jilted.
Setup assumes a single RangeFinder for the Distance calculation and a number of RangeFinders to assist it.

*Field names*:
```
  :Approach bool   enable approach
  :Distance float  RangeFinderDistance
  :RFC      float  RangeFinderDistance of optional extra RangeFinders
```

Testing the actual approach PID loop is not possible without having an environment in the test runner that responds to eg. FCU* commands.

[1]: https://www.reddit.com/r/starbase/comments/p5mifp/safely_approach_asteroids_with_a_pid_controller/
