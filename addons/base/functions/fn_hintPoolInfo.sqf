#include "defines.hpp"
/*
use output of grabPools to hint a message that displays the given pool's values.
*/

params [
	["_obj",objNull,[objNull]], 		
	["_varName",QPVAR(pool),[""]]
];

private _result = _obj call FUNC(grabPools);

if (_result isEqualType false) exitWith {
	hint "Error. Invalid object or object not initialized as a resource pool.";
};

private _nameArray = [];
{
	_nameArray pushBack _x # 0;
} forEach _result;

private _index = _nameArray find _varName;
if (_index == -1) exitWith {
	hint (["Error. Resource pool with name ",_varName," does not exist on object ",str _obj] joinString "");
};

private _preMsg		= [_varName,"'s current variables are: "]
private _message 	= [];

// order is [varName STR, [limit array, renew array, isFrozen]]
_x params 			["_varName","_varArray"];
_varArray params 	["_limits","_renew","_onIce"];
_limits params 		["_lbound","_ubound"];
_renew params 		["_selection","_rate"];
_rate params 		["_amount","_time"];
