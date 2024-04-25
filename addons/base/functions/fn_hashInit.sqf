#include "defines.hpp"
// hashmap that will index every resource pool in the mission. obj is key, poolVars are values.
// idiotproofed. noone touchy now!

if (missionNamespace getVariable [QPVAR(resourcePoolsInit),false]) exitWith {
	HINT_BASIC("What did you expect? The Spanish Inquisition?"); // annoying popup
	RPT_DTAIL("Warning: Please do not call the hashmap function directly any more. Thank you.",__FILE__,__LINE__);
};
missionNamespace setVariable [QPVAR(resourcePools),createHashMap,true];
missionNamespace setVariable [QPVAR(resourcePoolsInit),true,true];