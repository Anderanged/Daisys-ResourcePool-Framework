#include "defines.hpp"
/*
Author: Daisy

Description:  	initializes energy pool from options given.

options:

object to initialize on
pool max
pool min
recharge rate
recharge method
condition to kill recharge loop
condition to stop recharging


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

Public: yes
*/
params ["_obj", "_limits", "_rate", "_method", "_loopCon", "_contCon"];

//prelim checks for optional vars (rate onwards)