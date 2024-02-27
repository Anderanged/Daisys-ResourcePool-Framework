class CfgPatches
{
	class DSY_ef
	{
		name="Daisy's Energy Framework";
		units[]={};
		weapons[]={};
		requiredVersion=0.1;
		requiredAddons[]={
			"cba_main"
		};
		authors[]=
        {
			"Daisy"
        };
    };
};
class cfgFunctions
{
	class DSY // change irrelevent classes
	{
        tag="DSY_ef";
        class Functions {
            file="\functions";
            class alterEnergy;
            class initPool;
            class rechargeLoop;
        };
    };
};