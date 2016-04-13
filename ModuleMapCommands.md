# Purpose #

> The Map Commands module allows users to define, in the UMC-Mapcycle, commands to be executed when a Map is set as the next map and when a Map begins.

> Specifically, this module defines two new group commands, **"command"** and **"pre-command"**, and two new map commands, also **"command"** and **"pre-command"**.
```
"umc_mapcycle"
{
    "A Group"
    {
        "command"  "COMMAND"
        "pre-command"  "COMMAND"
        ...

        "A Map"
        {
            "command"  "COMMAND"
            "pre-command"  "COMMAND"
            ...
        }
    }
    ...
}
```
> Where **COMMAND** is any valid string which could be entered in the server console. Whatever string is defined in the "command" option will be executed as a Server Command when the server changes to that map in that map group, and whatever string is defined in the "pre-command" option will be executed as a Server Command when UMC sets it as the next map. Note that if a command is defined for both a map and it's map group, **both commands will be executed.**

> The order of execution for server commands with this module installed is:
```
server.cfg  ->  mapname.cfg  ->  UMC Map Group Command   ->  UMC Map Command
```