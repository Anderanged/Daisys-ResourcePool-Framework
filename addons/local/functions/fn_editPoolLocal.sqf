#include "defines.hpp"
/*
returns true if settings were altered, false if not
*/
if (isDedicated) exitWith {
	RPT_DTAIL(INFO,"Local functions will not execute on dedicated server.",__FILE__,__LINE__);
	[E_LOCSERV,[__FILE__],1] call FUNC(raiseEvent);
	false
};
private _return 	= [false,false];
private _obj 		= _this param [0,objNull,[objNull]];
private _varName 	= _this param [1,QPVAR(pool),[""]];
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	RPT_DTAIL(ERROR,SJOIN4("Pool ",_varName," not initialized on ",str _obj,""),__FILE__,__LINE__);
	false
};
private _limit 		= _obj getVariable SUJOIN(_varName,"limit");
private _renew 		= _obj getVariable SUJOIN(_varName,"RD_Array");
private _renewType	= _renew # 0;
private _rate		= _renew # 1;
if (_renewType > 0) then {_rate = _renew param [1,[2,1],[[]],2];};
_this params [
	["_obj",objNull,[objNull]],
	["_varName",QPVAR(pool),[""]],
	["_newLimit",_limit,[0]], 
	["_newRenew",_renewType,[0]],// default no effect
	["_newRate",_rate,[[]],2]
];
_newLimit = abs (floor _newLimit);

_newRate 	params ["_nAmount","_nTime"];
_rate 		params ["_amount","_time"];
_nAmount 	= floor (abs _nAmount);
_nTime 		= ceil (abs _nTime);
_newRate 	= [_nAmount,_nTime];
private _isOldRate = (_amount == _nAmount && _time == _nTime);

// only set if we need to
if (_limit != _newLimit) then {_obj setVariable [SUJOIN(_varName,"limit"),_newLimit];_return set [0,true];};

switch _newRenew do {
	case 0 : { // no effect
		if (_renewType == 0) then {
			hint "RD already 0";
		} else {
		_obj setVariable [SUJOIN(_varName,"RD_Array"),[0,[]]];
		_return set [1,true];
		hint "";
		}; 
	};
	case 1 : { // renews
		if (_renewType == 1 && _isOldRate) then {
			hint "RD already 1 & old rate";
		} else {
		_obj setVariable [SUJOIN(_varName,"RD_Array"),[1,_newRate]];
		[_obj,_varName] call FUNC(renewPoolLocal);
		_return set [1,true];
		hint SJOIN("RD was set to renew with rate of",_newRate," ");
		};
	};
	case 2 : { // decays
		if (_renewType == 2 && _isOldRate) then {
			hint "RD already 2 & old rate";
		} else {
		_obj setVariable [SUJOIN(_varName,"RD_Array"),[2,_newRate]];
		[_obj,_varName] call FUNC(decayPoolLocal);
		_return set [1,true];
		hint SJOIN("RD was set to decay with rate of",_newRate," ");
		};
	};
	default {};
};
[E_EDITED,[_obj,_varName,[_limit,_renew],[_newLimit,[_newRenew,_newRate]]],0] call FUNC(raiseEvent);
_return