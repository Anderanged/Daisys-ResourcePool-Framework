alterAllPools
alterPool
createPool
decayPool
freezePool
raiseEvent
removeAllPools
removePool
renewPool
poolSetLimit
poolSetDecay
poolSetRenew
poolSetRDArray
poolStopRD


# DSY_rpf_fnc_createPool

## Use

Used to initialize 

## Parameters
- Index 0: *_obj*
    - \<OBJECT\> Desc

## Return



## Example



## Events


***

# DSY_rpf_fnc_alterPool

## Use



## Parameters
- Index 0: *_obj*
    - \<OBJECT\> Desc

## Return



## Example



## Events


***

# DSY_rpf_fnc_alterAllPools

## Use



## Parameters
- Index 0: *_obj*
    - \<OBJECT\> Desc

## Return



## Example



## Events


***
# DSY_rpf_fnc_freezePool

## Use

Toggles the halting of all alterations to an initialized resource pool with name _varName on _obj. 
> **Freezing only stops DSY_rpf_fnc_alterPool calls.** It will not stop edit, loop, remove, or wipe calls.

## Parameters
 - Index 0: *_obj* 
    - object that the pool you want to freeze/unfreeze is on <OBJECT>
 - Index 1: *_varName*  
    - variable name of pool you want to freeze/unfreeze <STRING>

## Return

True if the pool was frozen, false if it was unfrozen

## Example
    // freezes
    [box1,"DSY_rpf_pool",20,[true,false]] call DSY_rpf_fnc_alterPool;

    // adds 45 to "DSY_rpf_pool" on bag12 and rejects it if it exceeds the limits
    [bag12,"DSY_rpf_pool",45,[false,true]] call DSY_rpf_fnc_alterPool;

## Events

- DSY_rpf_onIce
- DSY_rpf_frozen
- DSY_rpf_unfrozen

***
# DSY_rpf_fnc_decayPool

## Use



## Parameters
- Index 0: *_obj*
    - \<OBJECT\> Desc

## Return



## Example



## Events


***

# DSY_rpf_fnc_renewPool

## Use



## Parameters
- Index 0: *_obj*
    - \<OBJECT\> Desc

## Return



## Example



## Events


***

# DSY_rpf_fnc_removePool

## Use



## Parameters
- Index 0: *_obj*
    - \<OBJECT\> Desc

## Return



## Example



## Events


***

# DSY_rpf_fnc_removeAllPools

## Use



## Parameters
- Index 0: *_obj*
    - \<OBJECT\> Desc

## Return



## Example



## Events


***


# DSY_rpf_fnc_poolSetLimit

## Use



## Parameters
- Index 0: *_obj*
    - \<OBJECT\> Desc

## Return



## Example



## Events


***
# DSY_rpf_fnc_poolSetRDArray

## Use



## Parameters
- Index 0: *_obj*
    - \<OBJECT\> Desc

## Return



## Example



## Events


***
# DSY_rpf_fnc_poolSetDecay

## Use



## Parameters
- Index 0: *_obj*
    - \<OBJECT\> Desc

## Return



## Example



## Events


***

# DSY_rpf_fnc_poolSetRenew

## Use



## Parameters
- Index 0: *_obj*
    - \<OBJECT\> Desc

## Return



## Example



## Events


***
# DSY_rpf_fnc_

## Use



## Parameters
- Index 0: *_obj*
    - \<OBJECT\> Desc

## Return



## Example



## Events


***