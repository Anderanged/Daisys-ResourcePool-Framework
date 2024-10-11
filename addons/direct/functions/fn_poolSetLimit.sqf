#include "defines.hpp"
/*
Function: RPF_fnc_poolSetLimit

Description:

	Sets the pool's internal limit variable to a new given value.

	All limits will clamp to 2^16 (65,536). If you need more you should reconsider your situation.

	Additionally, if the new limit is lower than the current value stored in the pool, it can be freely subtracted from. *However: If you use both the add & clamp methods, it will clamp to the new limit.*

Parameters:

	_obj -		object that the pool whose limit you want to change is on [Object]
	_varName -	name of the pool whose limit you want to change [String]
	_newLimit - new maximum amount of resource allowed in this pool [Number]

Returns: 

false on error, true on success

Examples:
    --- Code
	// whatever the limit was before, it sets it to 5000
    [box1,"pool",5000] call RPF_fnc_poolSetLimit;
    ---
	--- Code
	// clamps to 65536
    [box1,"pool",70000] call RPF_fnc_poolSetLimit;
	---

CBA Events:
	- RPF_setLimit
	> raised on successful execution of poolSetLimit

Author: Daisy
*/
private _obj 		= _this param [0,objNull,[objNull]];
private _msg = "";
if (isNull _obj) exitWith {
	_msg = format ["Error: Invalid object (%1) specified. Objects may not be of type null.",_obj];
	RPT_DTAIL(_msg,__FILE__,__LINE__);
	false
};
private _varName = _this param [1,"",[""]];
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	_msg = format ["Error: Pool (%1) not initialized on object (%2). Alteration failed.",_varName,_obj];
	RPT_DTAIL(_msg,__FILE__,__LINE__);
	false
};
private _cVal 		= _obj getVariable _varName;
private _limit 		= _obj getVariable SUJOIN(_varName,"limit");
private _newLimit 	= _this param [2,_limit,[0]];

_newLimit = floor (abs _newLimit);

if (_newLimit > RPFLIM_MAX) then {_newLimit = RPFLIM_MAX;};

_obj setVariable [SUJOIN(_varName,"limit"),_newLimit,true];

[QPVAR(setLimit),[_obj,_varName,_newLimit,_limit],1] call FUNC(raiseEvent);

true