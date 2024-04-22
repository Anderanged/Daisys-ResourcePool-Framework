#include "defines.hpp"
/*
Author: Daisy

Description:  	initializes resource pool from options given.

Params:
_obj
_varName
_limit
_rd
_rate
[false,false]

Returns: 
nothing

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
if (_varName == "") exitWith {
	RPT_DTAIL(ERROR,SJOIN("Invalid (empty) pool varName specified on object: ",str _obj,""),__FILE__,__LINE__);
	false
};
params [
	"_obj",
	"_varName",
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

// add check for obj to not get overwhelmed with EHs
private _array = [_obj,"r",[]] call FUNC(accessHash);
if (_array isEqualType false) then { // only add the first time the obj is initialized
	_obj addEventHandler ["Killed",{
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		_unit call FUNC(removeAllPoolsLocal);
		RPT_BASIC(INFO,SJOIN3("Object",str _unit,"has been destroyed or killed and has been removed as a resource pool."," "));
		[E_DESTRYD,[_unit],1] call FUNC(raiseEvent;)
		// remove this eventHandler
		_unit removeEventHandler _thisEventHandler;
	}];
};

private _result = [_obj,"a",[_varName]] call FUNC(accessHash);

if !_result exitWith {
	RPT_BASIC(INFO,SJOIN4("Object ",str _obj," already has a pool initialized under varName ",_varName,""));
	[E_REPEATP,[_obj,_varName,_limit,[_rd,_rate]],1] call FUNC(raiseEvent);
	false
};

// init pool variable
_obj setVariable [_varName,_limit];

switch (_rd) do {
	case 0 : { // no effect
		_obj setVariable [SUJOIN(_varName,"RD_Array"),[0,[]]]; // array in format: [Renew/Decay on, type, rate (amount,time)]
	}; 
	case 1 : { // renews
		_obj setVariable [SUJOIN(_varName,"RD_Array"),[1,_rate]];
		[_obj,_varName] call FUNC(renewPoolLocal);
	};
	case 2 : { // decays
		_obj setVariable [SUJOIN(_varName,"RD_Array"),[2,_rate]];
		[_obj,_varName] call FUNC(decayPoolLocal);
	};
	default {};
};

// init pool variable storage
_obj setVariable [SUJOIN(_varName,"limit"),_limit];
_obj setVariable [SUJOIN(_varName,"frozen"),false];

// if all other code above executes, the pool will get it's poolInit verification
_obj setVariable [SUJOIN(_varName,"poolInit"),true];
RPT_BASIC(INFO,SJOIN3("Object",str _obj,"has been initialized as a resource pool."," "));
true