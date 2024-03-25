#include "defines.hpp"
/*
Function: DSY_rpf_fnc_alterAllPools

Description:

	Alters all resource pools on an object by the given amount and methods.

Parameters:
	_obj - The object you want to alter all the pools of [Object]
	_amount - The amount which you want to alter each pool by [Number]
	_methods - The methods of alteration [Array of methods]
		- Array is in format: [_mathOperation,_overflowMethod]
			- Index 0: True or `"s"` if subtraction, false or `"a"` if addition (default false) [Boolean or String]
			- Index 1: True or `"r"` if reject an alteration over the limit, false or `"c"` if clamp the alteration to the limit (default false) [Boolean or String]

Returns:

	false on failure, true on success

Examples:
    
	--- Code
	// assuming box1 has pools: "pool", "pool1", and "pool2",
    // this code subtracts 30 from "pool", "pool1", and "pool2", and clamps it to 0 if the alteration would exceed it
    [box1,30,[true,false]] call DSY_rpf_fnc_alterAllPools;
    ---
	--- Code 
	// the code below does the same as the above, but uses human-readable arguments
    [box1,30,["s","c"]] call DSY_rpf_fnc_alterAllPools;
	---

CBA Events:
	- DSY_rpf_alteredAll
	> called once at the end of the alterAll execution

	- DSY_rpf_altered
	> called for every alteration

Author: Daisy
*/
params [
	["_obj",objNull,[objNull]],
	["_amount",0,[0]],
	["_methods",ADD_CLAMP,[[]],2]
];
_methods params [	
	["_methodM",false,[false,""]],				// default add
	["_methodO",false,[false,""]]				// default clamp
];
// grab from hash
private _array = [_obj,"r"] call FUNC(accessHash);
// abort if nothing in hash
if (_array isEqualType false) exitWith {
	RPT_BASIC(INFO,SJOIN3("Object",str _obj,"has no resource pools on it. Aborting alteration.",""));
	false
};
{// remove all vars related to being a pool
	[_obj,_x,_amount,_methods] call FUNC(alterPool);
} forEach _array;
// event
[E_ALTEREDA,[_obj],1] call FUNC(raiseEvent);
RPT_BASIC(INFO,SJOIN5("Object",str _obj,"has had all resource pools altered by amount",str (abs floor _amount),"."," "));
true