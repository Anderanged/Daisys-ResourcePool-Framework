# DSY_rpf_fnc_createPool

## Use

Creates a new resource pool with the given parameters.

## Parameters
- Index 0: *_obj*
    - \<OBJECT\> The object that you want to create a pool on
- Index 1: *_varName*
    - \<STRING\> The name of the pool you want to create
- Index 2: *_limit*
    - \<NUMBER\> The maximum amount of resource allowed in this pool
- Index 3: *_rd*
    - \<NUMBER\> The renew/decay state of the pool:
        - 0 : neither renew nor decay
        - 1 : renew
        - 2 : decay
- Index 4: *_rate*
    - \<ARRAY\> The rate used in renew/decay functions
    - Array is in format: [_amount,_time]
        - Index 0: \<NUMBER\> The amount by which you want to alter the pool
        - Index 1: \<NUMBER\> The delay between alterations in seconds

## Return

false on failure, true on success

## Example

    // creates resource pool "pool" on object box1 with limit of 500 that will decay  (subtract) 20 resources every 90 seconds
    [box1, "pool", 500, 2, [20,90]] call DSY_rpf_fnc_createPool;

## Events

DSY_rpf_created
> called at successful creation

DSY_rpf_destroyed
> called at destruction or killing of resource pool object

***