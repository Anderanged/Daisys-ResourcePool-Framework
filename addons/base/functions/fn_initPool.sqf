#include "defines.hpp"
/*
Author: Daisy

Description:  	initializes resource pool from options given.

Params:
_obj
_varName
_limits
_renew
_rate
[false,false]

Returns: 
nothing

Public: yes
*/
params [
	["_obj",objNull,[objNull]],
	["_varName",QPVAR(pool),[""]],
	["_limits",[0,RPFLIM_MAX],[[]],2], 
	["_renew",0,[0]],// default no effect
	["_rate",[],[[]],2]
];
_rate params [
	["_amount",2,[0]],
	["_time",1,[0]]
];

// check limits
_limits params ["_lBound","_uBound"];
switch (_limits) do {
	case (_lBound < 0 || _uBound < 0): {
		if true exitWith {
			//RPT_DTAIL(ERROR,"Invalid bound (less than 0) in limit array "+str _limits,__FILE__,__LINE__);
			false
		};
	};
	case (_lBound > RPFLIM_MAX || _uBound > RPFLIM_MAX): {
		if true exitWith {
			//RPT_DTAIL(ERROR,"Invalid bound (greater than 2^14) in limit array "+str _limits,__FILE__,__LINE__);
			false
		};
	};
	default {};
};

//lookup obj in mission hash log
private _key 	= str _obj;
private _hash 	= missionNamespace getVariable QPVAR(resourcePools);
private _array 	= _hash get _key;

if (isNil _array) then { // if not present, set key value pair
	_hash set [_key,[_varName]];
} else { // if present, append new variable name to hash
	_nArray = _array + [_varName];
	_hash set [_key,_nArray];
};
// update mission hash log
missionNamespace setVariable [QPVAR(resourcePools),_hash];

// init pool variable
_obj setVariable [_varName,_uBound];
// predef variable storage array (limits, renew, rate, methods)

switch (_renew) do {
	case 0 : { // no effect
		_obj setVariable [SUJOIN(_varName,"renew"),[0,[]]];
	}; 
	case 1 : { // renews
		[	_obj,
			_time,
			[_obj,_varName,_amount,[false,false]],
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
		[	_obj,
			_time,
			[_obj,_varName,_amount,[true,false]],
			{true},
			{false},
			{
				_args = param [1,[],[[]]];
				_args call FUNC(alterPool);
			},
			[QPVAR(renewed),[_obj,_varName,_rate,[false,false]]]
		] call FUNC(loopPool);
		_obj setVariable [SUJOIN(_varName,"renew"),[2,_rate]];
	};
	default {};
};

// init pool variable storage
_obj setVariable [SUJOIN(_varName,"limits"),_limits]; // if _varName == varName, variable is named "varName_limits"
_obj setVariable [SUJOIN(_varName,"frozen"),false];	

_obj addEventHandler ["Killed",{
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	// get hash
	private _key	= str _unit;
	private _hash 	= missionNamespace getVariable QPVAR(resourcePools);
	private _array 	= _hash get _key;
	{// remove all vars related to being a pool
		_unit setVariable [_x, nil];
		_unit setVariable [SUJOIN(_x,"renew"), nil];
		_unit setVariable [SUJOIN(_x,"limits"), nil];
		_unit setVariable [SUJOIN(_x,"frozen"), nil];
		_unit setVariable [SUJOIN(_x,"poolInit"), nil];
	} forEach _array;
	// remove from and update hashmap
	_hash deleteAt _key;
	missionNamespace setVariable [QPVAR(resourcePools),_hash];
	// remove this eventHandler
	_unit removeEventHandler _thisEventHandler;
}];

// if all other code above executes, the pool will get it's poolInit verification
_obj setVariable [SUJOIN(_varName,"poolInit"),true];
true