#include "defines.hpp"
/*
Function: RPF_fnc_decayPool

	For a more convenient function, see <poolSetDecay: https://www.naturaldocs.org/getting_started/documenting_your_code/#the_basics>.
	
Description:

	Subtracts from a pool given the pool's internally set rate. Loops until Renew/Decay ID number changes.

Parameters:

	_obj -		object that the pool you want to begin decaying is on [Object]
	_varName -	name of the pool you want to decay [String]
	
Returns: 

none

Examples:
    --- Code
	// will decay by internally given rate
    [box1, "pool"] call RPF_fnc_decayPool;
    ---

CBA Events:
	- RPF_altered
	> raised when pool is altered

	- RPF_decayed
	> raised upon successful execution of delayPool

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
		if (_renew != 2) exitWith {
			RPT_DTAIL(INFO,SJOIN3("Pool",_varName,"does not have decay enabled. Exiting Loop."," "),__FILE__,__LINE__);
		}; // if it aint renewable, BREAK THE CYCLE
		// otherwise, take the blue pill
		[_obj,_varName,(_rate # 0),SUB_CLAMP] call FUNC(alterPool);
		[E_DECAYED,[_obj,_varName,_rate],1] call FUNC(raiseEvent);
		[_obj,_varName] call FUNC(decayPool);
	},
	[
		// arguments to pass to the above
		_obj,
		_varName
	],
	_time // delay in seconds
] call CBA_fnc_waitAndExecute;