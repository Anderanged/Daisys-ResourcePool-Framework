#include "defines.hpp"
/*Parameters
_setting	Unique setting name.  Matches resulting variable name STRING
_settingType	Type of setting.  Can be “CHECKBOX”, “EDITBOX”, “LIST”, “SLIDER” or “COLOR” STRING
_title	Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
_category	Category for the settings menu + optional sub-category <STRING, ARRAY>
_valueInfo	Extra properties of the setting depending of _settingType.  See examples below <ANY>
_isGlobal	1: all clients share the same setting, 2: setting can’t be overwritten (optional, default: 0) ARRAY
_script	Script to execute when setting is changed.  (optional) <CODE>
_needRestart	Setting will be marked as needing mission restart after being changed.  (optional, default false) <BOOL>
*/
[
	QPVAR(testObject),
	"EDITBOX",
	["Smoothing Key Test Object","-tooltip-"],
	["Daisy's RPF Settings","Smoothing Test Settings"],
	"player"
] call CBA_fnc_addSetting;
[
	QPVAR(testVarName),
	"EDITBOX",
	["Smoothing Key Test Pool varName","-tooltip-"],
	["Daisy's RPF Settings","Smoothing Test Settings"],
	QPVAR(pool)
] call CBA_fnc_addSetting;
[
	QPVAR(testAmount),
	"EDITBOX",
	["Smoothing Key Test Amount","-tooltip-"],
	["Daisy's RPF Settings","Smoothing Test Settings"],
	"2"
] call CBA_fnc_addSetting;
[
	QPVAR(testTime),
	"EDITBOX",
	["Smoothing Key Test Time","-tooltip-"],
	["Daisy's RPF Settings","Smoothing Test Settings"],
	"1"
] call CBA_fnc_addSetting;
[
	QPVAR(testMethodM),
	"CHECKBOX",
	["Smoothing Key Test Math Operation","true = subtract, false = add"],
	["Daisy's RPF Settings","Smoothing Test Settings"],
	false
] call CBA_fnc_addSetting;
[
	QPVAR(testMethodO),
	"CHECKBOX",
	["Smoothing Key Test Overflow Op","true = reject, false = clamp"],
	["Daisy's RPF Settings","Smoothing Test Settings"],
	false
] call CBA_fnc_addSetting;