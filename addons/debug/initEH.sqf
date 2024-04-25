#include "macros/defines.hpp"
if !(PVAR(debugSwitch)) exitWith {
	private _array = missionNamespace getVariable [QPVAR(debugArr),false];
	if (_array isEqualType false) exitWith {}; //stops initial run when first booted
	private "_current";
	for "_i" from 0 to ((count _array)-1) do {
		_current = _array # _i;
		[_current # 0,_current # 1] call CBA_fnc_removeEventHandler;
	};
};
private _array = [];
private _msg = "";
private _id = [E_RENEWSTOP,{
	_msg = format ["Debug: Pool (%1) does not have renew enabled. Exiting Loop.",_this#1];
	RPT_BASIC(_msg);}
] call CBA_fnc_addEventHandler;
_array pushBack [E_RENEWSTOP,_id];

_id = [E_RENEWED,{
	_msg = format ["Debug: Pool (%1) renewed.",_this#1];
	RPT_BASIC(_msg);}
] call CBA_fnc_addEventHandler;
_array pushBack [E_RENEWED,_id];

_id = [E_DECAYSTOP,{
	_msg = format ["Debug: Pool (%1) does not have decay enabled. Exiting Loop.",_this#1];
	RPT_BASIC(_msg);}
] call CBA_fnc_addEventHandler;
_array pushBack [E_DECAYSTOP,_id];

_id = [E_DECAYED,{
	_msg = format ["Debug: Pool (%1) renewed.",_this#1];
	RPT_BASIC(_msg);}
] call CBA_fnc_addEventHandler;
_array pushBack [E_DECAYED,_id];

_id = [
	E_ALTEREDA,{
		_msg = format ["Debug: Object (%1) has had all resource pools altered by amount (%2).",_this#0,_this#1];
		RPT_BASIC(_msg);
	}
] call CBA_fnc_addEventHandler;
_array pushBack [E_ALTEREDA,_id];

_id = [
	E_UBOUND,{// [_obj,_varName,_amount,_methods]
		_msg = format ["Debug: Upper bound reached in alteration of object (%1), pool (%2), with amount (%3) and methods (%4).",_this#0,_this#1,_this#2,_this#3];
		RPT_BASIC(_msg);
	}
] call CBA_fnc_addEventHandler;
_array pushBack [E_UBOUND,_id];

_id = [
	E_REJECT,{// [_obj,_varName,_amount,_methods]
		_msg = format ["Debug: Rejection of alteration of object (%1), pool (%2), with amount (%3) and methods (%4).",_this#0,_this#1,_this#2,_this#3];
		RPT_BASIC(_msg);
	}
] call CBA_fnc_addEventHandler;
_array pushBack [E_REJECT,_id];

_id = [
	E_CLAMP,{// [_obj,_varName,_amount,_methods]
		_msg = format ["Debug: Alteration clamped to bound of object (%1), pool (%2), with amount (%3) and methods (%4).",_this#0,_this#1,_this#2,_this#3];
		RPT_BASIC(_msg);
	}
] call CBA_fnc_addEventHandler;
_array pushBack [E_CLAMP,_id];

_id = [
	E_LBOUND,{// [_obj,_varName,_amount,_methods]
		_msg = format ["Debug: Lower bound reached in alteration of object (%1), pool (%2), with amount (%3) and methods (%4).",_this#0,_this#1,_this#2,_this#3];
		RPT_BASIC(_msg);
	}
] call CBA_fnc_addEventHandler;
_array pushBack [E_LBOUND,_id];

_id = [
	E_ONICE,{// [_obj,_varName,_amount,_methods]
		_msg = format ["Debug: Pool (%1) on object (%2) is frozen. Alteration cancelled.",this#1,_this#0];
		RPT_BASIC(_msg);
	}
] call CBA_fnc_addEventHandler;
_array pushBack [E_ONICE,_id];

_id = [
	E_FROZEN,{// [_obj,_varName,_amount,_methods]
		_msg = format ["Debug: Pool (%1) on object (%2) was frozen.",this#1,_this#0];
		RPT_BASIC(_msg);
	}
] call CBA_fnc_addEventHandler;
_array pushBack [E_FROZEN,_id];

_id = [
	E_UNFROZEN,{// [_obj,_varName,_amount,_methods]
		_msg = format ["Debug: Pool (%1) on object (%2) was unfrozen.",this#1,_this#0];
		RPT_BASIC(_msg);
	}
] call CBA_fnc_addEventHandler;
_array pushBack [E_UNFROZEN,_id];

_id = [
	E_ALTERED,{// [_obj,_varName,_amount,_methods]
		_msg = format ["Debug: Performed alteration on object (%1), pool (%2), with amount (%3) and methods (%4).",_this#0,_this#1,_this#2,_this#3];
		RPT_BASIC(_msg);
	}
] call CBA_fnc_addEventHandler;
_array pushBack [E_ALTERED,_id];

_id = [
	E_CREATED,{
		_msg = format ["Debug: Object (%1) has been initialized as a resource pool with values (%2).",_this#0,[_this#1,_this#2,_this#3]];
		RPT_BASIC(_msg);
	}
] call CBA_fnc_addEventHandler;
_array pushBack [E_CREATED,_id];

_id = [
	E_DESTRYD,{
		_msg = format ["Debug: Object (%1) has been destroyed or killed and has had all resource pools removed.",_this#0];
		RPT_BASIC(_msg);
	}
] call CBA_fnc_addEventHandler;
_array pushBack [E_DESTRYD,_id];

_id = [
	E_REMOVEDA,{
		_msg = format ["Debug: Object (%1) has had all resource pools removed.",_this#0];
		RPT_BASIC(_msg);
	}
] call CBA_fnc_addEventHandler;
_array pushBack [E_REMOVEDA,_id];

_id = [
	E_REMOVED,{
		_msg = format ["Debug: Object (%1) has had resource pool (%2) removed.",_this#0,_this#1];
		RPT_BASIC(_msg);
	}
] call CBA_fnc_addEventHandler;
_array pushBack [E_REMOVED,_id];

_id = [
	QPVAR(setDecay),{
		_msg = format ["Debug: Object (%1), resource pool (%2) has had decay set with rate (%3).",_this#0,_this#1,_this#2];
		RPT_BASIC(_msg);
	}
] call CBA_fnc_addEventHandler;
_array pushBack [QPVAR(setDecay),_id];

_id = [
	QPVAR(setRenew),{
		_msg = format ["Debug: Object (%1), resource pool (%2) has had renew set with rate (%3).",_this#0,_this#1,_this#2];
		RPT_BASIC(_msg);
	}
] call CBA_fnc_addEventHandler;
_array pushBack [QPVAR(setRenew),_id];

_id = [
	QPVAR(stopRD),{
		_msg = format ["Debug: Object (%1), resource pool (%2) with rate (%3) has had its renew/decay loops deactivated.",_this#0,_this#1,_this#2];
		RPT_BASIC(_msg);
	}
] call CBA_fnc_addEventHandler;
_array pushBack [QPVAR(stopRD),_id];

_id = [
	QPVAR(setLimit),{
		_msg = format ["Debug: Object (%1), resource pool (%2) has had limit set to (%3) from (%4).",_this#0,_this#1,_this#2,_this#3];
		RPT_BASIC(_msg);
	}
] call CBA_fnc_addEventHandler;
_array pushBack [QPVAR(setLimit),_id];

_id = [
	QPVAR(setRate),{
		_msg = format ["Debug: Object (%1), resource pool (%2) has had rate set to (%3) from (%4).",_this#0,_this#1,_this#2,_this#3];
		RPT_BASIC(_msg);
	}
] call CBA_fnc_addEventHandler;
_array pushBack [QPVAR(setRate),_id];

missionNamespace setVariable [QPVAR(debugArr),_array];