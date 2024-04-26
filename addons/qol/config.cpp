#include "macros\defines.hpp"
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
			QPVAR(base),
			QPVAR(local)
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
			/*file="qol\functions";
			class poolSetDecay;
			class poolSetLimit;
			class poolSetRate;
			class poolSetRenew;
			class poolStopRD;
			class poolSetDecayLocal;
			class poolSetLimitLocal;
			class poolSetRateLocal;
			class poolSetRenewLocal;
			class poolStopRDLocal;*/
			SQFC(poolSetDecay);
			SQFC(poolSetLimit);
			SQFC(poolSetRate);
			SQFC(poolSetRenew);
			SQFC(poolStopRD);
			SQFC(poolSetDecayLocal);
			SQFC(poolSetLimitLocal);
			SQFC(poolSetRateLocal);
			SQFC(poolSetRenewLocal);
			SQFC(poolStopRDLocal);
		};
	};
};