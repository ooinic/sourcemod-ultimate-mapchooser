# Purpose #
> The Post-Played Exclusion module allows users to specify a an amount of time after a map is played that it is to be [excluded from selection](AboutExclusion.md) in Ultimate Mapchooser. Specifically, it defines one new Map Group option called **"default\_allow\_every"** and one new Map option called **"allow\_every"**.
```
"umc_mapcycle"
{
    "A Group"
    {
        "default_allow_every"  "X"

        "A Map"
        {
            "allow_every"  "X"
        }
    }
}
```
> Where **X** is an amount of time in minutes that the map is to be excluded after being played. If **allow\_every** is not specified for a map, the value of **default\_allow\_every** from the group the map belongs to is used. If **default\_allow\_every** is not specified for a Map group, it is assumed to be 0 (no delay).


# Example #
> Coming Soon.


# List of Cvars #
> The list of cvars for the Post-Played Exclusion module is located in cfg/sourcemod/umc-postexclude.cfg.
```
// Determines if maps being displayed are exempt from being excluded due to Post-Played Exclusion.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_postex_ignoredisplay "0"

// Determines if nominations are exempt from being excluded due to Post-Played Exclusion.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_postex_ignorenominations "0"
```