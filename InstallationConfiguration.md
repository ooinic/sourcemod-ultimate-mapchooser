# Installation #
> Ultimate Mapchooser's Core and Modules are installed like any other SourceMod plugin; just move the compiled .smx file into the **addons/sourcemod/plugins** folder. SourceMod will then load them on map change, or they can be loaded manually via the "sm plugins load _name_" command in the server console (where _name_ is the file name of the compiled plugin, without the .smx extension).

> Ultimate Mapchooser also has several translation files, which should be placed in the **addons/sourcemod/translations** folder following the directory structure outlined [here](http://wiki.alliedmods.net/Translations_(SourceMod_Scripting)#Distributing_Language_Files) in the SourceMod documentation.


# Configuration #
> All of Ultimate Mapchooser's behavioral settings are controlled by cvars, defined in configuration files located in **cfg/sourcemod**. If you are not using a pre-packaged release of Ultimate Mapchooser, these configuration files will be auto-generated the first time each module is run. For detailed instructions on the options in these configuration files, see the documentation for each specific Ultimate Mapchooser module in the wiki.

## Creating a UMC-Mapcycle ##
> All modules released with Ultimate Mapchooser that can manipulate the mapcycle in some way require a UMC-Mapcycle definition. The format for this file is defined as follows:
```
"umc_mapcycle"
{
    "GROUP1"
    {
        "group_option1"  "x"
        "group_option2"  "x"
        ...
        "group_optionN"  "x"

        "MAP1"
        {
            "map_option1"  "x"
            "map_option2"  "x"
            ...
            "map_optionN"  "x"
        }
        
        "MAP2"
        {
            ...
        }
        
        ...

        "MAPN"
        {
            ...
        }
    }

    "GROUP2"
    {
        ...
    }

    ...

    "GROUPN"
    {
        ...
    }
}
```
> In summary, a UMC-Mapcycle contains a list of groups, each with a list of maps inside. There has to be at least one group, and each group has to have at least one map in it.

> A **group** is defined as a subset of the maps available for selection; this means that for each group you have in your UMC-Mapcycle, there will be a corresponding entry (or multiple entries) in the vote. It also means that if a map is selected randomly from a UMC-Mapcycle, and there are multiple groups, first a random group is selected, and then a random map is selected from the group.

> A **map** is defined as a combination of a map name and the group it belongs to. This means that if you have the same map in multiple groups, they are treated as distinct by default. All maps must belong to a group.

> Each group and map can also have several options available to it for configuration. These options are defined by whatever modules are installed. To see what options are available from a module, please see the documentation of a specific module.

> ### So what does this mean to me? ###

> If you want to make sure maps from different "lists" appear in the vote, then you should make more than one group, with each group corresponding to a different list. If you just want to select randomly from one big list of maps, then you should stick with only one group. It is recommended that you stick to this rule of thumb with regards to multiple groups vs. one group, otherwise you may start running into trouble with your UMC-Mapcycle.

> Take this (real) example:  someone designed the following UMC-Mapcycle:
```
"umc_mapcycle"
{
    "GroupA"
    {
        "maps_invote"    "3"
        "default_min_players"  "0"
        "default_max_players"  "16"

        "de_dust" { }
        "de_dust2" { }
        "de_aztec" { }
        "de_nuke" { }
        "cs_italy" { }
        "de_dust_csgo" { }
    }

    "GroupB"
    {
        "maps_invote"    "3"
        "default_min_players"  "17"
        "default_max_players"  "24"

        "de_dust" { }
        "de_dust2" { }
        "de_aztec" { }
        "de_nuke" { }
        "cs_italy" { }
        "de_dust_csgo" { }
        "de_inferno" { }
        "de_cbble" { }
        "de_dust2_revolution" { }
        "de_piranesi" { }
        "de_chateau" { }
        "de_prodigy" { }
        "cs_office" { }
        "cs_assault" { }
        "cs_compound" { }
        "de_port" { }
    }
}
```
> What this UMC-Mapcycle is set up to do is use the provided [Play Limits module](ModulePlayerLimits.md) to specify what maps are available when different amounts of players are on the server. When there are 16 or less players on the server, the only available maps are in the "GroupA" group. When there are 17 or more players, the only available maps are in the "GroupB" group.
> This may look perfectly fine, and assuming it will never be changed, it will also work fine. However, let's say that the creator of this UMC-Mapcycle wanted to change the minimum required players for "cs\_office" in "GroupB" to "12". This means that when there between 12 and 16 players on the server, two groups will be available for selection: "GroupA" with all of its maps, and "GroupB" with "cs\_office". If a vote were to appear (with UMC's default voting settings), it would loke something like this:
```
Vote for the next map!
1. <Map from GroupA>
2. <Map from GroupA>
3. <Map from GroupA>
4. cs_office
```
> No matter what with this new mapcycle, when there are between 12 and 16 players on the server, "cs\_office" will be added to the vote. This is because, as explained earlier, UMC's Map Groups are there to divide the group into different pools of maps.
> The proper way to write the original mapcycle would be like this:
```
"umc_mapcycle"
{
    "All Maps"
    {
        "maps_invote"    "3"

        "de_dust" { }
        "de_dust2" { }
        "de_aztec" { }
        "de_nuke" { }
        "cs_italy" { }
        "de_dust_csgo" { }
        "de_inferno" 
        {
            "min_players"  "17"
        }
        "de_cbble" 
        {
            "min_players"  "17"
        }
        "de_dust2_revolution" 
        {
            "min_players"  "17"
        }
        "de_piranesi" 
        {
            "min_players"  "17"
        }
        "de_chateau" 
        {
            "min_players"  "17"
        }
        "de_prodigy" 
        {
            "min_players"  "17"
        }
        "cs_office" 
        {
            "min_players"  "17"
        }
        "cs_assault" 
        {
            "min_players"  "17"
        }
        
        "cs_compound" 
        {
            "min_players"  "17"
        }
        "de_port" 
        {
            "min_players"  "17"
        }
    }
}
```
> With this mapcycle, the "min\_players" for "cs\_office" could then be changed to whatever is wanted, and it would not run into the same problem.