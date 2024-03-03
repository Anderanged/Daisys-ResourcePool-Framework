#include "defines.hpp"
/*
Author: Daisy

Description:  	initializes energy pool from options given.

options:

object to initialize on
pool max
pool min
if renewable 
recharge rate
recharge methods
[methodM,methodA,methodO]


Params:


Returns: 
nothing

Public: yes
*/
params [
	["_obj",objNull,[objNull]],
	["_limits",[0,RPFLIM_MAX],[[]]], 
	["_renew",true,[true]],
	["_rate",[2,1],[[]]], 
	["_methods",[0,true,true],[[]]]
];

// set local variables
_obj setVariable [QPVAR(limits),_limits];

// if is renewable
if (_renew) then {
	_obj setVariable [QPVAR(rate),_rate];
	_obj setVariable [QPVAR(methods),_methods];
	// need a function that can be called here to take these 4 args
	// creates a loop on the pool that renews it by _amnt every _delay
	[_obj,_limits,_rate,_methods] call FUNC(renewPool);
};