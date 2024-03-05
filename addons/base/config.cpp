#include "defines.hpp"
class CfgPatches
{
	class ADDON
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
		class COMPONENT {
			file="base\functions";
			class alterPool;
			class handleGreater;
			class handleLess;
			class initPool;
			class loopPool;
			class raiseEvent;
		};
	};
};
//#include "CfgEventhandlers.hpp"