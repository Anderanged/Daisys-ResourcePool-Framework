#include "defines.hpp"
/*
Function: RPF_fnc_createPool

Description:

	Creates a resource pool with the given parameters.

Parameters:

	_obj -		object to create the resource pool on [Object]
	_varName -	name of the pool you want to create [String]
	_limit -	maximum amount of resource allowed in this pool
	_rd	-		renew/decay ID number [Number, String] Can be 0 (""), 1 ("r") or 2 ("d").
		- 0, ""  = Neither renew nor decay
		- 1, "r" = Renew
		- 2, "d" = Decay
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
private _obj = _this param [0,objNull,[objNull,uiNamespace]];
private _msg = "";
// check obj
if (isNull _obj) exitWith {
	_msg = format ["Invalid object (%1) specified. Objects may not be of type null.",_obj];
	ERROR(_msg);
	false
};

private _varName = _this param [1,"",[""]];
if (_varName == "") exitWith {
	_msg = "Pool variable name may not be an empty string.";
	ERROR(_msg);
	false
};

params [
	["_obj",objNull,[objNull]],
	["_varName","",[""]],
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
if (_limit > RPF_LIM_MAX || _limit <= 0) then {
	_msg = format ["Invalid limit defined (%1). Limit may not be greater than 2^14, less than, or equal to zero. Value set to 2^14.",_limit];
	WARN(_msg);
	_limit = RPF_LIM_MAX;
};

private _eParams = [_obj,_varName,_limit,[_rd,_rate]];

// add check for obj to not get overwhelmed with EHs
private _exists = _obj call database_fnc_exists;
if !(_exists) then { // only add the first time the obj is initialized
	_obj addEventHandler ["Killed",{
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		_unit call FUNC(removeAllPools);
		[E_DESTRYD,[_unit],1] call FUNC(raiseEvent;)
		// remove this eventHandler
		_unit removeEventHandler _thisEventHandler;
	}];
};

private _arr = [QPVAR(objectPools),missionNamespace,_obj] call database_fnc_query;
private _result = _arr pushBackUnique _varName;
if (_result < 0) exitWith {
	_msg = format ["Object (%1) already has a pool initialized under variable name (%2). Creation aborted.",_obj,_varName];
	WARN(_msg);
	EVENT_SERVER(E_REPEATP,_arr);
	false
};
[QPVAR(objectPools),missionNamespace,_obj,_arr] call database_fnc_overwrite;

// init pool variable
_obj setVariable [_varName,_limit,true];

if (_rd isEqualType "STRING") then {
	_rd = 0;
	switch _rd do {
		case "":  {};
		case "r": {_rd = 1;};
		case "d": {_rd = 2;};
		default   {};
	};
};
private _rdStr = SUJOIN(_varName,"RD_Array");
switch (_rd) do {
	case 0 : { // no effect
		_obj setVariable [_rdStr,[0,_rate],true];
	}; 
	case 1 : { // renews
		_obj setVariable [_rdStr,[1,_rate],true];
		[_obj,_varName] call FUNC(renewPool);
	};
	case 2 : { // decays
		_obj setVariable [_rdStr,[2,_rate],true];
		[_obj,_varName] call FUNC(decayPool);
	};
	default {};
};

private _limitStr = SUJOIN(_varName,"limit");
private _frozenStr = SUJOIN(_varName,"frozen");
private _poolInitStr = SUJOIN(_varName,"poolInit");
// init pool variable storage
_obj setVariable [_limitStr,_limit,true];
_obj setVariable [_frozenStr,false,true];	

// if all other code above executes, the pool will get it's poolInit verification
_obj setVariable [_poolInitStr,true,true];
_msg = format ["Object (%1) has been initialized as a resource pool.",_obj];
INFO(_msg);
EVENT_SERVER(E_CREATED,_eParams);
true