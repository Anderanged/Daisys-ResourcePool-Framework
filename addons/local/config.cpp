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
			"DSY_rpf_base"
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
			class editPoolLocal;
			class freezePoolLocal;
			class initPoolLocal;
			class publishLocalPool;
			class removeAllPoolsLocal;
			class removePoolLocal;
			class renewPoolLocal;
		};
	};
};