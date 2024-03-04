#include "defines.hpp"
class CfgPatches
{
	class PREFIX
	{
		name="Daisy's Resource Pool Framework - Base";
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
class CfgFunctions {
	class PREFIX {
		class base {
			file="functions";
			class alterPool;
			class initPool;
			class loopPool;
			class raiseEvent;
		};
		class handle {
			file="functions\handlers";
			class handleGreater;
			class handleLess;
		};
	};
};
#include "modules\CfgFactionClasses.hpp"
#include "modules\CfgVehicles.hpp"