#include "addon_defines.hpp"
class CfgPatches
{
	class PREFIX
	{
		name="Daisy's ResourcePool Framework";
		units[]={};
		weapons[]={};
		requiredVersion=0.1;
		requiredAddons[]={
			"cba_main"
		};
		authors[]=
        {
			"Daisy"
        };
    };
};
class cfgFunctions
{
	class PREFIX
	{
        tag=STR(PREFIX);
        class modules {
			file="functions";
			class alterPoolModule;
		}
    };
};
#include "CfgFactionClasses.hpp"
#include "CfgVehicles.hpp"