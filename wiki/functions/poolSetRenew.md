# DSY_rpf_fnc_poolSetRenew

## Use

Sets the pool's internal renew/decay status
to renew and calls [renewPool]() with an optional given rate.

## Parameters
- Index 0: *_obj*
    - \<OBJECT\> The object that the pool you want to renew is on
- Index 1: *_varName*
    - \<STRING\> The name of the pool you want to renew
- Index 3: *_rate*
    - \<ARRAY\> The rate you want to renew by. Leave blank to use the internally set rate array.
    - Array in format: [_amount,_time]
        - Index 0: \<NUMBER\> the amount you want to add to the pool each time
        - Index 1: \<NUMBER\> the amount of time between additions

## Return

false on error, true on success

## Example

    // adds 50 every 2 seconds
    [box1,"pool",[50,2]] call DSY_rpf_fnc_poolSetRenew;

    // uses the internal array
    [box1,"pool",[]] call DSY_rpf_fnc_poolSetRenew;

## Events

DSY_rpf_setRenew
> raised on successful execution of poolSetRenew

***