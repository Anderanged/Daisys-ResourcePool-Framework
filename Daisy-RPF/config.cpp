#include "defines.hpp"
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
        class baseFuncs {
            file="Daisy-RPF\base\functions";
			class alterPool;
            class initPool;
            class loopPool;
			class raiseEvent;
        };
		class baseHandle {
			file="Daisy-RPF\base\functions\handlers";
			class handleGreater;
			class handleLess;
		};
		class module {
			file="Daisy-RPF\modules\functions";
		};
		class HLS {
			file="Daisy-RPF\HLS\functions";
		};
    };
};
#include "Daisy-RPF\modules\CfgFactionClasses.hpp"
#include "Daisy-RPF\modules\CfgVehicles.hpp"