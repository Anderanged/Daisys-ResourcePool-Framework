#include "macros\addon_defines.hpp"
class CfgPatches
{
	class ADDON
	{
		name="Daisy's Resource Pool Framework - GUI Systems";
		units[]={};
		weapons[]={};
		requiredVersion=0.1;
		requiredAddons[]={
			QPVAR(base),
			QPVAR(local),
			"cba_main"
		};
		authors[]=
        {
			"Daisy"
        };
    };
};
class CfgFunctions
{
	class PREFIX
	{
        tag=STR(PREFIX);
		class COMPONENT {
			file="gui\functions";
			class alterPoolSpoof;
			class smoothHudNum;
			class smoothHudExp;
			class smoothKey;
			class smoothKeyDown;
			class smoothKeyUp;
			class settings {preInit=1;};
			class testKeys {preInit=1;};
			//SQFC(alterPoolSpoof);
			//SQFC(smoothHudNum);
			//SQFC(smoothHudExp);
			//SQFC(smoothKey);
			//SQFC(smoothKeyDown);
			//SQFC(smoothKeyUp);
			//SQFC(settings);
			//SQFC(testKeys);
		};
    };
};
#include "RscTitles.hpp"