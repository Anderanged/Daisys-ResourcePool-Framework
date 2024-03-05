#include "defines.hpp"
/*
Author: Daisy

Description:  	initializes resource pool from options given.

Params:
_obj 

Returns: 
nothing

Public: yes
*/
params [
	["_obj",objNull,[objNull]],
	["_varName",QPVAR(pool),[""]],
	["_limits",[0,RPFLIM_MAX],[[]]], 
	["_renew",false,[true]],
	["_rate",[],[[]]], 
	["_methods",[],[[]]]
];

// check limits
_limits params ["_lBound","_uBound"];
switch (_limits) do {
	case (_lBound < 0 || _uBound#1 < 0): {
		exitWith {
			RPT_DTAIL(ERROR,"Invalid bound (less than 0) in limit array "+str _limits,__FILE__,__LINE__);
			false;
		};
	};
	case (_lBound > RPFLIM_MAX || _uBound > RPFLIM_MAX): {
		exitWith {
			RPT_DTAIL(ERROR,"Invalid bound (greater than 2^14) in limit array "+str _limits,__FILE__,__LINE__);
			false;
		};
	};
	default {nil};
};

//lookup obj in mission hash log
private _hash = missionNamespace getVariable QPVAR(resourcePools);
private _array = _hash getOrDefault [_obj,true];

if _array then { // if not present, set key value pair
	_hash set [_obj,[_varName]];
} else { // if present, append new variable name to hash
	_nArray = _array + [_varName];
	_hash set [_obj,_nArray];
};
// update mission hash log
missionNamespace setVariable [QPVAR(resourcePools),_hash];

// init pool variable
_obj setVariable [_varName,_uBound];
// predef variable storage array (limits, renew, rate, methods)

// if is renewable
if (_renew) then {
	// creates a loop on the pool that renews it by _amnt every _delay
	[_obj,_varName,_rate,_methods] call FUNC(renewPool);
};
// init pool variable storage
_obj setVariable [SUJOIN(_varName,"limits"),_limits]; // if _varName == varName, variable is named "varName_vars"
_obj setVariable [SUJOIN(_varName,"frozen"),false];	

_obj addEventHandler ["Killed",{
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	// get hash
	private _hash = missionNamespace getVariable QPVAR(resourcePools);
	private _array = _hash get _unit;
	{// remove all vars related to being a pool
		_unit setVariable [_x, nil];
		_unit setVariable [SUJOIN(_x,"limits"), nil];
		_unit setVariable [SUJOIN(_x,"frozen"), nil];
	} forEach _array;
	// remove from and update hashmap
	_hash deleteAt _unit;
	missionNamespace setVariable [QPVAR(resourcePools),_hash];
	// remove this eventHandler
	_unit removeEventHandler _thisEventHandler;
}];