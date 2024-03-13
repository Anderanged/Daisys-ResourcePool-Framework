#include "defines.hpp"
params [
	["_obj",objNull,[objNull]]
];
private _key = str _obj;
private _hash = missionNamespace getVariable QPVAR(resourcePools);
private _array = _hash get _key;
if (isNil _array) exitWith {false};
{// remove all vars related to being a pool
	_obj setVariable [SUJOIN(_x,"renew"), nil];
	_obj setVariable [SUJOIN(_x,"limits"), nil];
	_obj setVariable [SUJOIN(_x,"frozen"), nil];
	_obj setVariable [SUJOIN(_x,"poolInit"), nil];
	_obj setVariable [_x, nil];
} forEach _array;
// event
[QPVAR(wiped),[_obj],0] call FUNC(raiseEvent);
// remove from and update hashmap
_hash deleteAt _key;
missionNamespace setVariable [QPVAR(resourcePools),_hash];
true