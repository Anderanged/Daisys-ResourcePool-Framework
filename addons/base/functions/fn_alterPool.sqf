#include "defines.hpp"
/*
Author: Daisy

Description:  	alters energy pool by the amount and method given

Params:
_obj 
_varName
_amount
_methods

Returns: 
true on failure, resulting number on success

Public: yes
*/

params [
	["_obj",objNull,[objNull]], 		// default objNull
	["_varName",QPVAR(pool),[""]], 		// default DSY_rpf_pool
	["_amount",0,[0]],				// default [10,1]
	["_methods",[false,false],[[]],2]
];
_methods params [	
	["_methodM",false,[false]],				// default add
	["_methodO",false,[false]]				// default clamp
];

_amount = abs (floor _amount);

// check obj
if (_obj == objNull) exitWith {
	RPT_DTAIL(ERROR,SJOIN("Invalid object specified: ",str _obj,""),__FILE__,__LINE__);
	false
};

// was pool init'd?
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	RPT_DTAIL(ERROR,SJOIN4("Pool ",_varName," not initialized on ",str _obj,""),__FILE__,__LINE__);
	false
};

// is pool frozen?
private _ice = _obj getVariable SUJOIN(_varName,"frozen");
if (_ice) exitWith { // if so:
	RPT_DTAIL(INFO,SJOIN5("Pool ",_varName," on object ",str _obj," is frozen. Alteration not performed.",""),__FILE__,__LINE__);
	[QPVAR(onIce),[_obj,_varName,_amount,_methods],1] call FUNC(raiseEvent);
	false
};

// grab and predef vars
private _cVal 		= _obj getVariable _varName;
private _limit 		= _obj getVariable SUJOIN(_varName,"limit");
private _eParams 	= [_obj,_varName,_amount,_methods];
private "_result";

// start chunk func
// if subtraction
if (_methodM) exitWith {
	// call func
	_result = [0,_cVal,_cVal - _amount,_methodO,_eParams] call FUNC(handleLess);
	// if rejected and no alteration need be done, exit and return true
	if (_result isEqualType false) exitWith {false};
	// otherwise change var
	_obj setVariable [_varName,_result];
	[QPVAR(alter),_eParams,0] call FUNC(raiseEvent);
	// return result
	_result
};
// else addition
_result = [_limit,_cVal,_cVal + _amount,_methodO,_eParams] call FUNC(handleGreater);
if (_result isEqualType false) exitWith {false};
_obj setVariable [_varName,_result];
[QPVAR(alter),_eParams,0] call FUNC(raiseEvent);
_result