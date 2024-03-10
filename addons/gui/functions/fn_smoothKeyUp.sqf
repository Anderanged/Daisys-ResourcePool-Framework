#include "defines.hpp"
private _handle = player getVariable [QPVAR(smoothKeyHandle),true];
if _handle exitWith {};
terminate _handle;
player setVariable [QPVAR(smoothKeyHandle),nil];