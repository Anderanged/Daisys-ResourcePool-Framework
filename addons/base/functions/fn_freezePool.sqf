#include "defines.hpp"
params [
	["_obj",objNull,[objNull]],
	["_varName",QPVAR(pool),[""]]
];

if (_obj == objNull) exitWith {
	RPT_DTAIL(ERROR,SJOIN("Invalid object specified: ",str _obj,""),__FILE__,__LINE__);
	false
};

// was pool init'd?
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	private _message = SJOIN4("Pool ",_varName," not initialized on ",str _obj,"");
	RPT_DTAIL(ERROR,_message,__FILE__,__LINE__);
	false
};

private _ice = _obj getVariable SUJOIN(_varName,"frozen");
// broadcast events locally
switch _ice do {
	case (_ice):	   {
		[QPVAR(unfreeze),[_obj,_varName],0] call FUNC(raiseEvent);
	};
	case (!_ice):	   {
		[QPVAR(freeze),[_obj,_varName],0] call FUNC(raiseEvent)
	};
	default {};
};
//set var to opposite
_obj setVariable [SUJOIN(_varName,"frozen"),!_ice];
//return value that was set
!_ice