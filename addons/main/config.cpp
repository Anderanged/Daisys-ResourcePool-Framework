#include "macros/addon_defines.hpp"
#include "macros/macro_defines.hpp"
class CfgPatches {
	class ADDON {
		name="";
		units[]={};
		weapons[]={};
		requiredVersion=REQ_VERSION;
		requiredAddons[]={
			"cba_main",
			"database_main"
		};
		authors[]=
        {
			"Daisy"
        };
    };
};
#include "xeh_preStart.hpp"