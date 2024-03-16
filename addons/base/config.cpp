#include "addon_defines.hpp"
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
		tag=STR(PREFIX);
		class COMPONENT {
			file="base\functions";
			class accessHash;
			class alterAllPools;
			class alterPool;
			class decayPool;
			class editPool;
			class freezePool;
			class handleGreater;
			class handleLess;
			class hashInit {preInit = 1;};
			class initPool;
			class raiseEvent;
			class removeAllPools;
			class removePool;
			class renewPool;
		};
	};
};