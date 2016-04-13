# Purpose #

> The End of Map Vote module will attempt to spawn a map vote towards the end of the map currently being played. The functionality is similar to that of SourceMod's own mapchooser.smx plugin.

> For details on how votes can be customized, please see the [Voting Documentation](AboutVoting.md).


# List of CVars #
> The list of cvars for the End of Map Vote module is located in **cfg/sourcemod/umc-endvote.cfg**.
```
// Allows a map to appear in the vote more than once. This should be enabled if you want the same map in different categories to be distinct.
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "0.500000"
sm_umc_endvote_allowduplicates "1"

// Specifies how many slots in a vote are disabled to prevent accidental voting.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "5.000000"
sm_umc_endvote_blockslots "0"

// File to use for Ultimate Mapchooser's map rotation.
// -
// Default: "umc_mapcycle.txt"
sm_umc_endvote_cyclefile "umc_mapcycle.txt"

// Specifies how long a vote should be available for.
// -
// Default: "20"
// Minimum: "10.000000"
sm_umc_endvote_duration "20"

// Specifies if Ultimate Mapchooser should run an end of map vote.
// -
// Default: "1"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_endvote_enabled "1"

// Sound file (relative to sound folder) to play at the completion of an end-of-map vote.
// -
// Default: ""
sm_umc_endvote_endsound ""

// Specifies how many more frags each extension adds to the frag limit.
// -
// Default: "10"
// Minimum: "1.000000"
sm_umc_endvote_extend_fragstep "10"

// Specifies how many more rounds each extension adds to the round limit.
// -
// Default: "5"
// Minimum: "1.000000"
sm_umc_endvote_extend_roundstep "5"

// Specifies how many more minutes each extension adds to the time limit.
// -
// Default: "15"
// Minimum: "1.000000"
sm_umc_endvote_extend_timestep "15"

// Number of extensions allowed each map.
//  0 disables the Extend Map option.
// -
// Default: "0"
// Minimum: "0.000000"
sm_umc_endvote_extends "0"

// Specifies what action to take if the vote doesn't reach the set theshold.
//  0 - Do Nothing,
//  1 - Perform Runoff Vote
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_endvote_failaction "0"

// Specifies how many past map groups to exclude from the end of map vote.
// -
// Default: "0"
// Minimum: "0.000000"
sm_umc_endvote_groupexclude "0"

// Specifies how many past maps to exclude from the end of map vote.
// -
// Default: "3"
// Minimum: "0.000000"
sm_umc_endvote_mapexclude "3"

// Specifies whether vote menu items are displayed in a random order.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_endvote_menuscrambled "0"

// Specifies whether the number of nominated maps appearing in the vote for a map group should be limited by the group's "maps_invote" setting.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_endvote_nominate_strict "0"

// Determines whether End of Map Votes should be delayed until the end of the round in which they were triggered.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_endvote_onroundend "0"

// Specifies what action to take if the runoff vote reaches the maximum amount of runoffs and the set threshold has not been reached.
//  0 - Do Nothing,
//  1 - Change Map to Winner
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_endvote_runoff_failaction "0"

// Specifies the maximum number of maps to appear in a runoff vote.
//  1 or 0 sets no maximum.
// -
// Default: "0"
// Minimum: "0.000000"
sm_umc_endvote_runoff_max "0"

// If specified, this sound file (relative to sound folder) will be played at the beginning of a runoff vote. If not specified, it will use the normal vote start sound.
// -
// Default: ""
sm_umc_endvote_runoff_sound ""

// Specifies a maximum number of runoff votes to run for any given vote.
//  0 = unlimited.
// -
// Default: "0"
// Minimum: "0.000000"
sm_umc_endvote_runoffs "0"

// Specifies when to start the vote based on frags remaining.
// -
// Default: "10"
// Minimum: "1.000000"
sm_umc_endvote_startfrags "10"

// Specifies when to start the vote based on rounds remaining. Use 0 on TF2 to start vote during bonus round time
// -
// Default: "2"
// Minimum: "0.000000"
sm_umc_endvote_startrounds "2"

// Sound file (relative to sound folder) to play at the start of an end-of-map vote.
// -
// Default: ""
sm_umc_endvote_startsound ""

// Specifies when to start the vote based on time remaining in minutes.
// -
// Default: "6"
// Minimum: "1.000000"
sm_umc_endvote_starttime "6"

// If a winning vote has less than this percentage of total votes, a runoff vote will be held.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_endvote_threshold "0"

// Controls end of map vote type:
//  0 - Maps,
//  1 - Groups,
//  2 - Tiered Vote (vote for a group, then vote for a map from the group).
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "2.000000"
sm_umc_endvote_type "0"
```