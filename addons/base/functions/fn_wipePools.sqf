#include "defines.hpp"
params [
	["_obj",objNull,[objNull]]
];
private _hash = missionNamespace getVariable QPVAR(resourcePools);
private _array = _hash getOrDefault [_obj,true];
if _array exitWith {};
{// remove all vars related to being a pool
	_obj setVariable [SUJOIN(_x,"renew"), nil];
	_obj setVariable [SUJOIN(_x,"limits"), nil];
	_obj setVariable [SUJOIN(_x,"frozen"), nil];
	_obj setVariable [SUJOIN(_x,"poolInit"), nil];
	_obj setVariable [_x, nil];
} forEach _array;
// remove from and update hashmap
_hash deleteAt _obj;
missionNamespace setVariable [QPVAR(resourcePools),_hash];