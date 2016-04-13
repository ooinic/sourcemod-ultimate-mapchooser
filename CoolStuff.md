# About This Page #

> When I first wrote Ultimate Mapchooser (originally called Improved Map Randomizer) I had a very specific vision of a plugin that allowed server owners to make sure certain maps would appear in votes. One year later and the plugin has become a massive project filled with many different features, which when combined can result in endless possible settings, more than I can even imagine.

> This wiki page contains some examples of things which you may not have realized you can do with UMC at first glance. They stand as a testament to the flexibility and customizability of the plugin.


# Insert a Map Group into a Map Vote #
> You can add what looks like a Map Group to a vote that only contains maps. This requires the type of vote to be a **Map** vote (as opposed to a **Group** or **Tiered** vote), and it requires the use of the **display-template** Map Group option.

> ## How To ##
> Take this UMC-Mapcycle as an example:
```
"umc_mapcycle"
{
    "Some Maps"
    {
        "maps_invote"  "3"

        "cp_dustbowl" {}
        "cp_granary" {}
        "cp_gravelpit" {}
        "cp_well" {}
        "cp_fastlane" {}
        "cp_badlands" {}
        "pl_goldrush" {}
        "pl_badwater" {}
    }

    "Random Choice"
    {
        "maps_invote"  "1"
        "display-template"  "Or perhaps something else..."

        "ctf_2fort" {}
        "ctf_well" {}
        "koth_viaduct" {}
        "plr_pipeline" {}
        "pl_hoodoo_final" {}
    }
}
```
> This will create a vote with 4 choices: the first three (assuming the menu isn't scrambled) will be taken from the "Some Maps" Map Group, and the third map will be taken from the "Random Choice" Map Group. However, since the **display-template** option is set to "Or perhaps something else...", then whatever map is selected from this group to be in the vote, it will appear in the vote as "Or perhaps something else..."

# Multi-Mod Vote #
> By using the **command** option for Map Groups, combined with Tiered/Group Votes (or **display-template** with Map votes), you can make a vote that allows players to select which Mod they would like to play next.

> ## How To ##
> First, you should place something in your server.cfg that disables all mods, that way you don't have to worry about any mods being active accidentally (and you don't need to worry about it affecting UMC; all UMC commands are performed after server.cfg is executed, so they will override whatever is in server.cfg). Next, you should add whatever commands/convars are necessary to enable a mod to it's own .cfg. Finally, you define a UMC-Mapcycle like this:
```
"umc_mapcycle"
{
    "Zombie Fortress"
    {
        "command"  "exec zombie-fortress.cfg"
        
        "zf_dustbowl" {}
        //...other ZF maps
    }

    "VS Saxton Hale!"
    {
        "command"  "exec vs-saxton-hale.cfg"

        "vsh_Hakurei_Shrine" {}
        //...other VSH maps
    }

    //...other mods go in different groups
}
```
> When a vote appears, there will be an option for each mod (assuming you're using **Group** or **Tiered** Voting), and when the vote is completed, with command specified by the winning group will be executed at the start of the next map. In this case, that command will execute the appropriate .cfg, thus enabling the Mod.