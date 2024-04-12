#include "version.hpp"
#define COMPONENT gui
#include "defines.hpp"

#define FPATH(name) COMPONENT##/functions/##fn##_##name
#define QFPATH(name) STR(FPATH(name))
#define SQF(name) class name {file = QFPATH(name.sqf);}
#define SQF_PRE(name) class name {file = QFPATH(name.sqf);preInit=1;}
#define SQF_PST(name) class name {file = QFPATH(name.sqf);postInit=1;}
#define SQFC(name) class name {file = QFPATH(name.sqfc);}
#define SQFC_PRE(name) class name {file = QFPATH(name.sqfc);preInit=1;}
#define SQFC_PST(name) class name {file = QFPATH(name.sqfc);postInit=1;}