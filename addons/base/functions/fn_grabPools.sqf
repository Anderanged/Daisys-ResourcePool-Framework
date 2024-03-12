#include "defines.hpp"
/*
grabs all pools on a obj, and all variables related to pools and puts into an array that can be viewed
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
if (isNil _array) exitWith {};
{
	private _arr = [];
	_arr pushBack _obj getVariable [SUJOIN(_x,"limits"), nil];
	_arr pushBack _obj getVariable [SUJOIN(_x,"frozen"), nil];
	_arr pushBack _obj getVariable [SUJOIN(_x,"renew"), nil];
	_result pushBack [_x,_arr];
} forEach _array;
// return result
_result