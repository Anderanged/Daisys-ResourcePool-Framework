#include "defines.hpp"
/*
Author: Daisy

Description:  	alters energy pool by the amount and method given

Params:
_obj 
_varName
_amount
_methods

Returns: 
true on success, false on failure

Public: yes
*/
params [
	["_obj",objNull,[objNull]], 		// default objNull
	["_varName",QPVAR(pool),[""]], 		// default DSY_rpf_pool
	["_rate",[10,1],[[]]],				// default [10,1]
	["_methods",[0,false,false],[[]]]
];
_rate params [
	["_amount",2,[0]],
	["_time",1,[0]]
];
_methods params [	
	["_methodM",0,[0]],				// default add
	["_methodO",false,[false]]		// default clamp
];
//check varname
if (_obj == objNull) exitWith {
	RPT_DTAIL(ERROR,"Invalid object specified: "+str _obj,__FILE__,__LINE__);
	false;
};

private _ice = _obj getVariable SUJOIN(_varName,"frozen");
if (isNull _ice) exitWith {
	private _message = ["Pool ",_varName," not initialized on ",str _obj] joinString "";
	RPT_DTAIL(ERROR,_message,__FILE__,__LINE__);
	false;
};
if (_ice) exitWith {
	private _message = ["Pool ",_varName," on object ",str _obj," is frozen. Alteration not performed."] joinString "";
	RPT_DTAIL(INFO,_message,__FILE__,__LINE__);
	[QPVAR(onIce),[_obj,_varName,_rate,_methods],1] call FUNC(raiseEvent);
	false;
};


//predefine and compile vars
private _cVal 		= _obj getVariable _varName;
private _limits 	= _obj getVariable SUJOIN(_varName,"limits");
private _eParams	= [_obj,_varName,_rate,_methods];
private _delay 		= (_time) / (_amount);
if (_delay < 0.001) then {_delay = 0.001;}; // clamp sleep to smallest value
_limits params ["_lBound","_uBound"];
private "_result";

if (_methodM) exitWith { // subtraction
	_result = [_lBound,_cVal,_cVal - _amount,_methodO,_eParams] call FUNC(handleLess);
	// if rejected and no alteration need be done, exit
	if _result exitWith {false;};
	// if accepted, then
	[
		_obj,
		_delay,
		[_varName,_amount,_result,_cVal],
		{ // loop condition
			params[["_args",[],[[]]],["_i",0,[0]]];
			_i < (_args # 1);
		},
		{ // continue condition
			false;
		},
		{ // event
			params[["_obj",objNull,[objNull]],["_args",[],[[]]],["_i",0,[0]]];
			_args params ["_varName","_amount","_result","_cVal"];
			private _nVal = _cVal - _i;
			_obj setVariable [_varName, _nVal];
		},
		[QPVAR(alter),_eParams]
	];
};
// addition
_result = [_uBound,_cVal,_cVal + _amount,_methodO,_eParams] call FUNC(handleGreater);
if _result exitWith {false;};
[
	_obj,
	_delay,
	[_varName,_result,_cVal],
	{ // loop condition
		params[["_args",[],[[]]],["_i",0,[0]]];
		_i < (_args # 1);
	},
	{ // continue condition
		false;
	},
	{ // event
		params[["_obj",objNull,[objNull]],["_args",[],[[]]],["_i",0,[0]]];
		_args params ["_varName","_result","_cVal"];
		private _nVal = _cVal + _i;
		_obj setVariable [_varName, _nVal];
	},
	[QPVAR(alter),_eParams]
] call FUNC(loopPool);
true;