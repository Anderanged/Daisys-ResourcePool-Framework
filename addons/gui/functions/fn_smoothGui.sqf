#include "defines.hpp"
/*
Can call once, then call a gui function to smooth the numbers down.
*/

params [
	["_obj",objNull,[objNull]], 		// default objNull
	["_varName",QPVAR(pool),[""]], 		// default DSY_rpf_pool
	["_rate",[10,1],[[]]],				// default [10,1]
	["_methods",[false,false],[[]]],
	["_controlID",-1,[0]]
];
_rate params [
	["_amount",2,[0]],
	["_time",1,[0]]
];
private _methodM = _methods param [0, false, [false]];

private _cVal 		= _obj getVariable _varName;
private _result 	= [_obj,_varName,_amount,_methods] call FUNC(alterPool);
if (_result) exitWith {}; // if alteration failed
// otherwise
private _delay 		= (_time) / (_amount);
private _diff		= abs (_cVal - _result);
private _i = 1;

private _args		= [_i,_controlID,_cVal,_diff];
if _methodM exitWith { // subtraction
	_total = _cVal - _result;
	_args spawn {
		params ["_i","_controlID","_cVal","_diff"];
		while {_i < _diff} do {
			_controlID ctrlSetText str (_cVal - _i);
			_i = _i + 1;
			sleep 0.01;
		};
	};
};
// addition
_args spawn {
	params ["_i","_controlID","_cVal","_diff"];
	while {_i < _diff} do {
		_controlID ctrlSetText str (_cVal + _i);
		_i = _i + 1;
		sleep 0.01;
	};
};