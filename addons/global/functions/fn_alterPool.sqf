#include "defines.hpp"
private _fnc_handleGreater = {
	params["_bound","_cVal","_total","_methodO","_eParams"];
	switch (true) do { // check if overflow: priority = bound, <= bound, > bound
		case (_cVal == _bound) : { // is equal to bound?
			// raise event
			EVENT_SERVER(E_UBOUND,_eParams);
			false
		};
		case (_total <= _bound)  : {
			_total
		};
		case (_total > _bound)  : { // is greater to bound?
			if (_methodO) then {
				// reject
				EVENT_SERVER(E_REJECT,_eParams);
				false
			} else {
				// clamp
				EVENT_SERVER(E_CLAMP,_eParams);
				_bound
			};
		};
		default {
			FATAL("How did you do that???",__FILE__,__LINE__);
		};
	};
};
private _fnc_handleLess = {
	params["_bound","_cVal","_total","_methodO","_eParams"];
	switch (true) do { // check if overflow: priority = bound, <= bound, > bound
		case (_cVal == _bound) : { // is equal to bound?
			// raise event
			EVENT_SERVER(E_LBOUND,_eParams);
			false
		};
		case (_total >= _bound)  : {
			_total
		};
		case (_total < _bound)  : { // is less than bound?
			if (_methodO) then {
				// reject
				EVENT_SERVER(E_REJECT,_eParams);
				false
			} else {
				// clamp
				EVENT_SERVER(E_CLAMP,_eParams);
				_bound
			};
		};
		default {
			// debug here
			FATAL("How did you do that???",__FILE__,__LINE__);
		};
	};
};
/*
Function: RPF_fnc_alterPool

Description:

	Alters _varName pool on object _obj by _amount with _methods

Parameters:

	_obj - The object you want to alter all the pools of [Object]
	_varName - The name of the pool you want to alter [String]
	_amount - The amount which you want to alter each pool by [Number]
	_methods - The methods of alteration [Array of methods]
		- Array is in format: [_mathOperation,_overflowMethod]
			- Index 0: True or `"s"` if subtraction, false or `"a"` if addition (default false) [Boolean or String]
			- Index 1: True or `"r"` if reject an alteration over the limit, false or `"c"` if clamp the alteration to the limit (default false) [Boolean or String]

Returns: 

true on failure, final altered amount on success

Examples:
    --- Code
	// subtracts 20 from "pool" on box1 and clamps if it exceeds the limits. 
	// returns (current value of pool - 20) if not clamped, returns lower bound (always 0) if clamped
	[box1,"pool",20,[true,false]] call DSY_rpf_fnc_alterPool;
    ---
	--- Code
	// adds 45 to "pool" on bag12 and rejects it if it exceeds the limits. 
	// returns (current value of pool + 45) if not rejected, false if rejected
    [bag12,"pool",45,["a","r"]] call DSY_rpf_fnc_alterPool;
	---

Author: Daisy
*/
private _obj = _this param [0,objNull,[objNull]];
private _poolArr = [QPVAR(objectPools),missionNamespace,_obj] call database_fnc_query;
private _msg = "";
// check obj
if (_poolArr isEqualType "BOOL") exitWith {
	_msg = format ["Invalid object (%1) specified. Not a valid resource pool.",_obj];
	ERROR(_msg);
	false
};

private _varName = _this param [0,"",[""]];
if (_varName in _poolArr || _varName == "") exitWith {
	_msg = format ["Invalid object (%1) specified. Not a valid resource pool.",_obj];
	ERROR(_msg);
	false
};

// is pool frozen?
private _ice = _obj getVariable SUJOIN(_varName,"frozen");
if (_ice) exitWith { // if so:
	private _eParams = [_obj,_varName];
	EVENT_SERVER(E_ONICE,_eParams);
	false
};

params [
	["_obj",objNull,[objNull]], 		// default objNull
	["_varName",QPVAR(pool),[""]], 		// default DSY_rpf_pool
	["_amount",0,[0]],				// default [10,1]
	["_methods",[false,false],[[]],2]
];

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
				_msg = format ["Invalid math operation given: %1",_methodM];
				RPT_DTAIL(_msg,__FILE__,__LINE__);
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
				_msg = format ["Invalid overflow method given: %1",_methodO];
				RPT_DTAIL(_msg,__FILE__,__LINE__);
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
_obj setVariable [_varName,_result,true];
[E_ALTERED,_eParams,1] call FUNC(raiseEvent);
_result