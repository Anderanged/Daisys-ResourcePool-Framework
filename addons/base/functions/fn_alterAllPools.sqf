#include "defines.hpp"
params [
	["_obj",objNull,[objNull]],
	["_amount",0,[0]],
	["_methods",ADD_CLAMP,[[]],2]
];
// grab from hash
private _array = [_obj,"r"] call FUNC(accessHash);
// abort if nothing in hash
if (_array isEqualType false) exitWith {
	RPT_BASIC(INFO,SJOIN3("Object",str _obj,"has no resource pools on it. Aborting alteration.",""));
	false
};
{// remove all vars related to being a pool
	[_obj,_x,_amount,_methods] call FUNC(alterPool);
} forEach _array;
// event
[QPVAR(alterAll),[_obj],0] call FUNC(raiseEvent);
RPT_BASIC(INFO,SJOIN5("Object",str _obj,"has had all resource pools altered by amount",str (abs floor _amount),"."," "));
true