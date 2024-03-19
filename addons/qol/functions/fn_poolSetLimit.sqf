#include "defines.hpp"
/*
given an obj, varname, and limit, updates varname pool on obj with given limit
*/
private _obj 		= _this param [0,objNull,[objNull]];
if (_obj == objNull) exitWith {
	RPT_DTAIL(ERROR,SJOIN("Invalid object specified: ",str _obj,""),__FILE__,__LINE__);
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

_obj setVariable [SUJOIN(_varName,"limit"),_newLimit,true];

[QPVAR(setLimit),[_obj,_varName,_newLimit],1] call FUNC(raiseEvent);

true