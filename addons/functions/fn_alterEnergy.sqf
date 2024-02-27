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


Returns: 
true on success, false on failiure.

Public: yes
*/

params ["_obj","_bound","_amount","_method"];

private _currentE = _obj getVariable QPVAR(energy);
private _result = true;

switch (_method) do {
	case 0 : 	{
					if ((_currentE + _amount) > _bound) exitWith {
						_obj setVariable [QPVAR(energy), _bound];
					};
					_obj setVariable [QPVAR(energy), (_currentE + _amount)];
				};
	case 1 : 	{
					if ((_currentE - _amount) < _bound) exitWith {
						_obj setVariable [QPVAR(energy), _bound];
					};
					_obj setVariable [QPVAR(energy), (_currentE - _amount)];};
	case 2 : 	{
					if ((_currentE * _amount) > _bound) exitWith {
						_obj setVariable [QPVAR(energy), _bound];
					};
					_obj setVariable [QPVAR(energy), (_currentE * _amount)];};
	case 3 : 	{
					if ((_currentE == 0 || _currentE / _amount) < 1) exitWith {
						_obj setVariable [QPVAR(energy), 0];
					};
					_obj setVariable [QPVAR(energy), (_currentE / _amount)];};
	default		{
					_obj setVariable [QPVAR(energy), (_currentE + _amount)];
					RPTDEBUG(__FILE__,__LINE__,"INFO","Method not specified. Adding amount to energy pool.");
					_result = false;
				};
};

_result;