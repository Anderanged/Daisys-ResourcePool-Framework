#include "defines.hpp"
params [
	["_obj",objNull,[objNull]],
	["_varName",QPVAR(pool),[""]]
];

if (_obj == objNull) exitWith {
	//RPT_DTAIL(ERROR,"Invalid object specified: "+str _obj,__FILE__,__LINE__);
	true
};

// was pool init'd?
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	private _message = ["Pool ",_varName," not initialized on ",str _obj] joinString "";
	//RPT_DTAIL(ERROR,_message,__FILE__,__LINE__);
	true
};

private _ice = _obj getVariable SUJOIN(_varName,"frozen");
// broadcast events locally
switch _ice do {
	case (isNil _ice): {
		exitWith {
			//RPT_DTAIL(ERROR,str _obj + "does not have " + _varName + " initialized as a resource pool.",__FILE__,__LINE__);
		};
	};
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
!_ice