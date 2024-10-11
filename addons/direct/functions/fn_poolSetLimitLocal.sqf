#include "defines.hpp"
/*
given an obj, varname, and limit, updates varname pool on obj with given limit
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
private _limit 		= _obj getVariable SUJOIN(_varName,"limit");
private _newLimit 	= _this param [2,_limit,[0]];

_newLimit = floor (abs _newLimit);

if (_newLimit > RPFLIM_MAX) then {_newLimit = RPFLIM_MAX;};

_obj setVariable [SUJOIN(_varName,"limit"),_newLimit];

[QPVAR(setLimit),[_obj,_varName,_newLimit],0] call FUNC(raiseEvent);

true