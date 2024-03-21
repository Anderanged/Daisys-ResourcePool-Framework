# DSY_rpf_fnc_poolSetLimit

## Use

Allows manual editing of an initialized pool's limit.
> Will clamp to 2^16 (65,536). If you need more you should reconsider your situation.

> If the new limit is lower than the current value stored in the pool, it can be freely subtracted from. **However: If you use both the add & clamp methods, it will clamp to the new limit.**

## Parameters
- Index 0: *_obj*
    - \<OBJECT\> The object that the pool whose limit you want to change is on
- Index 1: *_varName*
    - \<STRING\> The name of the pool whose limit you want to change
- Index 2: *_newLimit*
    - \<NUMBER\> The new maximum amount of resource allowed in this pool

## Return

false on error, true on success

## Example

    // whatever the limit was before, it sets it to 5000
    [box1,"pool",5000] call DSY_rpf_fnc_poolSetLimit;

    // clamps to 65536
    [box1,"pool",70000] call DSY_rpf_fnc_poolSetLimit;

## Events

DSY_rpf_setLimit
> raised upon successful execution of poolSetLimit

***