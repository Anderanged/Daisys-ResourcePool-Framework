#include "defines.hpp"
private _fnc_handleGreater = {
	params["_bound","_cVal","_total","_methodO","_eParams"];
	switch (true) do { // check if overflow: priority = bound, <= bound, > bound
		case (_cVal == _bound) : { // is equal to bound?
			// raise event only locally to the obj
			[E_UBOUND,_eParams,0] call FUNC(raiseEvent);
			// return value
			false
		};
		case (_total <= _bound)  : {
			_total
		};
		case (_total > _bound)  : { // is greater to bound?
			// reject
			if (_methodO) exitWith {
				[E_REJECT,_eParams,0] call FUNC(raiseEvent);
				false
			};
			// clamp
			[E_CLAMP,_eParams,0] call FUNC(raiseEvent);
			_bound
		};
		default {
			// debug here
			RPT_DTAIL(ERROR,"How did you do that?",__FILE__,__LINE__);
			[QPVAR(error),[__FILE__,__LINE__,"ERROR","How did you do that?"],0] call FUNC(raiseEvent);
		};
	};
};
private _fnc_handleLess = {
	params["_bound","_cVal","_total","_methodO","_eParams"];
	switch (true) do { // check if overflow: priority = bound, <= bound, > bound
		case (_cVal == _bound) : { // is equal to bound?
			// raise event only locally to the obj
			[E_LBOUND,_eParams,0] call FUNC(raiseEvent);
			// return value
			false
		};
		case (_total >= _bound)  : {
			_total
		};
		case (_total < _bound)  : { // is less than bound?
			// reject
			if (_methodO) exitWith {
				[E_REJECT,_eParams,0] call FUNC(raiseEvent);
				false
			};
			// clamp
			[E_CLAMP,_eParams,0] call FUNC(raiseEvent);
			_bound
		};
		default {
			// debug here
			RPT_DTAIL(ERROR,"How did you do that?",__FILE__,__LINE__);
			[E_ERROR,[__FILE__,__LINE__,"ERROR","How did you do that?"],0] call FUNC(raiseEvent);
		};
	};
};
/*
Author: Daisy

Description:  	alters energy pool by the amount and method given

Params:
_obj 
_varName
_amount
_methods

Returns: 
true on failure, resulting number on success

Public: yes
*/
if (isDedicated) exitWith {
	RPT_DTAIL(INFO,"Local functions will not execute on dedicated server.",__FILE__,__LINE__);
	[E_LOCSERV,[__FILE__],1] call FUNC(raiseEvent);
	false
};
private _obj = _this param [0,objNull,[objNull]];
// check obj
if (_obj == objNull) exitWith {
	RPT_DTAIL(ERROR,SJOIN("Invalid object specified: ",str _obj,""),__FILE__,__LINE__);
	false
};
if !(local _obj) exitWith {
	RPT_DTAIL(ERROR,SJOIN3("Object",str _obj,"is not local to the current machine. Aborting local function."," "),__FILE__,__LINE__);
	false
};
private _varName = _this param [1,"",[""]];
// was pool init'd?
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	RPT_DTAIL(ERROR,SJOIN4("Pool ",_varName," not initialized on ",str _obj,""),__FILE__,__LINE__);
	false
};
// is pool frozen?
private _ice = _obj getVariable SUJOIN(_varName,"frozen");
if (_ice) exitWith { // if so:
	RPT_DTAIL(INFO,SJOIN5("Pool ",_varName," on object ",str _obj," is frozen. Smoothing not performed.",""),__FILE__,__LINE__);
	[E_ONICE,[_obj,_varName],1] call FUNC(raiseEvent);
	false
};
private _amount = _this param [2,0,[0]];
private _methods = _this param [3,[false,false],[[]],2];
_methods params [	
	["_methodM",false,[false,""]],				// default add
	["_methodO",false,[false,""]]				// default clamp
];
if (_methodM isEqualType "") then {
	switch _methodM do {
		case "s" : {_methodM = true;};
		case "a" : {_methodM = false;};
		default {
			if true exitWith {
				// add debug error
				RPT_DTAIL(ERROR,SJOIN("Invalid math operation given:",_methodM," "),__FILE__,__LINE__);
			};
		};
	};
};
if (_methodO isEqualType "") then {
	switch _methodO do {
		case "r" : {_methodO = true;};
		case "c" : {_methodO = false;};
		default {
			if true exitWith {
				// add debug error
				RPT_DTAIL(ERROR,SJOIN("Invalid overflow method given:",_methodO," "),__FILE__,__LINE__);
			};
		};
	};
};

_amount = floor (abs _amount);

// grab and predef vars
private _cVal 		= _obj getVariable _varName;
private _limit 		= _obj getVariable SUJOIN(_varName,"limit");
private _eParams 	= [_obj,_varName,_amount,_methods];
private "_result";

// if subtraction
if (_methodM) then {
	// call func
	_result = [0,_cVal,_cVal - _amount,_methodO,_eParams] call _fnc_handleLess;
} else {
	// else addition
	_result = [_limit,_cVal,_cVal + _amount,_methodO,_eParams] call _fnc_handleGreater;
};

// if no alter, return false
if (_result isEqualType false) exitWith {false};
_obj setVariable [_varName,_result];
[E_ALTERED,_eParams,0] call FUNC(raiseEvent);
_result