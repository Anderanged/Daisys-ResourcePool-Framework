#include "defines.hpp"

// look up pools by obj
[QPVAR(objectPools),missionNamespace,true] call database_fnc_create;
// look up all variables by obj
[QPVAR(objectPoolsVars),missionNamespace,true] call database_fnc_create;