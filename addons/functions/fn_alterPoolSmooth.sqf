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

Returns: 
true on success, false on clamp.

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
						case (_cVal == _bound): {[QPVAR(boundReached),[],0] call FUNC(event);};
						case (_nVal > _bound):	{_obj setVariable [QPVAR(energy), _bound];[QPVAR(clamp),[],0] call FUNC(event);};
						default					{_obj setVariable [QPVAR(energy), _nVal];[QPVAR(alter),[],0] call FUNC(event);};
					};
				};
	case 1 : 	{
					private _nVal = _cVal - _amount;
					switch (true) do {
						case (_cVal == _bound): {[QPVAR(boundReached),[],0] call FUNC(event);};
						case (_nVal > _bound):	{_obj setVariable [QPVAR(energy), _bound];[QPVAR(clamp),[],0] call FUNC(event);};
						default					{_obj setVariable [QPVAR(energy), _nVal];[QPVAR(alter),[],0] call FUNC(event);};
					};
				};
	case 2 : 	{
					private _nVal = _cVal * _amount;
					switch (true) do {
						case (_cVal == _bound): {[QPVAR(boundReached),[],0] call FUNC(event);};
						case (_nVal > _bound):	{_obj setVariable [QPVAR(energy), _bound];[QPVAR(clamp),[],0] call FUNC(event);};
						default					{_obj setVariable [QPVAR(energy), _nVal];[QPVAR(alter),[],0] call FUNC(event);};
					};
				};
	case 3 : 	{
					private _nVal = _cVal / _amount;
					switch (true) do {
						case (_cVal == _bound): {[QPVAR(boundReached),[],0] call FUNC(event);};
						case (_nVal < 1):		{_obj setVariable [QPVAR(energy), 0];[QPVAR(clamp),[],0] call FUNC(event);};
						default					{_obj setVariable [QPVAR(energy), _nVal];[QPVAR(alter),[],0] call FUNC(event);};
					};
				};
	default		{
					RPTDEBUG(__FILE__,__LINE__,"ERROR","Method not specified. Adding amount to energy pool.");
				};
};

_result;