# DSY_rpf_fnc_poolSetRate

## Use

Allows for manual changing of the internally stored rate values without calling any functions.

Can be used for altering the rate of renew/decay while the pool is renewing/decaying.

## Parameters
- Index 0: *_obj*
    - \<OBJECT\> The object that you want to create a pool on
- Index 1: *_varName*
    - \<STRING\> The name of the pool you want to create
- Index 2: *_rate*
    - \<ARRAY\> The rate used in renew/decay functions
    - Array is in format: [_amount,_time]
        - Index 0: \<NUMBER\> The amount by which you want to alter the pool
        - Index 1: \<NUMBER\> The delay between alterations in seconds

## Return

false on failure, true on success

## Example

    // sets rate to 50 resources every 2 seconds.
    [box1,"pool",[50,2]] call DSY_rpf_fnc_poolSetRate;

## Events

DSY_rpf_setRate
> raised upon successful execution of poolSetRate

***