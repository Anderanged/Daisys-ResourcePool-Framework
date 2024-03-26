#include "macros\addon_defines.hpp"
class CfgPatches
{
	class ADDON
	{
		name="";
		units[]={};
		weapons[]={};
		requiredVersion=REQ_VERSION;
		requiredAddons[]={
			"cba_main",
			QPVAR(base)
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
			file="local\functions";
			class alterAllPoolsLocal;
			class alterPoolLocal;
			class decayPoolLocal;
			class freezePoolLocal;
			class createPoolLocal;
			class publishLocalPool;
			class removeAllPoolsLocal;
			class removePoolLocal;
			class renewPoolLocal;
		};
	};
};