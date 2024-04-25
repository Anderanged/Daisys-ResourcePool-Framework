#include "defines.hpp"

if (isDedicated) exitWith {
	RPT_DTAIL("Error: Local functions will not execute on dedicated server.",__FILE__,__LINE__);
	[E_LOCSERV,[__FILE__],1] call FUNC(raiseEvent);
	false
};
params [
	["_obj",objNull,[objNull]],
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
// was pool init'd?
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	_msg = format ["Error: Pool (%1) not initialized on object (%2). Alteration failed.",_varName,_obj];
	RPT_DTAIL(_msg,__FILE__,__LINE__);
	false
};
private _ice = _obj getVariable SUJOIN(_varName,"frozen");
//set var to opposite
_obj setVariable [SUJOIN(_varName,"frozen"),!_ice];
// broadcast events locally
switch _ice do {
	case (_ice):	   {
		[E_UNFROZEN,[_obj,_varName],0] call FUNC(raiseEvent);
	};
	case (!_ice):	   {
		[E_FROZEN,[_obj,_varName],0] call FUNC(raiseEvent)
	};
	default {};
};
//return value that was set
!_ice