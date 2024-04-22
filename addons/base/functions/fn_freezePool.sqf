#include "defines.hpp"
/*
Function: RPF_fnc_freezePool

Description:

	Halts all alterations (addition/subtraction) on a given pool.

	*Does not interrupt the delay/renew loop*, it only halts the alteration call they make.

Parameters:

	_obj -		object that the pool you want to freeze is on [Object]
	_varName -	name of the pool you want to freeze [String]
	
Returns: 

true if the pool has been frozen, false if it has been unfrozen

Examples:
    --- Code
	// if not already frozen, returns true
    [box1,"pool"] call RPF_fnc_freezePool;
    // calling again after returns false
    [box1,"pool"] call RPF_fnc_freezePool;
    ---

CBA Events:
	- RPF_frozen
	> raised if the pool was frozen

	- RPF_unfrozen
	> raised if the pool was unfrozen

Author: Daisy
*/
params [
	["_obj",objNull,[objNull]],
	["_varName",QPVAR(pool),[""]]
];

if (_obj == objNull) exitWith {
	RPT_DTAIL(ERROR,SJOIN("Invalid object specified: ",str _obj,""),__FILE__,__LINE__);
	false
};

// was pool init'd?
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	private _message = SJOIN4("Pool ",_varName," not initialized on ",str _obj,"");
	RPT_DTAIL(ERROR,_message,__FILE__,__LINE__);
	false
};

private _ice = _obj getVariable SUJOIN(_varName,"frozen");
//set var to opposite
_obj setVariable [SUJOIN(_varName,"frozen"),!_ice,true];
if (_ice) then {
	[E_UNFROZEN,[_obj,_varName],1] call FUNC(raiseEvent);
} else {
	[E_FROZEN,[_obj,_varName],1] call FUNC(raiseEvent);
};

!_ice