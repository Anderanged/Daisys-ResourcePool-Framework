#include "defines.hpp"
/*
given an obj, varname, and rate, updates varname pool on obj with given rate and calls renew func
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
private _rate		= (_obj getVariable SUJOIN(_varName,"RD_Array")) # 1;
private _newRate 	= _this param [2,_rate,[[]]];
private _arrNum 	= count _newRate;
if (_arrNum > 2 || _arrNum < 2) then {_newRate = _rate;};

_rate 		params ["_amount","_time"];
_newRate 	params [["_nAmount",_amount,[0]],["_nTime",_time,[0]]];
_nAmount 	= floor (abs _nAmount);
_nTime 		= ceil (abs _nTime);
_newRate 	= [_nAmount,_nTime];

_obj setVariable [SUJOIN(_varName,"RD_Array"),[1,_newRate],true];

[QPVAR(setRenew),[_obj,_varName,_newRate],1] call FUNC(raiseEvent);

[_obj,_varName] call FUNC(renewPool);

true