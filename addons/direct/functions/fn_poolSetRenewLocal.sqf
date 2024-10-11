#include "defines.hpp"
/*
given an obj, varname, and rate, updates varname pool on obj with given rate and calls renew func
*/
if (isDedicated) exitWith {
	RPT_DTAIL("Error: Local functions will not execute on dedicated server.",__FILE__,__LINE__);
	[E_LOCSERV,[__FILE__],1] call FUNC(raiseEvent);
	false
};
private _obj 		= _this param [0,objNull,[objNull]];
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
private _varName = _this param [1,"",[""]];
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

_obj setVariable [SUJOIN(_varName,"RD_Array"),[1,_newRate]];

[QPVAR(setRenew),[_obj,_varName,_newRate],0] call FUNC(raiseEvent);

[_obj,_varName] call FUNC(renewPoolLocal);

true