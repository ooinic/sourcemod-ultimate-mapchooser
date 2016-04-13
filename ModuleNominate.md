# Purpose #

> The Nomination module is used to nominate maps for Ultimate Mapchooser votes, similar to the functionality built into SourceMod by the nominate.smx plugin. This module provides clients on the server a way to nominate maps through a menu, either by typing "nominate" in chat, or using the "sm\_nominate" command.

> _**sm\_nominate**_ -- Displays a nomination menu to the client who used the command.

> Maps appearing in the nomination menu follow the Nomination and Display Exclusion guidelines, outlined [here](AboutExclusion.md).

> The Nomination module also defined one new map option, **nominate\_flags**, as well as one new map group option, also called **nominate\_flags**.
```
"umc_mapcycle"
{
    "A Group"
    {
        "nominate_flags"  "FLAG_STRING"
        ...

        "A Map"
        {
            "nominate_flags"  "FLAG_STRING"
            ...
        }
    }
    ...
}
```
> <b>FLAG_STRING</b> is a string containing [SourceMod admin flags](http://wiki.alliedmods.net/Adding_Admins_(SourceMod)#Levels), one of which an admin must require in order to nominate that map. The **nominate\_flags** at the group level defines the **nominate\_flags** option for all maps in the group, manually defining **nominate\_flags** for a map overrides the group setting. If the group-level **nominate\_flags** is left blank or omitted, the flags specified in the _sm\_umc\_nominate\_adminflags_ cvar are used (see cvars below).

# List of CVars #
> The list of cvars for the Nomination module is located in **cfg/sourcemod/umc-nominate.cfg**.
```
// File to use for Ultimate Mapchooser's map rotation.
// -
// Default: "umc_mapcycle.txt"
sm_umc_nominate_cyclefile "umc_mapcycle.txt"

// Specifies whether players have the ability to nominate maps for votes.
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_nominate_enabled "1"

// Specifies how many past map groups to exclude from nominations.
// -
// Default: "0"
// Minimum: "0.000000"
sm_umc_nominate_groupexclude "0"

// Specifies how many past maps to exclude from nominations.
// -
// Default: "3"
// Minimum: "0.000000"
sm_umc_nominate_mapexclude "3"

// Determines the order of maps in the nomination menu.
//  0 - Same as mapcycle,
//  1 - Alphabetical
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_nominate_sorted "0"

// Organizes the nomination menu so that users select a group first, then a map.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_nominate_tiermenu "0"
```