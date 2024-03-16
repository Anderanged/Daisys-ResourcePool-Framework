#include "defines.hpp"
/*
take in obj, varname, and pass code to execute using CBA_fnc_waitAndExecute.
recusively executes until Renew/Decay status changes.
*/

params [
	["_obj",objNull,[objNull]],
	["_varName",QPVAR(pool),[""]]
];

private _array = _obj getVariable SUJOIN(_varName,"RD_Array"); // grab vars
_array params [
	"_renew",
	"_rate"
];

[
	{
		// to be ex
		params ["_obj","_varName","_renew","_rate"];
		if (_renew != 2) exitWith {
			RPT_DTAIL(INFO,SJOIN3("Pool",_varName,"does not have decay enabled. Exiting Loop."," "),__FILE__,__LINE__);
		}; // if it aint renewable, BREAK THE CYCLE
		// otherwise, take the blue pill
		[_obj,_varName,(_rate # 0),SUB_CLAMP] call FUNC(alterPool);
		[_obj,_varName,_rate] call FUNC(decayPool);
	},
	[
		// arguments to pass to the above
		_obj,
		_varName
	],
	_rate # 1 // delay in seconds
] call CBA_fnc_waitAndExecute;