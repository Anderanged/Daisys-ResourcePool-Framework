#include "macros/addon_defines.hpp"
#include "macros/macro_defines.hpp"
class CfgPatches {
	class ADDON {
		name="";
		units[]={};
		weapons[]={};
		requiredVersion=REQ_VERSION;
		requiredAddons[]={
			QPVAR(main)
		};
		authors[]=
        {
			"Daisy"
        };
    };
};
class CfgFunctions {
	class PREFIX {
		tag=QUOTE(ADDON);
		class COMPONENT {
			file="main\functions";
		};
	};
};