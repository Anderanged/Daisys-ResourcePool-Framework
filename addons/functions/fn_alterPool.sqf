#include "defines.hpp"
/*
Author: Daisy

Description:  	alters energy pool by the amount and method given

Params:
_obj		-	<OBJECT>	-	object called on
_varName	-	<STRING>	-	varName of pool to alter value of
_limits		-	<ARRAY>		-	array of bounds
							+	format [lowerBound, upperBound]
_rate		- 	<ARRAY>		-	array of values to alter pool with	
							+	format [amount, time]
_methodM	-	<NUMBER>	-	methodMath ; operation to perform	
							+	[0 = add (default), 1 = subtract, 2 = multiply, 3 = divide]
_methodA	-	<NUMBER>	-	methodAlter ; method of incrementation
							+	[0 = chunk, 1 = smooth]
_methodO	-	<NUMBER>	-	methodOverflow ; method of handling overflow
							+	[0 = clamp, 1 = reject]

Do I clamp values that are below the _bound? or reject the addition?
Since this only provides the framework, I think it falls to the modder to make that check.
But I see no reason why I shouldn't do it too.

alterPoolClamp		-	Clamps pool to bound if new value would cross the bound
alterPoolReject		-	Rejects operation if it would cross the bound

Returns: 
true on success, false on failure

Public: yes
*/
params["_obj","_varName","_limits","_rate","_methodM","_methodA","_methodO"];

//check varname
if (isNull _varName) exitWith {
	RPTDEBUG(__FILE__,__LINE__,"ERROR","Variable name cannot be null.");
	false;
};

