#include "defines.hpp"
/*
given an obj, varname, and limit, updates varname pool on obj with given limit
*/
if (isDedicated) exitWith {
	RPT_DTAIL(INFO,"Local functions will not execute on dedicated server.",__FILE__,__LINE__);
	[E_LOCSERV,[__FILE__],1] call FUNC(raiseEvent);
	false
};
private _obj 		= _this param [0,objNull,[objNull]];
if (_obj == objNull) exitWith {
	RPT_DTAIL(ERROR,SJOIN("Invalid object specified: ",str _obj,""),__FILE__,__LINE__);
	false
};
if !(local _obj) exitWith {
	RPT_DTAIL(ERROR,SJOIN3("Object",str _obj,"is not local to the current machine. Aborting local function."," "),__FILE__,__LINE__);
	false
};
private _varName 	= _this param [1,QPVAR(pool),[""]];
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	RPT_DTAIL(ERROR,SJOIN4("Pool ",_varName," not initialized on ",str _obj,""),__FILE__,__LINE__);
	false
};
private _limit 		= _obj getVariable SUJOIN(_varName,"limit");
private _newLimit 	= _this param [2,_limit,[0]];

_newLimit = floor (abs _newLimit);

if (_newLimit > RPFLIM_MAX) then {_newLimit = RPFLIM_MAX;};

_obj setVariable [SUJOIN(_varName,"limit"),_newLimit];

[QPVAR(setLimit),[_obj,_varName,_newLimit],0] call FUNC(raiseEvent);

true