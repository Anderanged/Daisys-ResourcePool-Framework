#include "defines.hpp"
/*
Author: Daisy

Description:  	alters energy pool by the amount and method given

Params:
_obj 
_varName
_amount
_methods

- alterPool
    - alters resource in a chunk.
        - args
            - object to change pool on <OBJ>
            - pool name <STR>
            - amount <NUM>
            - methods to use <ARRAY>
                - [method Math, method Overflow]
                    - methodMath <BOOL>
                        - addition    = false
                        - subtraction = true
                    - methodOverflow <BOOL>
                        - clamp     = false
                        - reject    = true

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

// check obj
if (_obj == objNull) exitWith {
	RPT_DTAIL(ERROR,"Invalid object specified: "+str _obj,__FILE__,__LINE__);
	true
};

// was pool init'd?
if !(_obj getVariable [SUJOIN(_varName,"poolInit"),false]) exitWith { // if not:
	private _message = ["Pool ",_varName," not initialized on ",str _obj] joinString "";
	RPT_DTAIL(ERROR,_message,__FILE__,__LINE__);
	true
};

// is pool frozen?
private _ice = _obj getVariable SUJOIN(_varName,"frozen");
if (_ice) exitWith { // if so:
	private _message = ["Pool ",_varName," on object ",str _obj," is frozen. Alteration not performed."] joinString "";
	RPT_DTAIL(INFO,_message,__FILE__,__LINE__);
	[QPVAR(onIce),[_obj,_varName,_amount,_methods],1] call FUNC(raiseEvent);
	true
};

// grab and predef vars
private _cVal 		= _obj getVariable [_varName,true];
private _limits 	= _obj getVariable SUJOIN(_varName,"limits");
private _eParams = [_obj,_varName,_amount,_methods];
_limits params ["_lBound","_uBound"];
private "_result";

// start chunk func
// if subtraction
if (_methodM) exitWith {
	// call func
	_result = [_lBound,_cVal,_cVal - _amount,_methodO,_eParams] call FUNC(handleLess);
	// if rejected and no alteration need be done, exit and return true
	if _result exitWith {true};
	// otherwise change var
	_obj setVariable [_varName,_result];
	[QPVAR(alter),_eParams,0] call FUNC(raiseEvent);
	// return result
	_result
};
// else addition
_result = [_uBound,_cVal,_cVal + _amount,_methodO,_eParams] call FUNC(handleGreater);
if _result exitWith {true};
_obj setVariable [_varName,_result];
[QPVAR(alter),_eParams,0] call FUNC(raiseEvent);
_result