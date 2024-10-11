#include "defines.hpp"
/*
Function: RPF_fnc_poolSetRate

Description:

	Changes the internally stored rate values without calling any additional functions.

	Able to be used for altering the rate of renew/decay while the pool is renewing/decaying.

Parameters:

	_obj -		object that the pool whose rate you want to change is on [Object]
	_varName -	name of the pool whose rate you want to change [String]
	_newLimit - new maximum amount of resource allowed in this pool [Number]

Returns: 

false on failure, true on success

Examples:
    --- Code
	// sets rate to 25 resources every 4 seconds.
    [box1,"pool",[25,4]] call RPF_fnc_poolSetRate;
	---

CBA Events:
	- RPF_setRate
	> raised upon successful execution of poolSetRate

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

private _rdArray	= _obj getVariable SUJOIN(_varName,"RD_Array");
private _rd 		= _rdArray # 0;
private _rate		= _rdArray # 1;
private _nRate		= _this param [2,_rate,[[]]];
if (count _nRate > 2 || count _nRate < 2) then {_nRate = _rate;};
_nRate params [["_amnt",0,[0]],["_time",0,[0]]];
_amnt 	= floor (abs _amnt);
_time 	= ceil (abs _time);
_nRate 	= [_amnt,_time];

_obj setVariable [SUJOIN(_varName,"RD_Array"),[_rd,_nRate],true];

[QPVAR(setRate),[_obj,_varName,_nRate,_rate],1] call FUNC(raiseEvent);

true