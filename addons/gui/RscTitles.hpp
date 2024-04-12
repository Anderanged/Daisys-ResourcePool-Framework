#include "macros\definecommongrids.inc"
#include "macros\defineResincl.inc"
#include "gui_defines.hpp"

class RscTitles
{
	class DSY_rpf_selfGui
	{
		idd = IDD_RPF_TEST_TEXT;
		fadein = 0;
		fadeout = 0;
		duration = 1e+011;
		onLoad = "uinamespace setVariable ['DSY_rpf_selfGui',_this select 0]";
		onUnLoad = "uinamespace setVariable ['DSY_rpf_selfGui', nil]";
		class Controls 
		{
			class text
			{
				type = 0;
				idc = IDC_RPF_TEXT_1;
				x = safeZoneX + safeZoneW * 0.91875;
				y = safeZoneY + safeZoneH * 0.15185186;
				w = safeZoneW * 0.0625;
				h = safeZoneH * 0.04444445;
				style = ST_LEFT + ST_WITH_RECT;
				text = "0";
				colorBackground[] = {0,0,0,0};
				colorText[] = {1,1,1,1};
				font = "PuristaMedium";
				sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
				access = 0;
				moving = false;
				onKeyDown = "keyDown.sqf";
				shadow = 0;
			};
		};
	};
	class DSY_rpf_selfGuiBar
	{
		idd = IDD_RPF_TEST_BAR;
		fadein = 0;
		fadeout = 0;
		duration = 1e+011;
		onLoad = "uinamespace setVariable ['DSY_rpf_selfGuiBar',_this select 0]";
		onUnLoad = "uinamespace setVariable ['DSY_rpf_selfGuiBar', nil]";
		class Controls
		{
			class bar
			{
				type = 8;
				idc = IDC_RPF_BAR_1;
				x = safeZoneX + safeZoneW * 0.69791667;
				y = safeZoneY + safeZoneH * 0.15185186;
				w = safeZoneW * 0.2875;
				h = safeZoneH * 0.03148149;
				style = 0;
				colorBar[] = {1,1,1,0.95};
				colorFrame[] = {0.102,0.102,0.102,1};
				texture = "#(argb,8,8,3)color(1,1,1,1)";
				access = 0;
			};
		};
	};
};