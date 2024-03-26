#include "defines.hpp"
/*
Function: RPF_fnc_poolSetDecay

Description:

	Sets the pool's internal renew/decay status and calls <decayPool: > with a given rate.

Parameters:

	_obj -		object that the pool you want to begin decaying is on [Object]
	_varName -	name of the pool you want to decay [String]
	_rate -		rate of decay [Array] Array may be left empty to use internally set rate
		- Array is in format: [_amount,_time]
			- Index 0: amount of resource to subtract each time [Number]
			- Index 1: interval (seconds) between subtractions [Number]

Returns: 

false on error, true on success

Examples:
    --- Code
	// subtracts 50 every 2 seconds
    [box1,"pool",[50,2]] call RPF_fnc_poolSetDecay;
    ---
	--- Code
	// uses the internal array
    [box1,"pool",[]] call RPF_fnc_poolSetDecay;
	---

CBA Events:
	- RPF_setDecay
	> raised on successful execution of poolSetDecay

Author: Daisy
*/
private _obj 		= _this param [0,objNull,[objNull]];
if (_obj == objNull) exitWith {
	RPT_DTAIL(ERROR,SJOIN("Invalid object specified: ",str _obj,""),__FILE__,__LINE__);
	false
};
private _varName 	= _this param [1,QPVAR(pool),[""]];
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	RPT_DTAIL(ERROR,SJOIN4("Pool ",_varName," not initialized on ",str _obj,""),__FILE__,__LINE__);
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

_obj setVariable [SUJOIN(_varName,"RD_Array"),[2,_newRate],true];

[QPVAR(setDecay),[_obj,_varName,_newRate],1] call FUNC(raiseEvent);

[_obj,_varName] call FUNC(decayPool);

true