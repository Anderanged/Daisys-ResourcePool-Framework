#include "defines.hpp"
private _obj 		= _this param [0,objNull,[objNull]];
private _varName 	= _this param [1,QPVAR(pool),[""]];
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith {
	// obj not initialized
	false
};
private _limits 	= _obj getVariable [SUJOIN(_varName,"limits"),true];
private _renew 		= _obj getVariable [SUJOIN(_varName,"renew")];
private _rate		= [];
if ((_renew # 0) > 0) then {_rate = _renew param [1,[2,1],[[]],2];};
_this params [
	["_obj",objNull,[objNull]],
	["_varName",QPVAR(pool),[""]],
	["_newLimits",_limits,[[]],2], 
	["_newRenew",_renew # 0,[0]],// default no effect
	["_newRate",_rate,[[]]]
];
// only set if we need to
if (_limits != _newLimits) then {_obj setVariable [SUJOIN(_varName,"limits"),_newLimits];};

switch _newRenew do {
	case 0 : { // no effect
		if (_renew#0 == 0) exitWith {};
		_obj setVariable [SUJOIN(_varName,"renew"),[0,[]]];
	}; 
	case 1 : { // renews
		if (_renew#0 == 1) exitWith {};
		[	_obj,
			_rate # 1,
			[_obj,_varName,_rate # 0,[false,false]],
			{true},
			{false},
			{
				_args = param [1,[],[[]]];
				_args call FUNC(alterPool);
			},
			[QPVAR(renewed),[_obj,_varName,_rate,[false,false]]]
		] call FUNC(loopPool);
		_obj setVariable [SUJOIN(_varName,"renew"),[1,_rate]];
	};
	case 2 : { // decays
		if (_renew#0 == 2) exitWith {};
		[	_obj,
			_rate # 1,
			[_obj,_varName,_rate # 0,[true,false]],
			{true},
			{false},
			{
				_args = param [1,[],[[]]];
				_args call FUNC(alterPool);
			},
			[QPVAR(decayed),[_obj,_varName,_rate,[false,false]]]
		] call FUNC(loopPool);
		_obj setVariable [SUJOIN(_varName,"renew"),[2,_rate]];
	};
	default {false};
};
_obj setVariable [SUJOIN(_varName,"renew"),[_newRenew,_newRate]];
[QPVAR(edited),[_obj,_varName,[_limits,_renew],[_newLimits,[_newRenew,_newRate]]],0] call FUNC(raiseEvent);
true