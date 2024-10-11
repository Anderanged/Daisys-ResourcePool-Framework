#include "defines.hpp"
/*
Function: RPF_fnc_renewPool

	For a more convenient function, see <poolSetRenew: https://www.naturaldocs.org/getting_started/documenting_your_code/#the_basics>.
	
Description:

	Adds to a pool given the pool's internally set rate. Loops until the pool's internally set renew status changes.

Parameters:

	_obj -		object that the pool you want to begin renewing is on [Object]
	_varName -	name of the pool you want to renew [String]
	
Returns: 

none

Examples:
    --- Code
	// will renew by internally given rate
    [box1, "pool"] call RPF_fnc_renewPool;
    ---

CBA Events:
	- RPF_altered
	> raised when pool is altered

	- RPF_renewed
	> raised upon successful execution of renewPool

Author: Daisy
*/
params [
	["_obj",objNull,[objNull]],
	["_varName",QPVAR(pool),[""]]
];
private _time = ((_obj getVariable SUJOIN(_varName,"RD_Array")) # 1) # 1;
[
	{
		// to be ex
		params ["_obj","_varName"];
		private _array = _obj getVariable SUJOIN(_varName,"RD_Array"); // solution to RD Lag (issue #1)
		_array params [
			"_renew",
			"_rate"
		];
		if (_renew != 1) exitWith {
			[E_RENEWSTOP,[_obj,_varName,_rate],1] call FUNC(raiseEvent);
		}; // if it aint renewable, BREAK THE CYCLE
		// otherwise, take the blue pill
		[_obj,_varName,(_rate # 0),ADD_CLAMP] call FUNC(alterPool);
		[E_RENEWED,[_obj,_varName,_rate],1] call FUNC(raiseEvent);
		[_obj,_varName] call FUNC(renewPool);
	},
	[
		// arguments to pass to the above
		_obj,
		_varName
	],
	_time // delay in seconds
] call CBA_fnc_waitAndExecute;
true