# DSY_rpf_fnc_poolStopRD

## Use

Halts any currently looping renew/decay functions. Leaves rate unaffected.

## Parameters
- Index 0: *_obj*
    - \<OBJECT\> The object that the pool you want to stop R/D looping on is on
- Index 1: *_varName*
    - \<STRING\> The name of the pool you want to stop R/D looping for

## Return

false on failure, true on success

## Example

    // stops renew/decay loops, if any.
    // otherwise will just set the renew/decay identifier value (see below) to 0
    [box1,"pool"] call DSY_rpf_fnc_poolStopRD;

[R/D identifier value]()

## Events

DSY_rpf_poolStopRD
> raised upon successful execution of poolStopRD

***