#include "defines.hpp"
if (isDedicated) exitWith {
	RPT_DTAIL(INFO,"Local functions will not execute on dedicated server.",__FILE__,__LINE__);
	[E_LOCSERV,[__FILE__],1] call FUNC(raiseEvent);
	false
};
params [
	["_obj",objNull,[objNull]],
	["_varName",QPVAR(pool),[""]]
];
// is pool init'd
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	RPT_DTAIL(ERROR,SJOIN4("Pool ",_varName," not initialized on ",str _obj,""),__FILE__,__LINE__);
	false
};
// get hash & check
private _array 	= [_obj,"r"] call FUNC(accessHash);
if (_array isEqualType false) exitWith {
	RPT_DTAIL(ERROR,SJOIN3("Object ",str _obj," has no pools initialized.",""),__FILE__,__LINE__);
	false
};
// find variable pool
private _index 	= _array find _varName;
if (_index == -1) exitWith {
	RPT_DTAIL(ERROR,SJOIN4("Hashmap does not have variable ",_varName," assigned to ",str _obj,""),__FILE__,__LINE__);
	false
};
// remove vars
_obj setVariable [SUJOIN(_varName,"limit"),    nil];
_obj setVariable [SUJOIN(_varName,"frozen"),   nil];
_obj setVariable [SUJOIN(_varName,"poolInit"), nil];
_obj setVariable [SUJOIN(_varName,"RD_Array"), nil];
_obj setVariable [_varName, nil];
// broadcast event
[E_REMOVED,[_obj,_varName],0] call FUNC(raiseEvent);
// update hashmap with new array
_array deleteAt _index;
[_obj,"w",_array] call FUNC(accessHash);
RPT_BASIC(INFO,SJOIN5("Object",str _obj,"has had resource pool",_varName,"manually removed."," "));
true