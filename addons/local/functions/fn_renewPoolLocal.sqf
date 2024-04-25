#include "defines.hpp"
/*
take in obj, varname, and pass code to execute using CBA_fnc_waitAndExecute.
recusively executes until Renew/Decay status changes.
*/
if (isDedicated) exitWith {
	RPT_DTAIL("Error: Local functions will not execute on dedicated server.",__FILE__,__LINE__);
	[E_LOCSERV,[__FILE__],1] call FUNC(raiseEvent);
	false
};
params [
	["_obj",objNull,[objNull]],
	["_varName","",[""]]
];
// is obj local?
if (isNull _obj) exitWith {
	_msg = format ["Error: Invalid object (%1) specified. Objects may not be of type null.",_obj];
	RPT_DTAIL(_msg,__FILE__,__LINE__);
	false
};
if !(local _obj) exitWith {
	_msg = format ["Error: Object (%1) is not local to the current machine. Aborting local function."];
	RPT_DTAIL(_msg,__FILE__,__LINE__);
	false
};
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
			[E_RENEWSTOP,[_obj,_varName,_rate],0] call FUNC(raiseEvent);
		}; // if it aint renewable, BREAK THE CYCLE
		// otherwise, take the blue pill
		[_obj,_varName,(_rate # 0),ADD_CLAMP] call FUNC(alterPoolLocal);
		[E_RENEWED,[_obj,_varName,_rate],0] call FUNC(raiseEvent);
		[_obj,_varName] call FUNC(renewPoolLocal);
	},
	[
		// arguments to pass to the above
		_obj,
		_varName
	],
	_time // delay in seconds
] call CBA_fnc_waitAndExecute;
true