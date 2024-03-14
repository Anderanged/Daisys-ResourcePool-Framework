#include "defines.hpp"
/*
need to be able to read and write from hashmap. 

should take object as key and return:
	varNames on success, false on failure of read
	true on success of write
*/

params [
	["_obj",objNull,[objNull]],
	["_access","r",[""]],
	["_data",[],[[]]]
];

// variable def
private ["_hash","_key","_return","_varArray","_check"];
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
			RPT_DTAIL(INFO,"Hashmap had no key to append to. Data written.",__FILE__,__LINE__);
			true
		};
		private _chkArr = [];
		// otherwise, do pushBackUnique for each element in _data
		{
			private _index = _varArray pushBackUnique _x;
			_chkArr append _index;
		} forEach _data;
		if (_chkArr findIf {_x > -1} != -1) exitWith {
			// immediately append data if find a new element
			_hash set [_key,_varArray];
			missionNamespace setVariable [QPVAR(resourcePools),_hash,true];
			true
		};
		RPT_DTAIL(INFO,SJOIN3("No new values found in ",str _data,". Append failed.",""),__FILE__,__LINE__);
		// otherwise return false. no data appended.
		_return = false;
	};
	case "d" : {
		_hash deleteAt _key;
		missionNamespace setVariable [QPVAR(resourcePools),_hash,true];
		_return = true;
	};
	default {
		RPT_DTAIL(ERROR,SJOIN("Invalid argument for hash access: ",_access,""),__FILE__,__LINE__);
		_return = false;
	};
};

_return