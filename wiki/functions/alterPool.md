# DSY_rpf_fnc_alterPool

## Use

Alters pool _varName on object _obj by _amount with _methods

Adds or subtracts an amount from the given pool on the given object. Option given to choose between addition and subtraction, as well as the method of handling an overflow (see Index 3).

## Parameters
- Index 0: *_obj*
    - \<OBJECT\> The object that the pool you want to alter is on
- Index 1: *_varName*
    - \<STRING\> The name of the pool you want to alter
- Index 2: *_amount*
    - \<NUMBER\> The amount by which you want to alter the pool
- Index 3: *_methods*
    - \<ARRAY\> The methods of alteration.
    - Array is in format: [_mathOperation,_overflowMethod]
        - Index 0: \<BOOLEAN\> True if subtraction, false if addition (default false)  
        - Index 1: \<BOOLEAN\> True if reject an alteration over the limit, false if clamp the alteration to the limit (default false) 
## Return

false on failure, final altered amount on success

## Example

    // subtracts 20 from "pool" on box1 and clamps if it exceeds the limits. returns (current value of pool - 20) if not clamped, returns lower bound (always 0) if clamped
    [box1,"pool",20,[true,false]] call DSY_rpf_fnc_alterPool;

    // adds 45 to "pool" on bag12 and rejects it if it exceeds the limits. returns (current value of pool + 45) if not rejected, false if rejected
    [bag12,"pool",45,[false,true]] call DSY_rpf_fnc_alterPool;

## CBA Events

DSY_rpf_onIce
> raised on failure of alteration

DSY_rpf_altered
> raised after object alteration

DSY_rpf_clamp
> raised when value was clamped

DSY_rpf_reject
> raised when value was rejected

DSY_rpf_lBound
> raised when value exceeds lower bound (0)

DSY_rpf_uBound
> raised when value exceeds upper bound (_limit variable)

***