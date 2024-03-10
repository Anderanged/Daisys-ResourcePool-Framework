#include "..\defines.hpp"
disableserialization;
params ["_object"];
[_object] spawn {
	with uiNamespace do {
		while {PVAR(selfLayerUpdate)} do {
			_object getVariable 
			findDisplay PVAR(selfLayerID) 
		};
	};
};