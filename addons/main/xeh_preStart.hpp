#include "macros/addon_defines.hpp"
#include "macros/macro_defines.hpp"
#undef VERSION_PATHTO_SQF
#undef VERSION_PATHTO_SQFC
#undef COMPILE
#undef VERSION_SCRIPT_PATH
#define VERSION_PATHTO_SQF \MAINPREFIX\PREFIX\SUBPREFIX\main\versionLog.sqf
#define VERSION_PATHTO_SQFC \MAINPREFIX\PREFIX\SUBPREFIX\main\versionLog.sqfc
#define VERSION_SCRIPT_PATH QUOTE(call COMPILE(VERSION_PATHTO_SQF))
class Extended_PreStart_EventHandlers {
    class ADDON {
        init = VERSION_SCRIPT_PATH;
    };
};