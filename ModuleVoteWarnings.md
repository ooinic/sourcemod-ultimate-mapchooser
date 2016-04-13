# Purpose #

> The End of Map Vote Warnings module provides audible and visual warnings before an End of Map vote appears. This module requires the [End of Map Vote module](ModuleEndVote.md) in order to run.

# Configuration #
> Vote warnings have their own definition file format. This format is as follows:
```
"vote_warnings"
{
    "default"
    {
        "message"  "MESSAGE"
        "notification"  "NOTIFICATION_STRING"
        "sound"  "SOUND_FILENAME"
    }

    "WARNING_TIME_1"
    {
        "message"  "MESSAGE"
        "notification"  "NOTIFICATION_STRING"
        "sound"  "SOUND_FILENAME"
    }

    "WARNING_TIME_2"
    {
        "message"  "MESSAGE"
        "notification"  "NOTIFICATION_STRING"
        "sound"  "SOUND_FILENAME"
    }
    
    ...
    
    "WARNING_TIME_N"
    {
        "message"  "MESSAGE"
        "notification"  "NOTIFICATION_STRING"
        "sound"  "SOUND_FILENAME"
    }
}
```
> Where **"default"** contains the values to be used if any of them are omitted from the actual warning definitions.

> <b>WARNING_TIME_N</b> defines the time before the vote when the warning will be displayed. If this warning definition is being used to a vote triggered by a timelimit, then this number will be the number of seconds before the vote. For fraglimit, then it will be the number of frags. Same for rounds.

> <b>MESSAGE</b> defines the text that will be displayed when the warning triggers. This can be any string. If you don't want a message to display, you can use an empty string ("").

> <b>NOTIFICATION_STRING</b> is a string of characters defining where the message will be displayed. Valid characters are:
    * C - Center Message
    * H - Hint Message
    * S - Say Message
    * T - Top Message
    * G - TF2 Game Text Message (TF2 only)

> <b>SOUND_FILENAME</b> specifies a path to a sound file on the server, relative to the _sounds/_ directory, that should be played when this warning trigges. Sounds specified in warnings are automatically precached and added to the server's download tables, so no additional configuration for the sounds are required.

## Defining a sequence of warnings ##
> To make defining a sequence of warnings easier, rather than having to make a separate warning definition for each subsequent warning, you can just use the **sequence-specifier**. It works as follows:
```
"vote_warnings"
{
    "default"
    {
        ...
    }

    "X-Y"
    {
        "message"  "MESSAGE"
        "notification"  "NOTIFICATION_STRING"
        "sound"  "SOUND_FILENAME"
    }

    ...
}
```
> Where **X** defines the start of the sequence and **Y** defines the end of the sequence (inclusive).

> When using sequences, you can insert the current warning time in the sequence (so, whatever number the sequence is currently on, from X to Y) into the **MESSAGE** string and the **SOUND\_FILENAME** string by putting **"{TIME}"** (sans quotes) where you want it to be placed.

> For example:
```
"5-1"
{
    "message"  "{TIME} seconds until vote."
    "sound"  "warning{TIME}.wav"
}
```
> If it is currently 5 seconds away from the vote, it will display "5 seconds until vote." and play the sound "warning5.wav".

# Example #
> Coming soon

# List of CVars #
> The list of cvars for the End of Map Vote Warnings module is located in **cfg/sourcemod/umc-endvote-warnings.cfg**.
```
// Specifies which file frag-based vote warnings are defined in. (uses mp_fraglimit)
// -
// Default: ""
sm_umc_endvote_fragwarnings ""

// Specifies which file round-based vote warnings are defined in (uses mp_maxrounds).
// -
// Default: ""
sm_umc_endvote_roundwarnings ""

// Specifies which file time-based vote warnings are defined in. (uses mp_timelimit)
// -
// Default: "addons/sourcemod/configs/vote_warnings.txt"
sm_umc_endvote_timewarnings "addons/sourcemod/configs/vote_warnings.txt"
```