#include "defines.hpp"
/*
Author: Daisy

Description:  	initializes energy pool from options given.

options:

object to initialize on
pool max
pool min
if renewable 
recharge rate
recharge methods
[methodM,methodA,methodO]


Params:


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
if ((_limits # 0) < 0 || (_limits # 1) < 0) exitWith {
	RPTDEBUG(__FILE__,__LINE__,"ERROR","Invalid bound (less than 0) in limit array "+str _limits);
	false;
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
_obj setVariable [_varName,_limits#1];
// predef variable storage array (limits, renew, rate, methods)

// if is renewable
if (_renew) then { // add rate and methods
	// need a function that can be called here to take these 4 args
	// creates a loop on the pool that renews it by _amnt every _delay
	[_obj,_limits,_rate,_methods] call FUNC(renewPool);
};
// init pool variable storage
_obj setVariable [QUJOIN(_varName,"limits"),_limits]; // if _varName == varName, variable is named "varName_vars"

_obj addEventHandler ["Killed",{
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	// get hash
	private _hash = missionNamespace getVariable QPVAR(resourcePools);
	private _array = _hash get _unit;
	{// remove all vars related to being a pool
		_unit setVariable [_x, nil];
		_unit setVariable [QUJOIN(_x,"limits"), nil];
	} forEach _array;
	// remove from and update hashmap
	_hash deleteAt _unit;
	missionNamespace setVariable [QPVAR(resourcePools),_hash];
	// remove this eventHandler
	_unit removeEventHandler _thisEventHandler;
}];