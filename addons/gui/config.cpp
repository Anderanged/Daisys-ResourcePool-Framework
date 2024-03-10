#include "addon_defines.hpp"
class CfgPatches
{
	class ADDON
	{
		name="Daisy's Resource Pool Framework - GUI Systems";
		units[]={};
		weapons[]={};
		requiredVersion=0.1;
		requiredAddons[]={
			"DSY_rpf_base"
			"cba_main"
		};
		authors[]=
        {
			"Daisy"
        };
    };
};
class CfgFunctions
{
	class PREFIX
	{
        tag=STR(PREFIX);
		class COMPONENT {
			file="gui\functions";
			class smoothGui;
			class smoothKey;
			class smoothKeyDown;
			class smoothKeyUp;
			class settings {preInit=1;};
			class testKeys {preInit=1;};
		};
    };
};