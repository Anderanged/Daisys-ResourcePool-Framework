#include "defines.hpp"
[ // recompile this for new script compilation works
	QPVAR(debugSwitch),
	"CHECKBOX",
	["Debug Enabled","Whether or not to dump non error values to the RPT file."],
	["[RPF] Resource Pool Framework","Debug"],
	false,
	0,
	{call compileScript['\debug\initEH.sqfc'];}
] call CBA_fnc_addSetting;
