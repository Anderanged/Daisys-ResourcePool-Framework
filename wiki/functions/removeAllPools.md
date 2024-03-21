# DSY_rpf_fnc_removeAllPools

## Use

Removes all pools from the given object.

## Parameters
- Index 0: *_obj*
    - \<OBJECT\> The object that you want to remove all pools from

## Return

false on failure, true on success

## Example

    // removes all pools from object box1
    box1 call DSY_rpf_fnc_removeAllPools;

## Events

DSY_rpf_removedAll
> raised upon removal of all pools from an object

***