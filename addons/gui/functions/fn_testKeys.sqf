#include "defines.hpp"
/*
Parameters
_addon	Name of the registering mod + optional sub-category <STRING, ARRAY>
_action	Id of the key action.  STRING
_title	Pretty name, or an array of pretty name and tooltip STRING
_downCode	Code for down event, empty string for no code.  <CODE>
_upCode	Code for up event, empty string for no code.  <CODE>
Optional
_defaultKeybind	The keybinding data in the format [DIK, [shift, ctrl, alt]] ARRAY
_holdKey	Will the key fire every frame while down <BOOLEAN>
_holdDelay	How long after keydown will the key event fire, in seconds.  <NUMBER>
_overwrite	Overwrite any previously stored default keybind <BOOLEAN>
*/
[
	["Daisy's Resource Pool Framework","GUI Test Keybinds"],
	QPVAR(testKeySmooth),
	["Player Pool Smooth Key", "Key automatically configured to use visual smoothing functions. Used for debug testing and showcasing."],
	{[PVAR(testObject),PVAR(testVarName),[PVAR(testAmount),PVAR(testTime)],[PVAR(testMethodM),PVAR(testMethodO)]] call FUNC(smoothKeyDown);},
	{[] call FUNC(smoothKeyUp);}
] call CBA_fnc_addKeybind;