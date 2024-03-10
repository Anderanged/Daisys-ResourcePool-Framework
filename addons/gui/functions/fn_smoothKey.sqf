#include "defines.hpp"
disableSerialization;
/*
Needs to track the total amount increased/decreased to make the call
good thing we can just iterate!
*/
params [
	["_obj",objNull,[objNull]], 		// default objNull
	["_varName",QPVAR(pool),[""]], 		// default DSY_rpf_pool
	["_rate",[10,1],[[]]],				// default [10,1]
	["_methods",[false,false],[[]]],
	["_guiID",[-1,-1],[[]]]
];
_rate params [
	["_amount",2,[0]],
	["_time",1,[0]]
];

private _methodM = _methods param [0, false, [false]];

//grab current supply and check if pool initialized
private _cVal 		= _obj getVariable [_varName,true];
if _cVal exitWith {}; // if obj not initialized

// grab limits
private _limits 	= _obj getVariable SUJOIN(_varName,"limits");
private _bound		= _limits param [1,RPFLIM_MAX,[0]];
if _methodM then {_bound = _limits param [0,0,[0]];};

// calc delay
private _delay 		= (_time) / (_amount);
private _spawnArgs	= [_obj,_varName,_delay,_cVal,_bound,_guiID,_methods];
// while loop
private _handle = _spawnArgs spawn {
	params ["_obj","_varName","_delay","_cVal","_bound","_guiID","_methods"];
	_guiID params [
		["_displayID",-1,[0,""]], // accepts num or str.
		["_controlID",-1,[0]],
		["_isRsc",false,[false]]
	];
	private _display = _displayID; // assumes Rsc, so assumes u used global variable
	if !_isRsc then {
		_display = findDisplay _displayID;
	};
	private _i = 0;
	private _result = _cVal;
	if (_methods # 0) exitWith { // subtraction
		while {_result != _bound} do {
			(_display displayCtrl _controlID) ctrlSetText str _result;
			_i = _i + 1;
			_result = _result - 1;
			sleep _delay;
		};
		[_obj,_varName,_i,_methods] call FUNC(alterPool);
	};
	while {_result != _bound} do { //addition
		(_display displayCtrl _controlID) ctrlSetText str _result;
		_i = _i + 1;
		_result = _result + 1;
		sleep _delay;
	};
	[_obj,_varName,_i,_methods] call FUNC(alterPool);
};

player setVariable [QPVAR(smoothKeyHandle),_handle];

