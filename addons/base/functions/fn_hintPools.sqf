#include "defines.hpp"
/*
use output of grabPools to hint a message that displays the pools currently on an object
*/

params [["_obj",objNull,[objNull]]];

private _result = _obj call FUNC(grabPools);

if (_result isEqualType false) exitWith {
	hint "Error. Invalid object or object not initialized as a resource pool.";
};

private _message = ["The current resource pools on " + str _obj + "are: "];

{
	_message pushBack _x # 0;
} forEach _result;

hint (_message joinString ", ");