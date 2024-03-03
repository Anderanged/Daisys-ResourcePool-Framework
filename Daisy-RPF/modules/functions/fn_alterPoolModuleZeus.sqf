#include "defines.hpp"
/*
Author: Daisy

Description:  	alters energy pool by the amount and method given

Params:
_obj		-	<OBJECT>	-	object called on
_varName	-	<STRING>	-	varName of pool to alter value of
_limits		-	<ARRAY>		-	array of bounds
							+	format [lowerBound, upperBound]
_rate		- 	<ARRAY>		-	array of values to alter pool with	
							+	format [amount, time]
_methodM	-	<NUMBER>	-	methodMath ; operation to perform	
							+	[0 = add (default), 1 = subtract, 2 = multiply, 3 = divide]
_methodA	-	<BOOLEAN>	-	methodAlter ; method of incrementation
							+	[false = chunk, true = smooth]
_methodO	-	<BOOLEAN>	-	methodOverflow ; method of handling overflow
							+	[false = clamp, true = reject]

Do I clamp values that are below the _bound? or reject the addition?
Since this only provides the framework, I think it falls to the modder to make that check.
But I see no reason why I shouldn't do it too.

alterPoolClamp		-	Clamps pool to bound if new value would cross the bound
alterPoolReject		-	Rejects operation if it would cross the bound

Returns: 
true on success, false on failure

Public: yes
*/
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

[_obj,_varName,_limits,_rate,[_methodM,_methodA,_methodO]] call FUNC(alterPool);