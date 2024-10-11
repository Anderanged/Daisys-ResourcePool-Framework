#include "defines.hpp"
/*
Function: RPF_fnc_poolStopRD

Description:

	Halts currently looping renew/decay function on a given pool by setting the renew/decay ID number to 0.

Parameters:

	_obj -		object that the pool you want to stop renew/decay looping is on [Object]
	_varName -	name of the pool you want to stop renew/decay looping for [String]

Returns: 

false on failure, true on success

Examples:
    --- Code
	// sets the renew/decay ID number to 0.
    // this stops renew/decay loops, if either are present.
    [box1,"pool"] call RPF_fnc_poolStopRD;
	---

CBA Events:
	- RPF_poolStopRD
	> raised upon successful execution of poolStopRD

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
private _array		= _obj getVariable SUJOIN(_varName,"RD_Array");
private _rate		= _array # 1;
_obj setVariable [SUJOIN(_varName,"RD_Array"),[0,_rate],true];

[QPVAR(stopRD),[_obj,_varName,_rate],1] call FUNC(raiseEvent);

true