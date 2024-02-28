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
	class DSY
	{
        tag=STR(PREFIX);
        class Functions {
            file="\functions";
            class alterPool;
            class initPool;
            class loopPool;
			class raiseEvent;
        };
    };
};