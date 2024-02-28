#include "defines.hpp"
/*
Author: Daisy

Description:  	alters energy pool by the amount and method given

Params:
_obj		-	object called on
_bound		-	limit of energy
_amount		- 	amount to alter pool by 	<NUMBER>	
	OPTIONAL: 
_method		-	method of altering  		<NUMBER> 	
			+	[0 = add (default), 1 = subtract, 
				2 = multiply, 3 = divide]

Do I clamp values that are below the _bound? or reject the addition?
Since this only provides the framework, I think it falls to the modder to make that check.
But I see no reason why I shouldn't do it too.

alterPoolClamp		-	Clamps pool to bound if new value would cross the bound
alterPoolReject		-	Rejects operation if it would cross the bound

alterSmooth
alterChunk

Returns: 
true on success, false on rejection

Public: yes
*/

params ["_obj","_bound","_amount","_method"];

private _cVal = _obj getVariable QPVAR(energy);
private _result = true;

if (_bound < 0) exitWith {
	RPTDEBUG(__FILE__,__LINE__,"ERROR","Bound was less than zero. Exiting Script.");
	false;
};

switch (_method) do {
	case 0 : 	{
					private _nVal = _cVal + _amount;
					switch (true) do {
						case (_cVal == _bound): {};
						case (_nVal > _bound):	{
							[QPVAR(reject),[_obj,_bound,_nVal,_cVal,_method],0] call FUNC(raiseEvent);
							RPTDEBUG(__FILE__,__LINE__,"INFO","Operation would exceed bound. Exiting.");
							_result=false;
						};
						default					{_obj setVariable [QPVAR(energy), _nVal];};
					};
				};
	case 1 : 	{
					private _nVal = _cVal - _amount;
					switch (true) do {
						case (_cVal == _bound): {};
						case (_nVal > _bound):	{
							[QPVAR(reject),[_obj,_bound,_nVal,_cVal,_method],0] call FUNC(raiseEvent);
							RPTDEBUG(__FILE__,__LINE__,"INFO","Operation would exceed bound. Exiting.");
							_result=false;
						};
						default					{_obj setVariable [QPVAR(energy), _nVal];};
					};
				};
	case 2 : 	{
					private _nVal = _cVal * _amount;
					switch (true) do {
						case (_cVal == _bound): {};
						case (_nVal > _bound):	{
							[QPVAR(reject),[_obj,_bound,_nVal,_cVal,_method],0] call FUNC(raiseEvent);
							RPTDEBUG(__FILE__,__LINE__,"INFO","Operation would exceed bound. Exiting.");
							_result=false;
						};
						default					{_obj setVariable [QPVAR(energy), _nVal];};
					};
				};
	case 3 : 	{
					private _nVal = _cVal / _amount;
					switch (true) do {
						case (_cVal == _bound): {};
						case (_nVal < 1):		{
							[QPVAR(reject),[_obj,_bound,_nVal,_cVal,_method],0] call FUNC(raiseEvent);
							RPTDEBUG(__FILE__,__LINE__,"INFO","Operation would exceed bound. Exiting.");
							_result=false;
						};
						default					{_obj setVariable [QPVAR(energy), _nVal];};
					};
				};
	default		{
					_obj setVariable [QPVAR(energy), (_cVal + _amount)];
					RPTDEBUG(__FILE__,__LINE__,"INFO","Method not specified. Adding amount to energy pool.");
				};
};

_result;