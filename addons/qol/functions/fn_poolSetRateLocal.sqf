#include "defines.hpp"
/*
sets RD_Array to player given values without calling any functions
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
private _rdArray	= _obj getVariable SUJOIN(_varName,"RD_Array");
private _rd			= _rdArray # 0;
private _rate		= _rdArray # 1;
private _nRate		= _this param [2,_rate,[[]]];
if (count _nRate > 2 || count _nRate < 2) then {_nRate = _rate;};
_nRate params [["_amnt",0,[0]],["_time",0,[0]]];
_amnt 	= floor (abs _amnt);
_time 	= ceil (abs _time);
_nRate 	= [_amnt,_time];

_obj setVariable [SUJOIN(_varName,"RD_Array"),[_rd,_nRate]];

[QPVAR(setRate),[_obj,_varName,[_rd,_nRate]],0] call FUNC(raiseEvent);

true