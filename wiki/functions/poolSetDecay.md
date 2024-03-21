# DSY_rpf_fnc_poolSetDecay

## Use

Sets the pool's internal renew/decay status and calls [decayPool]() with a given rate.

## Parameters
- Index 0: *_obj*
    - \<OBJECT\> The object that the pool you want to decay is on
- Index 1: *_varName*
    - \<STRING\> The name of the pool you want to decay
- Index 3: *_rate*
    - \<ARRAY\> The rate you want to decay by. Leave blank to use the internally set rate array.
    - Array in format: [_amount,_time]
        - Index 0: \<NUMBER\> the amount you want to subtract from the pool each time
        - Index 1: \<NUMBER\> the amount of time between subtractions

## Return

false on error, true on success

## Example

    // subtracts 50 every 2 seconds
    [box1,"pool",[50,2]] call DSY_rpf_fnc_poolSetDecay;

    // uses the internal array
    [box1,"pool",[]] call DSY_rpf_fnc_poolSetDecay;

## Events

DSY_rpf_setDecay
> raised on successful execution of poolSetDecay

***