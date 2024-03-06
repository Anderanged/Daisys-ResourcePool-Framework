#include "defines.hpp"

params [
	["_logic", objNull, [objNull]],		// Argument 0 is module logic
	["_units ", [], [[]]],				// Argument 1 is a list of affected units (affected by value selected in the 'class Units' argument))
	["_activated", true, [true]]		// True when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
];

private _obj 		= _logic getVariable "Object";
private _varName 	= _logic getVariable "VarName";
private _limits 	= _logic getVariable "Limits";
private _rate 		= _logic getVariable "Rate";
private _methodM 	= _logic getVariable "MethodM";
private _methodA 	= _logic getVariable "MethodA";
private _methodO 	= _logic getVariable "MethodO";

