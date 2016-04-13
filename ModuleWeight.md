# Purpose #

> The Weight module extends Ultimate Mapchooser's weighting system to allow users to specify a weight for maps and groups in their UMC-Mapcycle definitions. Specifically, it defines one new group option "group\_weight" and one new map option "weight."
```
"umc_mapcycle"
{
    "A Group"
    {
        "group_weight"  "X"
        ...

        "A Map"
        {
            "weight"  "X"
            ...
        }
    }
    ...
}
```
> Where X is any number greater than zero.