#include "defines.hpp"
/*
Function: RPF_fnc_createPool

Description:

	Creates a resource pool with the given parameters.

Parameters:

	_obj -		object to create the resource pool on [Object]
	_varName -	name of the pool you want to create [String]
	_limit -	maximum amount of resource allowed in this pool
	_rd	-		renew/decay ID number [Number] Can be 0, 1 or 2.
		- 0 = Neither renew nor decay
		- 1 = Renew
		- 2 = Decay
	_rate -		rate of renew/decay [Array]
		- Array is in format: [_amount,_time]
			- Index 0: amount of resource to add/subtract each time [Number]
			- Index 1: interval (seconds) between additions/subtractions [Number]

Returns: 

false on failure, true on success

Examples:
    --- Code
	// creates resource pool "pool" on object box1 with limit of 500
	// will decay (subtract) 20 resources every 90 seconds
    [box1, "pool", 500, 2, [20,90]] call RPF_fnc_createPool;
    ---

CBA Events:
	- RPF_created
	> called at successful creation

	- RPF_destroyed
	> called at destruction or killing of resource pool object

Author: Daisy
*/
params [
	["_obj",objNull,[objNull]],
	["_varName",QPVAR(pool),[""]],
	["_limit",100,[0]], 
	["_rd",0,[0]],// default no effect
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
_rd 	= floor (abs _rd);
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
	[E_REPEATP,[_obj,_varName,_limit,[_rd,_rate]],1] call FUNC(raiseEvent);
	false
};

// init pool variable
_obj setVariable [_varName,_limit,true];

switch (_rd) do {
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

// add check for obj to not get overwhelmed with EHs
private _array = [_obj,"r",[]] call FUNC(accessHash);
if (_array isEqualType false) then { // only add the first time the obj is initialized
	_obj addEventHandler ["Killed",{
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		_unit call FUNC(removeAllPools);
		/*private _array = [_unit,"r",[]] call FUNC(accessHash);
		{// remove all vars related to being a pool
			_unit setVariable [_x, nil,true];
			_unit setVariable [SUJOIN(_x,"RD_Array"), nil,true];
			_unit setVariable [SUJOIN(_x,"limit"), 	  nil,true];
			_unit setVariable [SUJOIN(_x,"frozen"),   nil,true];
			_unit setVariable [SUJOIN(_x,"poolInit"), nil,true];
		} forEach _array;
		// remove from and update hashmap
		[_unit,"d",[]] call FUNC(accessHash);*/
		RPT_BASIC(INFO,SJOIN3("Object",str _unit,"has been destroyed or killed and has been removed as a resource pool."," "));
		[E_DESTRYD,[_unit],1] call FUNC(raiseEvent;)
		// remove this eventHandler
		_unit removeEventHandler _thisEventHandler;
	}];
};

// if all other code above executes, the pool will get it's poolInit verification
_obj setVariable [SUJOIN(_varName,"poolInit"),true,true];
RPT_BASIC(INFO,SJOIN3("Object",str _obj,"has been initialized as a resource pool."," "));
[E_CREATED,[_obj,_varName,_limit,[_rd,_rate]],1] call FUNC(raiseEvent);
true