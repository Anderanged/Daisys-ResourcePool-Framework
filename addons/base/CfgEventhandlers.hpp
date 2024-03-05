class Extended_PreInit_EventHandlers {
	class ADDON {
		// This will be executed once in 3DEN, main menu and before briefing has started for every mission
		init = "call compile ""XEH_preInit.sqf""";
	};
};

class Extended_PostInit_EventHandlers {
	class ADDON {
		// This will be executed once for each mission, once the mission has started
		init = "";
	};
};

class Extended_PreStart_EventHandlers {
	class ADDON {
		// This will be executed once before entering the main menu.
		init = "";
	};
};