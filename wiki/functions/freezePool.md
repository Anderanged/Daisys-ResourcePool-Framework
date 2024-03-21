# DSY_rpf_fnc_freezePool

## Use

Halts all alterations (addition/subtraction) on a given pool. 
> NOTE: This does not interrupt delay/renew timers, it only halts the alteration call they make.

## Parameters
- Index 0: *_obj*
    - \<OBJECT\> The object that the pool you want to freeze is on
- Index 1: *_varName*
    - \<STRING\> The name of the pool you want to freeze

## Return

true if the pool has been frozen, false if it has been unfrozen

## Example

    // if not already frozen, returns true
    [box1,"pool"] call DSY_rpf_fnc_freezePool;
    // calling again after returns false
    [box1,"pool"] call DSY_rpf_fnc_freezePool;

## Events

DSY_rpf_frozen
> raised if the pool was frozen
DSY_rpf_unfrozen
> raised if the pool was unfrozen

***