#include "defines.hpp"
if (isDedicated) exitWith {
	RPT_DTAIL("Error: Local functions will not execute on dedicated server.",__FILE__,__LINE__);
	[E_LOCSERV,[__FILE__],1] call FUNC(raiseEvent);
	false
};
params [
	["_obj",objNull,[objNull]]
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
private _array = [_obj,"r"] call FUNC(accessHash);
if (_array isEqualType false) exitWith {
	_msg = format ["Error: Object (%1) has no resource pools on it. Removal aborted.",_obj];
	RPT_DTAIL(_msg,__FILE__,__LINE__);
	false
};
{// remove all vars related to being a pool
	_obj setVariable [SUJOIN(_x,"limit"),    nil];
	_obj setVariable [SUJOIN(_x,"frozen"),   nil];
	_obj setVariable [SUJOIN(_x,"poolInit"), nil];
	_obj setVariable [SUJOIN(_x,"RD_Array"), nil];
	_obj setVariable [_x, nil];
} forEach _array;
// event
[E_REMOVEDA,[_obj],0] call FUNC(raiseEvent);
// remove from and update hashmap
[_obj,"d"] call FUNC(accessHash);
true