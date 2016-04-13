# Purpose #

> The Rock The Vote module is meant to bring Rock The Vote-style voting from SourceMod's _rockthevote.smx_ plugin to Ultimate Mapchooser. As you would expect, this module functions very similar to SourceMod's RTV implementation.

> Players can enter Rock The Vote by typing "rtv" in chat or using the _sm\_umc\_rtv_ or _sm\_umc\_rockthevote_ commands.

> _**sm\_umc\_rtv** and **sm\_umc\_rockthevote**_ -- enters the client into Rock The Vote.

> Once enough players have entered Rock The Vote (determined by a configurable percentage threshold cvar), this module will start a map vote. If the map vote fails, then the server will not be able RTV again until the specified interval (in a cvar) has passed. If the map vote passed, then the next map is set.

> After Ultimate Mapchooser has set the next map (from any module, not just this one), if an RTV then passes, a cvar controls what action should be taken.


# List of CVars #
> The list of cvars for the Rock The Vote module is located in **cfg/sourcemod/umc-rockthevote.cfg**.
```
// Allows a map to appear in the vote more than once. This should be enabled if you want the same map in different categories to be distinct.
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_rtv_allowduplicates "1"

// Specifies how many slots in a vote are disabled to prevent accidental voting.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "5.000000"
sm_umc_rtv_blockslots "0"

// When to change the map after a successful RTV:
//  0 - Instant,
//  1 - Round End,
//  2 - Map End
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "2.000000"
sm_umc_rtv_changetime "0"

// File to use for Ultimate Mapchooser's map rotation.
// -
// Default: "umc_mapcycle.txt"
sm_umc_rtv_cyclefile "umc_mapcycle.txt"

// Adds a "Don't Change" option to RTVs.
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_rtv_dontchange "1"

// Specifies how long a vote should be available for.
// -
// Default: "20"
// Minimum: "10.000000"
sm_umc_rtv_duration "20"

// Enables RTV.
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_rtv_enabled "1"

// Sound file (relative to sound folder) to play at the completion of a vote.
// -
// Default: ""
sm_umc_rtv_endsound ""

// Specifies what action to take if the vote doesn't reach the set theshold.
//  0 - Do Nothing,
//  1 - Perform Runoff Vote
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_rtv_failaction "0"

// Specifies how many past map groups to exclude from RTVs.
// -
// Default: "0"
// Minimum: "0.000000"
sm_umc_rtv_groupexclude "0"

// Time (in seconds) before first RTV can be held.
// -
// Default: "30"
// Minimum: "0.000000"
sm_umc_rtv_initialdelay "30"

// Time (in seconds) after a failed RTV before another can be held.
// -
// Default: "240"
// Minimum: "0.000000"
sm_umc_rtv_interval "240"

// Specifies how many past maps to exclude from RTVs.
// -
// Default: "3"
// Minimum: "0.000000"
sm_umc_rtv_mapexclude "3"

// Specifies whether vote menu items are displayed in a random order.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_rtv_menuscrambled "0"

// Number of players required before RTV will be enabled.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "64.000000"
sm_umc_rtv_minplayers "0"

// Specifies whether the number of nominated maps appearing in the vote for a map group should be limited by the group's "maps_invote" setting.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_rtv_nominate_strict "0"

// Percentage of players required to trigger an RTV vote.
// -
// Default: "0.65"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_rtv_percent "0.65"

// What to do with RTVs after another UMC vote has completed.
//  0 - Allow, success = instant change,
//  1 - Deny
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_rtv_postvoteaction "0"

// Specifies what action to take if the runoff vote reaches the maximum amount of runoffs and the set threshold has not been reached.
//  0 - Do Nothing,
//  1 - Change Map to Winner
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_rtv_runoff_failaction "0"

// Specifies the maximum number of maps to appear in a runoff vote.
//  1 or 0 sets no maximum.
// -
// Default: "0"
// Minimum: "0.000000"
sm_umc_rtv_runoff_max "0"

// If specified, this sound file (relative to sound folder) will be played at the beginning of a runoff vote. If not specified, it will use the normal start vote sound.
// -
// Default: ""
sm_umc_rtv_runoff_sound ""

// Specifies a maximum number of runoff votes to run for any given vote.
//  0 disables runoff votes.
// -
// Default: "0"
// Minimum: "0.000000"
sm_umc_rtv_runoffs "0"

// Sound file (relative to sound folder) to play at the start of a vote.
// -
// Default: ""
sm_umc_rtv_startsound ""

// If the winning option has less than this percentage of total votes, a vote will fail and the action specified in "sm_umc_rtv_failaction" cvar will be performed.
// -
// Default: ".50"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_rtv_threshold ".50"

// Controls RTV vote type:
//  0 - Maps,
//  1 - Groups,
//  2 - Tiered Vote (vote for a group, then vote for a map from the group).
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "2.000000"
sm_umc_rtv_type "0"
```