// exit if either bound is < 0
if ((_limits # 0) < 0 || (_limits # 1) < 0) exitWith {
	RPTDEBUG(__FILE__,__LINE__,"ERROR","Invalid bound (less than 0) in limit array "+str _limits);
	false;
};

//predefine non-static vars and grab vars
private _cVal 	= _obj getVariable _varName;
private _result = true;
private _bound 	= 0;
private _amnt 	= 0;
private _time 	= 0;
private _nVal 	= 0;
private _oBool	= false;

// deliniate overflow handling method
if (_methodO == 0) then {_oBool = true};
/*
switch (_methodO) do {
	case 0 : 	{ // clamp
		_oBool = true;
	};
	case 1 : 	{ // reject
		//_oBool = false;
	};
	default		{};
};
*/
// deliniate which method of alteration to use
switch (_methodA) do {
	case 0:		{
					_amnt 	= _rate # 0;
					_time	= _rate # 1;
				};
	case 1:		{
					_amnt 	= 1;
					_time	= (_rate # 1) / (_rate # 0);
					// clamp sleep to smallest value
					if (_time < 0.001) then {_time = 0.001;};
				};
	default		{
		exitWith {
			RPTDEBUG(__FILE__,__LINE__,"ERROR","Unknown alter method of "+str _methodA);
		};
	};
};

// deliniate operation
switch (_methodM) do {
	case 0 : 	{
					// define bound
					_bound = _limits # 1;
					_nVal = _cVal + _amnt;
					switch (true) do {
						case (_cVal == _bound): { // if current value == bound
							[QPVAR(boundReached),[_obj,_varName,_bound,_nVal,_cVal,_methodM,_methodA,_methodO],0] call FUNC(raiseEvent);
						};
						case (_nVal > _bound):	{ // if new value exceeds bound
							// if clamp option, exitWith clamp
							if (_oBool) exitWith {_obj setVariable [_varName, _bound];[QPVAR(clamp),[_obj,_varName,_bound,_nVal,_cVal,_methodM,_methodA,_methodO],0] call FUNC(raiseEvent);};
							// if not clamp, then reject
							[QPVAR(reject),[_obj,_varName,_bound,_nVal,_cVal,_methodM,_methodA,_methodO],0] call FUNC(raiseEvent);
							RPTDEBUG(__FILE__,__LINE__,"INFO","Operation would exceed bound. Exiting.");
							_result=false;
						};
						default					{_obj setVariable [_varName, _nVal];[QPVAR(altered),[_obj,_varName,_bound,_nVal,_cVal,_methodM,_methodA,_methodO],0] call FUNC(raiseEvent);};
					};
				};
	case 1 : 	{
					_bound = _limits # 0;
					_nVal = _cVal - _amnt;
					switch (true) do {
						case (_cVal == _bound): {
							[QPVAR(boundReached),[_obj,_varName,_bound,_nVal,_cVal,_methodM,_methodA,_methodO],0] call FUNC(raiseEvent);
						};
						case (_nVal > _bound):	{
							if (_oBool) exitWith {_obj setVariable [_varName, _bound];[QPVAR(clamp),[_obj,_varName,_bound,_nVal,_cVal,_methodM,_methodA,_methodO],0] call FUNC(raiseEvent);};
							[QPVAR(reject),[_obj,_varName,_bound,_nVal,_cVal,_methodM,_methodA,_methodO],0] call FUNC(raiseEvent);
							RPTDEBUG(__FILE__,__LINE__,"INFO","Operation would exceed bound. Exiting.");
							_result=false;
						};
						default					{_obj setVariable [_varName, _nVal];[QPVAR(altered),[_obj,_varName,_bound,_nVal,_cVal,_methodM,_methodA,_methodO],0] call FUNC(raiseEvent);};
					};
				};
	case 2 : 	{
					_bound = _limits # 1;
					_nVal = _cVal * _amnt;
					switch (true) do {
						case (_cVal == _bound): {
							[QPVAR(boundReached),[_obj,_varName,_bound,_nVal,_cVal,_methodM,_methodA,_methodO],0] call FUNC(raiseEvent);
						};
						case (_nVal > _bound):	{
							if (_oBool) exitWith {_obj setVariable [_varName, _bound];[QPVAR(clamp),[_obj,_varName,_bound,_nVal,_cVal,_methodM,_methodA,_methodO],0] call FUNC(raiseEvent);};
							[QPVAR(reject),[_obj,_varName,_bound,_nVal,_cVal,_methodM,_methodA,_methodO],0] call FUNC(raiseEvent);
							RPTDEBUG(__FILE__,__LINE__,"INFO","Operation would exceed bound. Exiting.");
							_result=false;
						};
						default					{_obj setVariable [_varName, _nVal];[QPVAR(altered),[_obj,_varName,_bound,_nVal,_cVal,_methodM,_methodA,_methodO],0] call FUNC(raiseEvent);};
					};
				};
	case 3 : 	{
					_bound = _limits # 0;
					_nVal = _cVal / _amnt;
					switch (true) do {
						case (_cVal == _bound): {
							[QPVAR(boundReached),[_obj,_varName,_bound,_nVal,_cVal,_methodM,_methodA,_methodO],0] call FUNC(raiseEvent);
						};
						case (_nVal < 1):		{
							if (_oBool) exitWith {_obj setVariable [_varName, _bound];[QPVAR(clamp),[_obj,_varName,_bound,_nVal,_cVal,_methodM,_methodA,_methodO],0] call FUNC(raiseEvent);};
							[QPVAR(reject),[_obj,_varName,_bound,_nVal,_cVal,_methodM,_methodA,_methodO],0] call FUNC(raiseEvent);
							RPTDEBUG(__FILE__,__LINE__,"INFO","Operation would exceed bound. Exiting.");
							_result=false;
						};
						default					{_obj setVariable [_varName, _nVal];[QPVAR(altered),[_obj,_varName,_bound,_nVal,_cVal,_methodM,_methodA,_methodO],0] call FUNC(raiseEvent);};
					};
				};
	default		{
					RPTDEBUG(__FILE__,__LINE__,"ERROR","Math method not specified. No operations performed.");
					[QPVAR(error),[__FILE__,__LINE__,"ERROR","Math method not specified. No operations performed."],1] call FUNC(raiseEvent);
				};
};

true;