#include "defines.hpp"
/*
sets RD_Array element 0 to 0, stopping renew/delay loop
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
private _array		= _obj getVariable SUJOIN(_varName,"RD_Array");
private _rate		= _array # 1;
_obj setVariable [SUJOIN(_varName,"RD_Array"),[0,_rate],true];

[QPVAR(stopRD),[_obj,_varName,_rate],1] call FUNC(raiseEvent);

true