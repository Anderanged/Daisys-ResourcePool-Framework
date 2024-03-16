#include "defines.hpp"
params [
	["_obj",objNull,[objNull]]
];

private _array = [_obj,"r"] call FUNC(accessHash);
if (_array isEqualType false) exitWith {
	RPT_BASIC(INFO,SJOIN3("Object",str _obj,"has no resource pools on it. Aborting removal.",""));
	false
};
{// remove all vars related to being a pool
	_obj setVariable [SUJOIN(_x,"limit"),    nil];
	_obj setVariable [SUJOIN(_x,"frozen"),   nil];
	_obj setVariable [SUJOIN(_x,"poolInit"), nil];
	_obj setVariable [SUJOIN(_x,"RD_Array"), nil];
	_obj setVariable [_x, nil];
} forEach _array;
// event
[QPVAR(removeAll),[_obj],0] call FUNC(raiseEvent);
RPT_BASIC(INFO,SJOIN3("Object",str _obj,"has had all resource pools removed."," "));
// remove from and update hashmap
[_obj,"d"] call FUNC(accessHash);
true