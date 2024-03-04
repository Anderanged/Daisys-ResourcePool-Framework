#include "\defines.hpp"
/*
Author: Daisy

Description:  	alters energy pool by the amount and method given

Params:
_obj		-	<OBJECT>	-	object called on
_varName	-	<STRING>	-	varName of pool to alter value of _limits		-	<ARRAY>		-	array of bounds
							+	format [lowerBound, upperBound]
_rate		- 	<ARRAY>		-	array of values to alter pool with	
							+	format [amount, time (seconds)]
_method		- 	<ARRAY>		-	array of methods
							+	format [_methodM,_methodA,_methodO]								
	_methodM	-	<NUMBER>	-	methodMath ; operation to perform	
								+	[0 = add (default), 1 = subtract, 2 = multiply, 3 = divide]
	_methodA	-	<BOOLEAN>	-	methodAlter ; method of incrementation
								+	[false = chunk, true = smooth]
	_methodO	-	<BOOLEAN>	-	methodOverflow ; method of handling overflow
								+	[false = clamp, true = reject]

Do I clamp values that are below the _bound? or reject the addition?
Since this only provides the framework, I think it falls to the modder to make that check.
But I see no reason why I shouldn't do it too.

alterPoolClamp		-	Clamps pool to bound if new value would cross the bound
alterPoolReject		-	Rejects operation if it would cross the bound

Returns: 
true on success, false on failure

Public: yes
*/
params [
	["_obj",objNull,[objNull]], 		// default objNull
	["_varName",QPVAR(pool),[""]], 		// default DSY_rpf_pool
	["_rate",[10,1],[[]]],				// default [10,1]
	["_methods",[0,false,false],[[]]]
];
/*_rate params [
	["_amnt",2,[0]],
	["_time",1,[0]]
];*/
_methods params [	
	["_methodM",0,[0]],				// default add
	["_methodA",false,[false]],		// default chunk
	["_methodO",false,[false]]		// default clamp
];
//check varname
if (_obj == objNull) exitWith {
	RPTDEBUG(__FILE__,__LINE__,"ERROR","Invalid object specified: "+str _obj);
	false;
};

//grab vars
private _cVal 		= _obj getVariable _varName;
private _limits 	= _obj getVariable QUJOIN(_varName,"limits");

//predefine and compile vars
private _amnt 		= _rate # 0;
private _amntAbs	= _amnt;
private _time 		= _rate # 1;
private _eParam		= [_obj,_varName, _limits,_rate,_cVal,_methods];
private _loopCon 	= compile LOOPCON_C;

// check for smooth
if (_methodA) then {
	_amnt = 1;
	_time = (_rate # 1) / (_rate # 0);
	// clamp sleep to smallest value
	if (_time < 0.001) then {_time = 0.001;};
	_loopCon = compile LOOPCON_S;
};

// predefine arguments to pass to loop in handleG & handleL functions
private _loopArgs = [
	_obj,
	_time,
	[_varName,_amnt,_amntAbs],
	_loopCon,
	{ // continue condition
		false
	},
	{ // event
		params[["_obj",objNull,[objNull]],["_args",[],[[]]]];
		_obj setVariable [_args # 0, _args # 1];
	},
	[QPVAR(alter),_eParam]
];

switch (_methodM) do { // check math operation
	case 0 : { // addition
		// bound, cval, nval, total, loopArgs, methodO, eParam
		[(_limits # 1), _cVal, (_cVal + _amntAbs), _loopArgs, _methodO, _eParam] call FUNC(handleGreater);
	};
	case 1 : { // subtraction
		[(_limits # 0), _cVal, (_cVal - _amntAbs), _loopArgs, _methodO, _eParam] call FUNC(handleLess);
	};
	case 2 : { // multiplication
		[(_limits # 1), _cVal, (_cVal * _amntAbs), _loopArgs, _methodO, _eParam] call FUNC(handleGreater);
	};
	case 3 : { // division
		[(_limits # 0), _cVal, (_cVal / _amntAbs), _loopArgs, _methodO, _eParam] call FUNC(handleLess);
	};
	default	 {
		private _message = "Invalid math method: "+str _methodM;
		RPTDEBUG(__FILE__,__LINE__,"ERROR",_message;
		[QPVAR(error),[__FILE__,__LINE__,"ERROR",_message],1] call FUNC(raiseEvent);};
};
true;