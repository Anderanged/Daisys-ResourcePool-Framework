#include "defines.hpp"

if (isDedicated) exitWith {
	RPT_DTAIL(INFO,"Local functions will not execute on dedicated server.",__FILE__,__LINE__);
	[E_LOCSERV,[__FILE__],1] call FUNC(raiseEvent);
	false
};
params [
	["_obj",objNull,[objNull]],
	["_varName",QPVAR(pool),[""]]
];

if (_obj == objNull) exitWith {
	RPT_DTAIL(ERROR,SJOIN("Invalid object specified: ",str _obj,""),__FILE__,__LINE__);
	false
};

// is obj local?
if !(local _obj) exitWith {
	RPT_DTAIL(ERROR,SJOIN3("Object",str _obj,"is not local to the current machine. Aborting local function."," "),__FILE__,__LINE__);
	false
};

// was pool init'd?
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	private _message = SJOIN4("Pool ",_varName," not initialized on ",str _obj,"");
	RPT_DTAIL(ERROR,_message,__FILE__,__LINE__);
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