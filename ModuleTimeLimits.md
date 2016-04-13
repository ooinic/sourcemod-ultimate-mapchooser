# Purpose #
> The Time Limits module extends Ultimate Mapchooser's exclusion system to allow users to specify, in their UMC-Mapcycle definitions, a range of time when a map is available. Specifically, it defines two new group options **"default\_min\_time"** and **"default\_max\_time"**, and two new map options **"min\_time"** and **"max\_time"**.
```
"umc_mapcycle"
{
    "A Group"
    {
        "default_min_time"  "HHMM"
        "default_max_time"  "HHMM"
        ...

        "A Map"
        {
            "min_time"  "HHMM"
            "max_time"  "HHMM"
            ...
        }
    }
    ...
}
```
> Where **HH** is the hour (in 24-hour format) and **MM** is the minute. The group options specify the defaults for all the maps in the group, in the event that the maps do not define their own "min\_time" and "max\_time" options.

# Example #
```
"umc_mapcycle"
{
    "GroupA"
    {
        "default_min_time"  "0000"
        "default_max_time"  "1159"

        "MapAA"
        {
        }

        "MapBA"
        {
        }
    }

    "GroupB"
    {
        "default_min_time"  "1200"
        "default_max_time"  "2359"

        "MapAB"
        {
            "min_time"  "0000"
        }

        "MapBB"
        {
        }
    }
}
```
> This example defines two Map Groups, "GroupA" and "GroupB", and two maps in each group.  "GroupA" has the options "default\_min\_time" and "default\_max\_time" set so that all its maps are by default available between 12:00AM (midnight) and 11:59AM. Since none of it's maps specify "min\_time" or "max\_time", these defaults are not overridden and are used by both maps.

> In "GroupB", "default\_min\_time" and "default\_max\_time" are set so that the group is available between 12:00PM (noon) and 11:59PM. "MapAB" has defined a "min\_time" of 12:00AM, thus making it's time range 12:00AM - 11:59PM. "MapBB" does not specify it's own "min\_time" or "max\_time," so it will use the defaults for "GroupB."

# List of CVars #
> The list of cvars for the Time Limits module is located in **cfg/sourcemod/umc-timelimits.cfg**.
```
// Determines if maps being displayed are exempt from being excluded due to Time Limits.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_timelimits_ignoredisplay "0"

// Determines if nominations are exempt from being excluded due to Time Limits.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_timelimits_ignorenominations "0"
```