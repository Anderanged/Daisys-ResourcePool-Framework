#include "defines.hpp"
if (isServer) exitWith {};
uiNamespace setVariable [QPVAR(selfLayerID),(QPVAR(selfLayer) call BIS_fnc_rscLayer)];
uiNamespace setVariable [QPVAR(selfLayerUpdate),false];