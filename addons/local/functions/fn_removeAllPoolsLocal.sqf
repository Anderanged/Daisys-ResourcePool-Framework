#include "defines.hpp"
if (isDedicated) exitWith {
	RPT_DTAIL(INFO,"Local functions will not execute on dedicated server.",__FILE__,__LINE__);
	[E_LOCSERV,[__FILE__],1] call FUNC(raiseEvent);
	false
};
params [
	["_obj",objNull,[objNull]]
];
if (_obj == objNull) exitWith {
	RPT_DTAIL(ERROR,SJOIN("Invalid object specified: ",str _obj,""),__FILE__,__LINE__);
	false
};
// is obj local?
if !(local _obj) exitWith {
	RPT_DTAIL(ERROR,SJOIN3("Object",str _obj,"is not local to the current machine. Aborting local function."," "),__FILE__,__LINE__);
	false
};
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
[E_REMOVEDA,[_obj],0] call FUNC(raiseEvent);
RPT_BASIC(INFO,SJOIN3("Object",str _obj,"has had all resource pools removed."," "));
// remove from and update hashmap
[_obj,"d"] call FUNC(accessHash);
true