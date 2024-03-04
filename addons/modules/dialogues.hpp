class DSY_rpf_zeusDiag_base
{
	idd = -1; // 
	access = 0; // read & write
	movingEnable = true; // if dialog can be moved
	onLoad = "hint str _this"; // executed when dialog opened
	onUnload  = "hint str _this"; // executed when dialog closed
	enableSimulation = true; // does game continue when dialog shown?
	class ControlsBackground
	{ // all background controls
		//Background controls
	};
	class Controls
	{ // all foreground controls
		class okButton
		{

		};
		class cancelButton
		{

		};
	};
	class Objects
	{ // all dialog controls - objects type controls 
		//Objects
	};
};