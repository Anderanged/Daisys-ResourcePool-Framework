#include "macros/defines.hpp"
[
	QPVAR(debugSwitch),
	"CHECKBOX",
	["Debug Enabled","Whether or not to dump non error values to the RPT file."],
	["[RPF] Resource Pool Framework","Debug"],
	false,
	0,
	{call compileScript['x\Daisys-ResourcePool-Framework\addons\debug\initEH.sqf'];}
] call CBA_fnc_addSetting;
