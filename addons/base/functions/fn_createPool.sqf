#include "defines.hpp"
/*
Author: Daisy

Description:  	initializes resource pool from options given.

Params:
_obj
_varName
_limit
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
	["_limit",100,[0]], 
	["_renew",0,[0]],// default no effect
	["_rate",[],[[]],2]
];
_rate params [
	["_amount",2,[0]],
	["_time",1,[0]]
];
// take abs and rounded values 
// (eliminate negatives and decimals to avoid possible problems working with limitations of IEEE-754 +
//  its a small optimization for execution time [~ 0.0005 ms / 0.5 picoseconds / 5E-7 seconds])
_limit 	= floor (abs _limit);
_renew 	= floor (abs _renew);
_amount = floor (abs _amount);
_time 	= ceil (abs _time);
_rate 	= [_amount,_time];

// check limit
if (_limit > RPFLIM_MAX) then {
	RPT_DTAIL(INFO,SJOIN3("Invalid limit (greater than 2^14): ",str _limit,". Clamped to 2^14.",""),__FILE__,__LINE__);
	_limit = RPFLIM_MAX;
};

// hash not updating. Why.
// lookup obj in mission hash log
private _result = [_obj,"a",[_varName]] call FUNC(accessHash);

if !_result exitWith {
	RPT_BASIC(INFO,SJOIN4("Object ",str _obj," already has a pool initialized under varName ",_varName,""));
	[E_REPEATP,[_obj,_varName,_limit,[_renew,_rate]],1] call FUNC(raiseEvent);
	false
};

// init pool variable
_obj setVariable [_varName,_limit,true];

switch (_renew) do {
	case 0 : { // no effect
		_obj setVariable [SUJOIN(_varName,"RD_Array"),[0,_rate],true]; // array in format: [Renew/Decay on, type, rate (amount,time)]
	}; 
	case 1 : { // renews
		_obj setVariable [SUJOIN(_varName,"RD_Array"),[1,_rate],true];
		[_obj,_varName] call FUNC(renewPool);
	};
	case 2 : { // decays
		_obj setVariable [SUJOIN(_varName,"RD_Array"),[2,_rate],true];
		[_obj,_varName] call FUNC(decayPool);
	};
	default {};
};

// init pool variable storage
_obj setVariable [SUJOIN(_varName,"limit"),_limit,true];
_obj setVariable [SUJOIN(_varName,"frozen"),false,true];	

_obj addEventHandler ["Killed",{
	params ["_unit", "_killer", "_instigator", "_useEffects"];
	private _array = [_unit,"r",[]] call FUNC(accessHash);
	{// remove all vars related to being a pool
		_unit setVariable [_x, nil,true];
		_unit setVariable [SUJOIN(_x,"RD_Array"), nil,true];
		_unit setVariable [SUJOIN(_x,"limit"), 	  nil,true];
		_unit setVariable [SUJOIN(_x,"frozen"),   nil,true];
		_unit setVariable [SUJOIN(_x,"poolInit"), nil,true];
	} forEach _array;
	// remove from and update hashmap
	[_unit,"d",[]] call FUNC(accessHash);
	RPT_BASIC(INFO,SJOIN3("Object",str _unit,"has been destroyed or killed and has been removed as a resource pool."," "));
	// remove this eventHandler
	_unit removeEventHandler _thisEventHandler;
}];

// if all other code above executes, the pool will get it's poolInit verification
_obj setVariable [SUJOIN(_varName,"poolInit"),true,true];
RPT_BASIC(INFO,SJOIN3("Object",str _obj,"has been initialized as a resource pool."," "));
[E_CREATED,[_obj,_varName,_limit,[_renew,_rate]],1] call FUNC(raiseEvent);
true