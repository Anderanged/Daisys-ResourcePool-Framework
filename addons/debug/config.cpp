#include "macros\defines.hpp"
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
			QPVAR(base),
			QPVAR(qol)
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
		init = "call compileScript['\debug\initSettings.sqfc'];call compileScript['\debug\initEH.sqfc'];";
	};
};