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
			"DSY_rpf_base",
			"DSY_rpf_local"
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
			file="qol\functions";
			class poolSetDecay;
			class poolSetLimit;
			class poolSetRDArray;
			class poolSetRenew;
			class poolStopRD;
			class poolSetDecayLocal;
			class poolSetLimitLocal;
			class poolSetRDArrayLocal;
			class poolSetRenewLocal;
			class poolStopRDLocal;
		};
	};
};