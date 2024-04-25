#include "defines.hpp"
/*
need to be able to read and write from hashmap. 

should take object as key and return:
	varNames on success, false on failure of read
	true on success of write
*/

params [
	["_obj",objNull,[objNull]],
	["_access","",[""]],
	["_data",[],[[]]]
];

if (_access == "") then {_access = "r";};

// variable def
private ["_hash","_key","_return","_varArray","_msg"];
_hash 	= missionNamespace getVariable QPVAR(resourcePools);
_key 	= str _obj;

// cases of access
switch _access do {
	case "r" : { // read
		_return = _hash getOrDefault [_key,false];
	};
	case "w" : { // write
		_hash set [_key,_data,false];
		missionNamespace setVariable [QPVAR(resourcePools),_hash,true];
		_return = true;
	};
	case "a" : { // append
		// first check if present already
		_varArray = _hash getOrDefault [_key,false];
		// if not, then write
		if (_varArray isEqualType false) exitWith {
			_hash set [_key,_data,false];
			missionNamespace setVariable [QPVAR(resourcePools),_hash,true];
			RPT_DTAIL("Info: Hashmap had no key to append to. Data written.",__FILE__,__LINE__);
			true
		};
		private _check = false;
		// otherwise, do pushBackUnique for each element in _data
		{
			private _index = _varArray pushBackUnique _x;
			if (_index != -1) exitWith {_check = true;} // exit as soon as we know there is a new element
		} forEach _data;
		if (_check) then {
			// append data if there was a new element
			_hash set [_key,_varArray];
			missionNamespace setVariable [QPVAR(resourcePools),_hash,true];
			_return = true;
		} else {
			_msg = format ["Error: Append failed, no new values found in data (%1).",_data];
		RPT_DTAIL(_msg,__FILE__,__LINE__);
		// otherwise return false. no data appended.
		_return = false;
		};
	};
	case "d" : {
		_hash deleteAt _key;
		missionNamespace setVariable [QPVAR(resourcePools),_hash,true];
		_return = true;
	};
	default {
		_msg = format ["Error: Invalid argument for hash access: %1",_access];
		RPT_DTAIL(_msg,__FILE__,__LINE__);
		_return = false;
	};
};

_return