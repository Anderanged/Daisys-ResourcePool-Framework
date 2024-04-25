#include "defines.hpp"
/*
sets RD_Array element 0 to 0, stopping renew/delay loop
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
private _array		= _obj getVariable SUJOIN(_varName,"RD_Array");
private _rate		= _array # 1;
_obj setVariable [SUJOIN(_varName,"RD_Array"),[0,_rate]];

[QPVAR(stopRD),[_obj,_varName,_rate],0] call FUNC(raiseEvent);

true