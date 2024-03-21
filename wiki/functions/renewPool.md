# DSY_rpf_fnc_renewPool
> **NOTE: For a more convenient alternative, see [poolSetRenew]().**
***
## Use

Adds to a pool given the pool's internally set rate. Loops until the pool's internally set renew status changes.


## Parameters
- Index 0: *_obj*
    - \<OBJECT\> The object that the pool you want to begin renewing is on
- Index 1: *_varName*
    - \<STRING\> The name of the pool you want to renew

## Return

none

## Example

    // will renew by internally given rate
    [box1, "pool"] call DSY_rpf_fnc_decayPool;

DSY_rpf_altered
> raised when pool is altered

DSY_rpf_renewed
> raised upon successful execution of renewPool
***