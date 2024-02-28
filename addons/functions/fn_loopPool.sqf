#include "defines.hpp"
/*
Author: Daisy

Description:  	executes given code on an object with a given delay. 
				options given to repeat and/or skip execution with given expressions.

Params:
_obj		-	object called on
_delay		-	number in seconds to sleep
_loopCon	-	code in format {conditions to evaluate here} 
				loop will exit if condition returns false.
_contCon	- 	code in format {conditions to evaluate here} 
				loop will run given event code if condition returns false.
_event		-	code in format {expression to execute here}
				loop will execute this code when _contCon == false
_ehInfo		-	array in format [name, [param1,param2]] where [param1,param2] should be taken from _event code block to be passed to ehHandler
				custom event handler broadcast locally whenever event is executed.
				leave blank / do not include to disable event execution EH funcitonality. 
				(recommended for events occurring more than once per second.)

Returns: 
N/A

Public: yes
*/
params ["_obj", "_delay", "_loopCon", "_contCon", "_event", "_ehInfo"];

//clamp delay to 1 frame
if (_delay < 0.001) then {_delay = 0.001;};

private _ehBool = false;
if !(isNull _ehInfo) then {_ehBool = true;_ehInfo = _ehInfo append 0;};

// eh for while loop begin
[QPVAR(loopBegin),[_obj,_delay,_loopCon,_contCon,_event,_ehInfo],0] call FUNC(raiseEvent);

// spawn so we can use sleep
[_obj,_delay,_loopCon,_contCon,_event,_ehBool,_ehInfo] spawn {
	params ["_obj","_delay","_loopCon","_contCon","_event","_ehBool","_ehInfo"];
	while {_loopCon} do {
		// wait time
		sleep _delay;
		// if not cont, event
		if (_contCon) then {continue;};
		// execute event and raise event if defined
		_event;
		if (_ehBool) then {_ehInfo call FUNC(raiseEvent);};
	};
};

// eh for while loop exit
[QPVAR(loopEnd),[_obj,_delay,_loopCon,_contCon,_event,_ehInfo],0] call FUNC(raiseEvent);