#include "defines.hpp"
#include "version.hpp"
class CfgPatches
{
	class ADDON
	{
		name="Daisy's Resource Pool Framework - Base";
		units[]={};
		weapons[]={};
		requiredVersion=REQ_VERSION;
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
			class freezePool;
		};
	};
};
//#include "CfgEventhandlers.hpp"