#include "defines.hpp"
params [
	["_obj",objNull,[objNull]],
	["_varName",QPVAR(pool),[""]]
];
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	private _message = ["Pool ",_varName," not initialized on ",str _obj] joinString "";
	RPT_DTAIL(ERROR,_message,__FILE__,__LINE__);
	true
};
// get hash
private _hash 	= missionNamespace getVariable QPVAR(resourcePools);
private _array 	= _hash get _obj;
private _index 	= _array find _varName;
if (_index == -1) exitWith {};
_obj setVariable [SUJOIN(_varName,"renew"), nil];
_obj setVariable [SUJOIN(_varName,"limits"), nil];
_obj setVariable [SUJOIN(_varName,"frozen"), nil];
_obj setVariable [_varName, nil];
// remove from array and update hashmap
_array deleteAt _index;
_hash set [_obj,_array];
missionNamespace setVariable [QPVAR(resourcePools),_hash];
