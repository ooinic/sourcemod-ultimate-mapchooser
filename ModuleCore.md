# Purpose #

> The Core "module" is the only module required by Ultimate Mapchooser. It is what handles the logic behind excluding and weighting maps, as well as hooking all of the natives and forwards together which allows other modules to extend Ultimate Mapchooser. In short, without Core, UMC modules cannot communicate with each other.

> Core also contains a few universal settings which control some general behavior of votes.

> Core defines two map group options, **"maps\_invote"** and **"display-template"**, and two map options, **"display"** and **"nominate\_group"**.
```
"umc_mapcycle"
{
    "A Group"
    {
        "maps_invote"  "X"
        "display-template"  "TEMPLATE_STRING"
        ...

        "A Map"
        {
            "display"  "DISPLAY_STRING"
            "nominate_group"  "GROUP_NAME"
            ...
        }
    }
    ...
}
```
> Where **X** is the number of maps which should appear in the vote (integer greater than or equal to 0), **TEMPLATE\_STRING** is a string that will be displayed for any maps from the group in a vote (it can contain the sub-string "{MAP}" which will be replaced with the name of the map), and **DISPLAY\_STRING** is a string that will be displayed for that map in a vote, overriding whatever was specified by "display-template".

> <b>GROUP_NAME</b> is the name of a map group which you want this map to be associated with if it is nominated. If left blank, the name of the group the map belongs to is used (in this example, "A Group"). This is particularly useful if you are using the Tiered Nomination Menu (see _sm\_umc\_nominate\_tiermenu_ in the [Nomination](ModuleNominate.md) module), since you can then design this UMC-Mapcycle for the nomination menu and use a UMC-Mapcycle with different groups for other modules.

# List of Commands #
> Core provides the following commands:
    * _sm\_umc\_reload\_mapcycles_ - Requests that all modules reload their UMC-Mapcycles.
    * _sm\_umc\_setnextmap `<mapname>`_ - Sets the next map (same functionality as was built into the original mapchooser.smx)
    * _sm\_umc\_stopvote_ - Stops an Ultimate Mapchooser vote currently in progress.
    * _sm\_umc\_displaymaplists `<0|1>`_ - Displays all maplists being used by UMC. Pass 1 as an argument to see them after being filtered through [UMC Map Exclusion](AboutExclusion.md).

# List of CVars #
> The cvar list for the Core module is located in **cfg/sourcemod/ultimate-mapchooser.cfg**.
```
// Specifies a sound to be played each second during the countdown time between runoff and tiered votes. (Sound will be precached and added to the download table.)
// -
// Default: ""
sm_umc_countdown_sound ""

// Determines where in votes the "Don't Change" option will be displayed.
//  0 - Bottom,
//  1 - Top
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_dontchange_display "0"

// Determines where in votes the "Extend Map" option will be displayed.
//  0 - Bottom,
//  1 - Top
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_extend_display "0"

// Enables in-depth logging. Use this to have the plugin log how votes are being populated.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_logging_verbose "0"

// Determines whether slots in runoff votes should be blocked. This value is ignored if the original vote didn't have blocked slots.
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_runoff_blockslots "1"

// Determines where the Runoff Vote Message is displayed on the screen.
//  C - Center Message
//  S - Chat Message
//  T - Top Message
//  H - Hint Message
// -
// Default: "C"
sm_umc_runoff_display "C"

// Specifies whether runoff votes are only displayed to players whose votes were eliminated in the runoff and players who did not vote.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_runoff_selective "0"

// Specifies the maximum number of maps to appear in the second part of a tiered vote.
// -
// Default: "6"
// Minimum: "2.000000"
sm_umc_vote_tieramount "6"

// Determines where the Tiered Vote Message is displayed on the screen.
//  C - Center Message
//  S - Chat Message
//  T - Top Message
//  H - Hint Message
// -
// Default: "C"
sm_umc_vote_tierdisplay "C"
```