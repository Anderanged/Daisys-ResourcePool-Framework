#include "..\defines.hpp"

//disableSerialization;
with uiNamespace do {
	PVAR(selfLayerID) cutRsc [
		QPVAR(selfGui), 	// class name of rsc
		"PLAIN",			// https://community.bistudio.com/wiki/Title_Effect_Type
		0.25				// speed to fade in (seconds)
	/*	,false,				// true to draw over map
		false				// true to draw over basegame HUD
	*/
	];
};