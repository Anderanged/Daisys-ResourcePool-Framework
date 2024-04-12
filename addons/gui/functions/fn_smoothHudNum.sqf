#include "defines.hpp"
/*
Calls alterpool once, then smoothly interates the starting value to the final value over a set timeframe.
*/
private _obj = _this param [0,objNull,[objNull]];

// check obj
if (_obj == objNull) exitWith {
	RPT_DTAIL(ERROR,SJOIN("Invalid object specified: ",str _obj,""),__FILE__,__LINE__);
	false
};

private _varName = _this param [1,"",[""]];
// was pool init'd?
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	RPT_DTAIL(ERROR,SJOIN4("Pool ",_varName," not initialized on ",str _obj,""),__FILE__,__LINE__);
	false
};

// is pool frozen?
private _ice = _obj getVariable SUJOIN(_varName,"frozen");
if (_ice) exitWith { // if so:
	RPT_DTAIL(INFO,SJOIN5("Pool ",_varName," on object ",str _obj," is frozen. Smoothing not performed.",""),__FILE__,__LINE__);
	[E_ONICE,[_obj,_varName],1] call FUNC(raiseEvent);
	false
};

params [
	["_obj",objNull,[objNull]], 		// default objNull
	["_varName","",[""]], 		// default DSY_rpf_pool
	["_rate",[],[[]],2],				// default [10,1]
	["_methods",ADD_CLAMP,[[]],2],
	["_guiID",[],[[]]]
];
_rate params [
	["_amount",2,[0]],
	["_time",1,[0]]
];
_amount 	= floor (abs _amount);
_time 		= ceil (abs _time);
_guiID params [
	["_titleClass","",[""]], // accepts num or str.
	["_controlID",-1,[0]]
];
private _methodM = _methods param [0, false, [false,""]];
if (_methodM isEqualType "") then {
	switch _methodM do {
		case "s" : {_methodM = true;};
		case "a" : {_methodM = false;};
		default {
			if true exitWith {
				// add debug error
				RPT_DTAIL(ERROR,SJOIN("Invalid math operation given:",_methodM," "),__FILE__,__LINE__);
			};
		};
	};
};
private _cVal 	= _obj getVariable _varName;
private _result 	= [_obj,_varName,_amount,_methods] call FUNC(alterPool);
if (_result isEqualType false) exitWith {// if alteration failed
	RPT_DTAIL(ERROR,"Attempted alteration failed. Function not executed.",__FILE__,__LINE__);
	false
}; 
// otherwise
private _delay 	= _time / _amount;
private _args	= [0, _titleClass, _controlID, _cVal, _amount, _delay];


if _methodM then { // subtraction
	_args spawn {
		_this params ["_i","_titleClass","_controlID","_cVal","_diff","_delay"];
		while {_i < _diff} do {
			_i = _i + 1;
			((uiNamespace getVariable _titleClass) displayCtrl _controlID) ctrlSetText (str (_cVal - _i));
			sleep _delay;
		};
	};
} else {
	// addition
	_args spawn {
		_this params ["_i","_titleClass","_controlID","_cVal","_diff","_delay"];
		while {_i < _diff} do {
			_i = _i + 1;
			((uiNamespace getVariable _titleClass) displayCtrl _controlID) ctrlSetText (str (_cVal - _i));
			sleep _delay;
		};
	};
};