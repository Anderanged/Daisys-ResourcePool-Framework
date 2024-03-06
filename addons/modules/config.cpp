#include "addon_defines.hpp"
#include "version.hpp"
class CfgPatches
{
	class ADDON
	{
		name="Daisy's ResourcePool Framework - Modules";
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
class cfgFunctions
{
	class PREFIX
	{
        tag=STR(PREFIX);
        class modules {
			file="modules\functions";
			class alterPoolModule;
			class freezePoolModule;
			class initPoolModule;
			class loopPool;
		}
    };
};
#include "modules\config\CfgFactionClasses.hpp"
#include "modules\config\CfgVehicles.hpp"