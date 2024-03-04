#include "addon_defines.hpp"
class CfgPatches
{
	class PREFIX
	{
		name="Daisy's Resource Pool Framework - High Level Systems";
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
		class funcs {
			file="functions";
			class renewPool;
		};
    };
};