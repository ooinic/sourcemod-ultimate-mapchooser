# Purpose #
> The Random Mapcycle module is used to randomly pick a map from its defined UMC-Mapcycle to be the next map. This selection is done at the end of the map, in order to ensure that the conditions for exclusion and weighting are as close as possible to what they will be when the selected map is actually played. Random Mapcycle will NOT set a next map if at any point during the current map, Ultimate Mapchooser sets the next map (could be from a vote, command, etc.).

> The module also allows some control over the randomization. Users can define which group should be randomly picked from on a per-map and per-group basis. Note that if there are no available maps from this defined map group (they are all excluded), then a random group is selected.

> This module defines one new map group option, **"next\_mapgroup"**, and one new map option, also **"next\_mapgroup"**. The group option is used as a default in the event that the map option is omitted in the UMC-Mapcycle definition.
```
"umc_mapcycle"
{
    "A Group"
    {
        "next_mapgroup"  "GROUPNAME"
        ...

        "A Map"
        {
            "next_mapgroup"  "GROUPNAME"
            ...
        }
    }
    ...
}
```
> Where **GROUPNAME** is the name of the mapgroup to be selected from next time, or nothing ("") if it should select from every group.

# List of Commands #
> Random Mapcycle provides the following commands:
    * _sm\_umc\_randcycle\_picknextmapnow_ - Sets the next map to a random map.

# Example #
```
"umc_mapcycle"
{
    "GroupA"
    {
        "next_mapgroup"  "GroupB"

        "MapAA"
        {
            "next_mapgroup"  ""
        }

        "MapBA"
        {
        }
    }

    "GroupB"
    {
        "MapAB"
        {
        }

        "MapBB"
        {
        }
    }
}
```
> This example defines two Map Groups, "GroupA" and "GroupB", and two maps in each group. "GroupA" has the option "next\_mapgroup" set so that if the map currently being played is from "GroupA", Random Mapcycle will try and select a random map from "GroupB". "MapAA" defines it's own "next\_mapgroup", and  is set so that the next map group will be selected at random. So if the current map is "MapAA" from group "GroupB", then Random Mapcycle will select a random map from a random map group.

> In "GroupB", "next\_mapgroup" is not defined, so by default it will be randomly selecting the next map from a randomly selected map group.

# List of CVars #
> The list of cvars for Random Mapcycle is defined in **cfg/sourcemod/umc-randomcycle.cfg**.
```
// File to use for Ultimate Mapchooser's map rotation.
// -
// Default: "umc_mapcycle.txt"
sm_umc_randcycle_cyclefile "umc_mapcycle.txt"

// Enables random selection of the next map at the end of each map if a vote hasn't taken place.
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_randcycle_enabled "1"

// Specifies how many past map groups to exclude when picking a random map.
// -
// Default: "0"
// Minimum: "0.000000"
sm_umc_randcycle_groupexclude "0"

// Specifies how many past maps to exclude when picking a random map.
// -
// Default: "3"
// Minimum: "0.000000"
sm_umc_randcycle_mapexclude "3"
```