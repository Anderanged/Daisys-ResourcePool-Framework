#include "defines.hpp"
/*
take in obj, varname, and pass code to execute using CBA_fnc_waitAndExecute.
recusively executes until Renew/Decay status changes.
*/
if (isDedicated) exitWith {
	RPT_DTAIL(INFO,"Local functions will not execute on dedicated server.",__FILE__,__LINE__);
	[E_LOCSERV,[__FILE__],1] call FUNC(raiseEvent);
	false
};
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
		
		if (_renew != 1) exitWith {
			RPT_DTAIL(INFO,SJOIN3("Pool",_varName,"does not have renew enabled. Exiting Loop."," "),__FILE__,__LINE__);
		}; // if it aint renewable, BREAK THE CYCLE
		// otherwise, take the blue pill
		[_obj,_varName,(_rate # 0),ADD_CLAMP] call FUNC(alterPoolLocal);
		[E_RENEWED,[_obj,_varName,_rate],0] call FUNC(raiseEvent);
		[_obj,_varName] call FUNC(renewPoolLocal);
	},
	[
		// arguments to pass to the above
		_obj,
		_varName,
		_renew,
		_rate
	],
	_rate # 1 // delay in seconds
] call CBA_fnc_waitAndExecute;
true