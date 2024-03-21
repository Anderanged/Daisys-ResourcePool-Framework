# DSY_rpf_fnc_removePool

## Use

Removes the pool with the given name from the object.

## Parameters
- Index 0: *_obj*
    - \<OBJECT\> The object that the pool you want to alter is on
- Index 1: *_varName*
    - \<STRING\> The name of the pool you want to alter

## Return

false on failure, true on success

## Example

    // removes "pool" resource pool from box1
    [box1,"pool"] call DSY_rpf_fnc_removePool;

## Events

DSY_rpf_removed
> raised upon removal of a pool

***