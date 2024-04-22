#include "defines.hpp"
/*
Function: RPF_fnc_removePool

Description:

	Removes the pool with the given name from the object.

Parameters:

	_obj -		object that you want to remove the pool from [Object]
	_varName - The name of the pool you want to remove [String]

Returns: 

false on failure, true on success

Examples:
    --- Code
	// removes "pool" resource pool from box1
    [box1,"pool"] call RPF_fnc_removePool;
    ---

CBA Events:
	- RPF_removed
	> raised upon removal of a pool

Author: Daisy
*/
params [
	["_obj",objNull,[objNull]],
	["_varName","",[""]]
];
if (_obj == objNull) exitWith {
	RPT_DTAIL(ERROR,SJOIN("Invalid object specified: ",str _obj,""),__FILE__,__LINE__);
	false
};
// is pool init'd
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	RPT_DTAIL(ERROR,SJOIN4("Pool ",_varName," not initialized on ",str _obj,""),__FILE__,__LINE__);
	false
};
// get hash & check
private _array 	= [_obj,"r"] call FUNC(accessHash);
if (_array isEqualType false) exitWith {
	RPT_DTAIL(ERROR,SJOIN3("Object ",str _obj," has no pools initialized.",""),__FILE__,__LINE__);
	false
};
// find variable pool
private _index 	= _array find _varName;
if (_index == -1) exitWith {
	RPT_DTAIL(ERROR,SJOIN4("Hashmap does not have variable ",_varName," assigned to ",str _obj,""),__FILE__,__LINE__);
	false
};
// remove vars
_obj setVariable [SUJOIN(_varName,"limit"),    nil,true];
_obj setVariable [SUJOIN(_varName,"frozen"),   nil,true];
_obj setVariable [SUJOIN(_varName,"poolInit"), nil,true];
_obj setVariable [SUJOIN(_varName,"RD_Array"), nil,true];
_obj setVariable [_varName, nil,true];
// broadcast event
[E_REMOVED,[_obj,_varName],1] call FUNC(raiseEvent);
// update hashmap with new array
_array deleteAt _index;
[_obj,"w",_array] call FUNC(accessHash);
RPT_BASIC(INFO,SJOIN5("Object",str _obj,"has had resource pool",_varName,"manually removed."," "));
true