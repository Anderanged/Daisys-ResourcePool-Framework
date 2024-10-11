#include "macros/addon_defines.hpp"
#include "macros/macro_defines.hpp"
#include "script_version.hpp"
private _msg = format ["[%1] (%2) VERSIONING: %3",QUOTE(PREFIX),QUOTE(COMPONENT),VERSION_PATCH];
SLOG(_msg);