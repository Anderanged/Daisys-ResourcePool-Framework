#include "defines.hpp"
private _fnc_handleGreater = {
	params["_bound","_cVal","_total","_methodO"];
	switch (true) do { // check if overflow: priority = bound, <= bound, > bound
		case (_cVal == _bound) : { // is equal to bound?
			// return value
			false
		};
		case (_total <= _bound)  : {
			true
		};
		case (_total > _bound)  : { // is greater to bound?
			// reject
			if (_methodO) then {
				false
			} else {
				true
			};
		};
		default {
			// debug here
			RPT_DTAIL(ERROR,"How did you do that?",__FILE__,__LINE__);
		};
	};
};
private _fnc_handleLess = {
	params["_bound","_cVal","_total","_methodO"];
	switch (true) do { // check if overflow: priority = bound, <= bound, > bound
		case (_cVal == _bound) : { // is equal to bound?
			// return value
			false
		};
		case (_total >= _bound)  : {
			true
		};
		case (_total < _bound)  : { // is less than bound?
			// reject
			if (_methodO) then {
				false
			} else {
			// clamp
				true
			};
		};
		default {
			// debug here
			RPT_DTAIL(ERROR,"How did you do that?",__FILE__,__LINE__);
		};
	};
};
/*
Function: RPF_fnc_alterPoolSpoof

Description:

	Spoofs an alter call for _varName pool on object _obj by _amount with _methods. 

	Raises no events, makes no alterations. Only returns boolean value to check if an alter can be made. Constructed exclusively for smoothHudExp.

Parameters:

	_obj - The object you want to alter all the pools of [Object]
	_varName - The name of the pool you want to alter [String]
	_amount - The amount which you want to alter each pool by [Number]
	_methods - The methods of alteration [Array of methods]
		- Array is in format: [_mathOperation,_overflowMethod]
			- Index 0: True or `"s"` if subtraction, false or `"a"` if addition (default false) [Boolean or String]
			- Index 1: True or `"r"` if reject an alteration over the limit, false or `"c"` if clamp the alteration to the limit (default false) [Boolean or String]

Returns: 

false on failure, true on success

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

// check obj
if (_obj == objNull) exitWith {
	RPT_DTAIL(ERROR,SJOIN("Invalid object specified: ",str _obj,""),__FILE__,__LINE__);
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
//private "_result";

// if subtraction
if (_methodM) then {
	// call func
	//_result = [0,_cVal,_cVal - _amount,_methodO,_eParams] call _fnc_handleLess;
	[0,_cVal,_cVal - _amount,_methodO] call _fnc_handleLess
} else {
	// else addition
	//_result = [_limit,_cVal,_cVal + _amount,_methodO,_eParams] call _fnc_handleGreater;
	[_limit,_cVal,_cVal + _amount,_methodO] call _fnc_handleGreater
};

//_result