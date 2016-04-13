# Purpose #
> The Time Limits module extends Ultimate Mapchooser's exclusion system to allow users to specify an amount of previously-played map prefixes to be excluded. For example, if you are currently on _cp\_dustbowl_, and the _sm\_umc\_prefixexclude\_memory_ cvar is set to 1 or higher, then all maps whose name beings with "cp" will be excluded from selection.

# List of CVars #
> The list of cvars for the Map Prefix Exclusion module is located in **cfg/sourcemod/umc-prefixexclude.cfg**.
```
// Determines if maps being displayed are exempt from being excluded due to Prefix Exclusion.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_prefixexclude_display "0"

// Specifies how many previously played prefixes to exclude. 1 = Current Only
// -
// Default: "1"
// Minimum: "0.000000"
sm_umc_prefixexclude_memory "1"

// Determines if nominations are exempt from being excluded due to Prefix Exclusion.
// -
// Default: "0"
// Minimum: "0.000000"
// Maximum: "1.000000"
sm_umc_prefixexclude_nominations "0"
```