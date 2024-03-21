# DSY_rpf_fnc_alterAllPools

## Use

Alters all resource pools on an object by the given amount and methods.

## Parameters
- Index 0: *_obj*
    - \<OBJECT\> The object you want to alter all the pools of
- Index 1: *_amount*
    - \<NUMBER\> The amount which you want to alter each pool by
- Index 2: *_methods*
    - \<ARRAY\> The methods of alteration.
    - Array is in format: [_mathOperation,_overflowMethod]
        - Index 0: True if subtraction, false if addition (default false) \<BOOLEAN\> 
        - Index 1: True if reject an alteration over the limit, false if clamp the alteration to the limit (default false) \<BOOLEAN\>

## Return

false on error, true on successful execution

## Example

    // assuming box1 has pools: "pool", "pool1", and "pool2",
    // this code subtracts 30 from "pool", "pool1", and "pool2", and clamps it to 0 if the alteration would exceed it
    [box1,30,[true,false]] call DSY_rpf_fnc_alterAllPools;

## CBA Events

DSY_rpf_alteredAll
> called once at the end of the alterAll execution

DSY_rpf_altered
> called for every alteration

***
