#include "defines.hpp"
if (isDedicated) exitWith {
	RPT_DTAIL("Error: Local functions will not execute on dedicated server.",__FILE__,__LINE__);
	[E_LOCSERV,[__FILE__],1] call FUNC(raiseEvent);
	false
};
private _obj = _this param [0,objNull,[objNull]];
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
params [
	"_obj",
	["_amount",0,[0]],
	["_methods",ADD_CLAMP,[[]],2]
];
// grab from hash
private _array = [_obj,"r"] call FUNC(accessHash);
// abort if nothing in hash
if (_array isEqualType false) exitWith {
	_msg = format ["Error: Object (%1) has no resource pools on it. Alteration cancelled."];
	RPT_DTAIL(_msg,__FILE__,__LINE__);
	false
};
_methods params [	
	["_methodM",false,[false,""]],				// default add
	["_methodO",false,[false,""]]				// default clamp
];
_amount = floor (abs _amount);
{// alter all pools
	[_obj,_x,_amount,_methods] call FUNC(alterPoolLocal);
} forEach _array;
// event
[E_ALTEREDA,[_obj],0] call FUNC(raiseEvent);
true