#include "defines.hpp"
/*
Function: RPF_fnc_removeAllPools

Description:

	Removes all pools from the given object.

Parameters:

	_obj -		object that you want to remove all pools from [Object]
	
Returns: 

false on failure, true on success

Examples:
    --- Code
	// removes all pools from object box1
    box1 call RPF_fnc_removeAllPools;
    ---

CBA Events:
	- RPF_removedAll
	> raised upon removal of all pools from an object

Author: Daisy
*/
params [
	["_obj",objNull,[objNull]]
];
private _msg = "";
// check obj
if (isNull _obj) exitWith {
	_msg = format ["Error: Invalid object (%1) specified. Objects may not be of type null.",_obj];
	RPT_DTAIL(_msg,__FILE__,__LINE__);
	false
};
private _array = [_obj,"r"] call FUNC(accessHash);
if (_array isEqualType false) exitWith {
	_msg = format ["Error: Object (%1) has no resource pools on it. Removal aborted.",_obj];
	RPT_DTAIL(_msg,__FILE__,__LINE__);
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
// remove from and update hashmap
[_obj,"d"] call FUNC(accessHash);
true