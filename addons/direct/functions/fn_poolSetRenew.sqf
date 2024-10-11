#include "defines.hpp"
/*
Function: RPF_fnc_poolSetDecay

Description:

	Sets the pool's internal renew/decay status and calls <renewPool: > with a given rate.

Parameters:

	_obj -		object that the pool you want to begin renewing is on [Object]
	_varName -	name of the pool you want to renew [String]
	_rate -		rate of renew/decay [Array] Array may be left empty to use internally set rate
		- Array is in format: [_amount,_time]
			- Index 0: amount of resource to add/subtract each time [Number]
			- Index 1: interval (seconds) between additions/subtractions [Number]

Returns: 

false on error, true on success

Examples:
    --- Code
	// adds 50 every 2 seconds
    [box1,"pool",[50,2]] call RPF_fnc_poolSetRenew;
    ---
	--- Code
	// uses the internal array
    [box1,"pool",[]] call RPF_fnc_poolSetRenew;
	---

CBA Events:
	- RPF_setRenew
	> raised on successful execution of poolSetRenew

Author: Daisy
*/
private _obj 		= _this param [0,objNull,[objNull]];
private _msg = "";
// check obj
if (isNull _obj) exitWith {
	_msg = format ["Error: Invalid object (%1) specified. Objects may not be of type null.",_obj];
	RPT_DTAIL(_msg,__FILE__,__LINE__);
	false
};

private _varName = _this param [1,"",[""]];
// was pool init'd?
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	_msg = format ["Error: Pool (%1) not initialized on object (%2). Alteration failed.",_varName,_obj];
	RPT_DTAIL(_msg,__FILE__,__LINE__);
	false
};
private _rate		= (_obj getVariable SUJOIN(_varName,"RD_Array")) # 1;
private _newRate 	= _this param [2,_rate,[[]]];
private _arrNum 	= count _newRate;
if (_arrNum > 2 || _arrNum < 2) then {_newRate = _rate;};

_rate 		params ["_amount","_time"];
_newRate 	params [["_nAmount",_amount,[0]],["_nTime",_time,[0]]];
_nAmount 	= floor (abs _nAmount);
_nTime 		= ceil (abs _nTime);
_newRate 	= [_nAmount,_nTime];

_obj setVariable [SUJOIN(_varName,"RD_Array"),[1,_newRate],true];

[QPVAR(setRenew),[_obj,_varName,_newRate],1] call FUNC(raiseEvent);

[_obj,_varName] call FUNC(renewPool);

true