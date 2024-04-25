#include "defines.hpp"
if (isDedicated) exitWith {
	RPT_DTAIL("Error: Local functions will not execute on dedicated server.",__FILE__,__LINE__);
	[E_LOCSERV,[__FILE__],1] call FUNC(raiseEvent);
	false
};
params [
	["_obj",objNull,[objNull]],
	["_varName","",[""]]
];
private _msg = "";
if (isNull _obj) exitWith {
	_msg = format ["Error: Invalid object (%1) specified. Objects may not be of type null.",_obj];
	RPT_DTAIL(_msg,__FILE__,__LINE__);
	false
};
if !(local _obj) exitWith {
	_msg = format ["Error: Object (%1) is not local to the current machine. Aborting local function."];
	RPT_DTAIL(_msg,__FILE__,__LINE__);
	false
};
// is pool init'd
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	_msg = format ["Error: Pool (%1) not initialized on object (%2). Alteration failed.",_varName,_obj];
	RPT_DTAIL(_msg,__FILE__,__LINE__);
	false
};
// get hash & check
private _array 	= [_obj,"r"] call FUNC(accessHash);
if (_array isEqualType false) exitWith {
	_msg = format ["Error: Object (%1) has no resource pools on it. Removal aborted.",_obj];
	RPT_DTAIL(_msg,__FILE__,__LINE__);
	false
};
// find variable pool
private _index 	= _array find _varName;
if (_index == -1) exitWith {
	_msg = format ["Error: Hashmap does not have variable (%1) assigned to object (%2).",_varName,_obj];
	RPT_DTAIL(_msg,__FILE__,__LINE__);
	false
};
// remove vars
_obj setVariable [SUJOIN(_varName,"limit"),    nil];
_obj setVariable [SUJOIN(_varName,"frozen"),   nil];
_obj setVariable [SUJOIN(_varName,"poolInit"), nil];
_obj setVariable [SUJOIN(_varName,"RD_Array"), nil];
_obj setVariable [_varName, nil];
// broadcast event
[E_REMOVED,[_obj,_varName],0] call FUNC(raiseEvent);
// update hashmap with new array
_array deleteAt _index;
[_obj,"w",_array] call FUNC(accessHash);
true