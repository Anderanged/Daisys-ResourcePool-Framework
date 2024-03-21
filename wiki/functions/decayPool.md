# DSY_rpf_fnc_decayPool
> **NOTE: For a more convenient alternative, see [poolSetDecay]().**
***
## Use

Subtracts from a pool given the pool's internally set rate. Loops until the pool's internally set decay status changes.


## Parameters
- Index 0: *_obj*
    - \<OBJECT\> The object that the pool you want to begin decaying is on
- Index 1: *_varName*
    - \<STRING\> The name of the pool you want to decay

## Return

none

## Example

    // will decay by internally given rate
    [box1, "pool"] call DSY_rpf_fnc_decayPool;

DSY_rpf_altered
> raised when pool is altered

DSY_rpf_decayed
> raised upon successful execution of delayPool
***