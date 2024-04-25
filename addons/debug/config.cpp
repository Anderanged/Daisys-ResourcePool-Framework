#include "macros\addon_defines.hpp"
class CfgPatches
{
	class ADDON
	{
		name="";
		units[]={};
		weapons[]={};
		requiredVersion=REQ_VERSION;
		requiredAddons[]={
			"cba_main",
			"DSY_rpf_base"
		};
		authors[]=
        {
			"Daisy"
        };
    };
};
class Extended_PreInit_EventHandlers 
{
	class ADDON 
	{
		init = "call compileScript['x\Daisys-ResourcePool-Framework\addons\debug\initSettings.sqf'];call compileScript['x\Daisys-ResourcePool-Framework\addons\debug\initEH.sqf'];";
	};
};