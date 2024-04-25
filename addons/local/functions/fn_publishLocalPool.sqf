#include "defines.hpp"
if (isDedicated) exitWith {
	RPT_DTAIL("Error: Local functions will not execute on dedicated server.",__FILE__,__LINE__);
	[E_LOCSERV,[__FILE__],1] call FUNC(raiseEvent);
	false
};
/*
takes current values of a local pool and publishes them to all machines
returns false if failiure, true if success
*/
params [
	["_obj",objNull,[objNull]], 		// default objNull
	["_varName",QPVAR(pool),[""]]
];

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
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	_msg = format ["Error: Pool (%1) not initialized on object (%2). Alteration failed.",_varName,_obj];
	RPT_DTAIL(_msg,__FILE__,__LINE__);
	false
};

_obj setVariable [SUJOIN(_varName,"limit"),    	(_obj getVariable SUJOIN(_varName,"limit")),	true];
_obj setVariable [SUJOIN(_varName,"frozen"),   	(_obj getVariable SUJOIN(_varName,"frozen")),	true];
_obj setVariable [SUJOIN(_varName,"poolInit"), 	(_obj getVariable SUJOIN(_varName,"poolInit")),	true];
_obj setVariable [SUJOIN(_varName,"RD_Array"), 	(_obj getVariable SUJOIN(_varName,"RD_Array")),	true];
_obj setVariable [_varName, 					(_obj getVariable _varName), 					true];

true