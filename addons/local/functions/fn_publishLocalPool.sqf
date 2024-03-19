#include "defines.hpp"
if (isDedicated) exitWith {
	RPT_DTAIL(INFO,"Local functions will not execute on dedicated server.",__FILE__,__LINE__);
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

if !(local _obj) exitWith {
	RPT_DTAIL(ERROR,SJOIN3("Object",str _obj,"is not local to the current machine. Aborting local function."," "),__FILE__,__LINE__);
	false
};
if (_obj == objNull) exitWith {
	RPT_DTAIL(ERROR,SJOIN("Invalid object specified: ",str _obj,""),__FILE__,__LINE__);
	false
};
// was pool init'd?
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	RPT_DTAIL(ERROR,SJOIN4("Pool ",_varName," not initialized on ",str _obj,""),__FILE__,__LINE__);
	false
};

_obj setVariable [SUJOIN(_varName,"limit"),    (_obj getVariable SUJOIN(_varName,"limit")),true];
_obj setVariable [SUJOIN(_varName,"frozen"),   (_obj getVariable SUJOIN(_varName,"frozen")),true];
_obj setVariable [SUJOIN(_varName,"poolInit"), (_obj getVariable SUJOIN(_varName,"poolInit")),true];
_obj setVariable [SUJOIN(_varName,"RD_Array"), (_obj getVariable SUJOIN(_varName,"RD_Array")),true];
_obj setVariable [_varName, (_obj getVariable _varName), true];

true