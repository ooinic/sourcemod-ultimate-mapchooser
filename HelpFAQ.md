## Why are my nominated maps not appearing in votes? ##

> The most likely culprit is that the map you're nominating has a different group name than a group that's actually in the vote. This commonly happens when you have separate groups for voting/nominating, and it happens more often when there are separate UMC-Mapcycles for voting/nominating.

> To fix this, you can specify which group a nomination should belong to by using the **nominate\_group** option, outlined in the documentation for the [Core Module](ModuleCore.md). This way you can set which group nominated maps belong to without altering the structure of your nomination groups/mapcycle.



## Why is only one map/only nominated maps appearing in the vote? ##

> You probably forgot to set **maps\_invote** in your UMC Mapcycle definition. This option specifies how many maps from a Map Group to be included in a vote. If it is not set, it defaults to 1.



## How do you use Ultimate Mapchooser in conjunction with GunGame? ##

> There are several versions of GunGame around. The one recommended for use with UMC is the SourceMod variant, which you can download [here](http://forums.alliedmods.net/showthread.php?t=93977). To use UMC with SM GunGame, first make sure the [Vote Command module](ModuleVoteCommand.md) is enabled and configured. Then, add the **sm\_umc\_mapvote** command (with appropriate arguments for how you want the vote to run) to the _gungame.mapvote.cfg_ GunGame configuration file, located in the _cfg/gungame_ directory.



## In TF2, why doesn't UMC change the map for me when the time remaining reaches zero? ##

> Valve has this functionality built into the Source Engine. If you set the console variable **mp\_match\_end\_at\_timelimit** to 1, then all maps will end the second the time remaining reaches zero. This console variable defaults to 0.