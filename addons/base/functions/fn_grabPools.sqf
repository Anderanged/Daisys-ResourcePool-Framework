#include "defines.hpp"
/*
grabs all pools on a obj, and all variables related to pools and puts into an array that can be viewed.
not a pretty output, but it is useable.
*/

params [["_obj",objNull,[objNull]]];

// check obj
if (_obj == objNull) exitWith {
	//RPT_DTAIL(ERROR,"Invalid object specified: "+str _obj,__FILE__,__LINE__);
	false
};

private _result = [];
// grab hash
private _hash = missionNamespace getVariable QPVAR(resourcePools);
private _array = _hash get str _obj;
// not initialized lmao
if (isNil _array) exitWith {
	false
};

{
	private _varArray = [];
	_varArray pushBack _obj getVariable [SUJOIN(_x,"limits"), nil];
	_varArray pushBack _obj getVariable [SUJOIN(_x,"renew"), nil];
	_varArray pushBack _obj getVariable [SUJOIN(_x,"frozen"), nil];
	_result pushBack [_x,_varArray];
} forEach _array;
// return result
_result