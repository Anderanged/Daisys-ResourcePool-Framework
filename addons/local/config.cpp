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
			/*file="local\functions";
			class alterAllPoolsLocal;
			class alterPoolLocal;
			class createPoolLocal;
			class decayPoolLocal;
			class freezePoolLocal;
			class publishLocalPool;
			class removeAllPoolsLocal;
			class removePoolLocal;
			class renewPoolLocal;*/
			SQFC(alterAllPoolsLocal);
			SQFC(alterPoolLocal);
			SQFC(createPoolLocal);
			SQFC(decayPoolLocal);
			SQFC(freezePoolLocal);
			SQFC(publishLocalPool);
			SQFC(removeAllPoolsLocal);
			SQFC(removePoolLocal);
			SQFC(renewPoolLocal);
		};
	};
};