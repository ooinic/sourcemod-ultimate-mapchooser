# Purpose #
> The Map Rate Map-Reweighting module will take the average rating of a map from the [Map Rate](http://forums.alliedmods.net/showthread.php?t=164455) SourceMod plugin and use that value to modify the weights of maps in Ultimate Mapchooser. This module requires the Map Rate plugin to be present in order to work.

> This module will modify the calculated weight of a map by multiplying it's weight value by the calculated average rating from Map Rate. Therefore, maps can be made up to five times more likely to be randomly selected by Ultimate Mapchooser.

# Modifying The Reweight Scale #
> The _sm\_umc\_maprate\_expscale_ cvar can be used to modify how the module will scale the average rating for each map to determine the weight.
```
AVG = average rating
SCALE = value of "sm_umc_maprate_expscale"
W = calculated weight

W = AVG ^ SCALE
(average rating is raised to the power of the expscale cvar)
```
> By default, this cvar is set to 1, which creates a linear scale:
```
 AVG | SCALE | W
-----+-------+---
  1  ^   1   = 1
  2  ^   1   = 2
  3  ^   1   = 3
  4  ^   1   = 4
  5  ^   1   = 5
```
> If you set it to 2, for example, the result is no longer linear, and higher ratings now have a bigger impact on the result weight:
```
 AVG | SCALE | W
-----+-------+---
  1  ^   2   = 1
  2  ^   2   = 4
  3  ^   2   = 9
  4  ^   2   = 16
  5  ^   2   = 25
```

# List of Commands #
> The Map Rate Map-Reweighting module provides the following commands:
    * _sm\_umc\_maprate\_testreweight `<mapname>`_ -- Displays the calculated reweight-factor for the given map.

# List of CVars #

> The list of cvars for the Map Rate Map-Reweighting module is located in **cfg/sourcemod/umc-maprate-reweight.cfg**.
```
// Average rating for a map is scaled by this value before being used as a weight. Scaling is calculated using the following formula: weight(map) = avg_rating(map) ^ scale
// -
// Default: "1.0"
// Minimum: "0.000000"
sm_umc_maprate_expscale "1.0"

// Minimum number of ratings required for a map in order for it to be reweighted.
// -
// Default: "5"
// Minimum: "0.000000"
sm_umc_maprate_minvotes "5"


```