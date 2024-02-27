#include "defines.hpp"
/*
Author: Daisy

Description:  alters the energy pool with a given delay and specified operators.

Params:
_obj		-	object called on
_limits 	-	array in format [lower bound, upper bound]
				the lowest or highest 
_method		-	number method of altering
				[0 = add (default), 1 = subtract, 2 = multiply, 3 = divide]
_rate		-	array in format [amount, time (seconds)]
_loopCon	-	code in format {conditions to evaluate here} 
				loop will exit if condition returns false.
_contCon	- 	code in format {conditions to evaluate here} 
				loop will alter energy if condition returns false.


Returns: 
N/A

Public: yes
*/
params ["_obj", "_limits", "_rate", "_method", "_loopCon", "_contCon"];

private _bound = 0;

// check to make sure no errors in method
switch (_method) do {
	case (_method < 2): {_bound = _limits # 1;};
	case (_method > 1): {_bound = _limits # 0;};
	default				{
		exitWith {
			RPTDEBUG(__FILE__,__LINE__,"ERROR","Unknown method of "+str _method);
			};
		};
};

// grab rate vars
private _amnt 	= _rate # 0;
private _time	= _rate # 1;

// spawn so we can use sleep
[_obj,_bound,_amnt,_time,_method,_loopCon,_contCon] spawn {
	params ["_obj","_bound","_method","_amnt","_time","_loopCon","_contCon"];

	while {_loopCon} do {
		// wait time
		sleep _time;
		// if not cont, alter
		if (_contCon) then {continue;};
		// call to alter energy
		[_obj, _bound, _amnt, _method] call FUNC(alterEnergy);
	};
};