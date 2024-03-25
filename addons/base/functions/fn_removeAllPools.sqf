#include "defines.hpp"
/*
Function: DSY_rpf_fnc_removeAllPools

Description:

	Removes all pools from the given object.

Parameters:

	_obj -		object that you want to remove all pools from [Object]
	
Returns: 

false on failure, true on success

Examples:
    --- Code
	// removes all pools from object box1
    box1 call DSY_rpf_fnc_removeAllPools;
    ---

CBA Events:
	- DSY_rpf_removedAll
	> raised upon removal of all pools from an object

Author: Daisy
*/
params [
	["_obj",objNull,[objNull]]
];

private _array = [_obj,"r"] call FUNC(accessHash);
if (_array isEqualType false) exitWith {
	RPT_BASIC(INFO,SJOIN3("Object",str _obj,"has no resource pools on it. Aborting removal.",""));
	false
};
{// remove all vars related to being a pool
	_obj setVariable [SUJOIN(_x,"limit"),    nil,true];
	_obj setVariable [SUJOIN(_x,"frozen"),   nil,true];
	_obj setVariable [SUJOIN(_x,"poolInit"), nil,true];
	_obj setVariable [SUJOIN(_x,"RD_Array"), nil,true];
	_obj setVariable [_x, nil,true];
} forEach _array;
// event
[E_REMOVEDA,[_obj],1] call FUNC(raiseEvent);
RPT_BASIC(INFO,SJOIN3("Object",str _obj,"has had all resource pools removed."," "));
// remove from and update hashmap
[_obj,"d"] call FUNC(accessHash);
true