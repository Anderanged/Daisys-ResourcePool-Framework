#include "defines.hpp"
/*
sets RD_Array to player given values without calling any functions
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

private _rdArray	= _obj getVariable SUJOIN(_varName,"RD_Array");
private _rd			= _rdArray # 0;
private _rate		= _rdArray # 1;
private _nRD 		= _this param [2,_rd,[0]];
private _nRate		= _this param [3,_rate,[[]]];
if (count _nRate > 2 || count _nRate < 2) then {_nRate = _rate;};
_nRate params ["_amnt","_time"];
_amnt 	= floor (abs _amnt);
_time 	= ceil (abs _time);
_nRate 	= [_amnt,_time];

_obj setVariable [SUJOIN(_varName,"RD_Array"),[_nRD,_nRate],true];

[QPVAR(setRD),[_obj,_varName,[_nRD,_nRate]],1] call FUNC(raiseEvent);

true