#include "macros\defines.hpp"
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
			/*file="base\functions";
			class accessHash;
			class alterAllPools;
			class alterPool;
			class decayPool;
			class freezePool;
			class hashInit {preInit = 1;};
			class createPool;
			class raiseEvent;
			class removeAllPools;
			class removePool;
			class renewPool;*/
			SQFC(accessHash);
			SQFC(alterAllPools);
			SQFC(alterPool);
			SQFC(decayPool);
			SQFC(freezePool);
			SQFC_PRE(hashInit);
			SQFC(createPool);
			SQFC(raiseEvent);
			SQFC(removeAllPools);
			SQFC(removePool);
			SQFC(renewPool);
		};
	};
};

class Extended_PreInit_EventHandlers 
{
	class ADDON
	{
		init = "call compileScript['\base\version.sqf']";
	};
};