#include "..\macros\addon_defines.hpp"
#include "..\macros\macro_defines.hpp"

#undef RPF_LIM_MAX
#undef ADD_CLAMP
#undef SUB_CLAMP
#undef ADD_REJCT
#undef SUB_REJCT
#define RPF_LIM_MAX 65536 // 2^16
#define ADD_CLAMP [false,false]
#define SUB_CLAMP [true,false]
#define ADD_REJCT [false,true]
#define SUB_REJCT [true,true]

#undef E_ONICE
#undef E_FROZEN
#undef E_UNFROZEN
#undef E_UBOUND
#undef E_LBOUND
#undef E_CLAMP
#undef E_ALTERED
#undef E_ALTEREDA
#undef E_REMOVED
#undef E_REMOVEDA
#undef E_RENEWED
#undef E_RENEWSTOP
#undef E_DECAYED
#undef E_DECAYSTOP
#undef E_EDITED
#undef E_REPEATP
#undef E_CREATED
#undef E_DESTRYD
#undef E_ERROR
#undef E_LOCSERV

// readable event macros
#define E_ONICE		QPVAR(onIce)
#define E_FROZEN	QPVAR(frozen)
#define E_UNFROZEN	QPVAR(unfrozen)
#define E_UBOUND	QPVAR(uBound)
#define E_LBOUND	QPVAR(lBound)
#define E_REJECT	QPVAR(reject)
#define E_CLAMP		QPVAR(clamp)
#define E_ALTERED	QPVAR(altered)
#define E_ALTEREDA	QPVAR(alteredAll)
#define E_REMOVED	QPVAR(removed)
#define E_REMOVEDA	QPVAR(removedAll)
#define E_RENEWED	QPVAR(renewed)
#define E_RENEWSTOP QPVAR(renewStop)
#define E_DECAYED	QPVAR(decayed)
#define E_DECAYSTOP QPVAR(decayStop)
#define E_EDITED	QPVAR(edited)
#define E_REPEATP	QPVAR(repeatPool)
#define E_CREATED	QPVAR(created)
#define E_DESTRYD	QPVAR(destroyed)
#define E_ERROR		QPVAR(error)
#define E_LOCSERV	QPVAR(locOnServer)

#undef EVENT_SERVER
#undef EVENT_GLOBAL
#undef EVENT_LOCAL
#define EVENT_SERVER(name,params) [name,params] call CBA_fnc_serverEvent
#define EVENT_GLOBAL(name,params) [name,params] call CBA_fnc_globalEvent
#define EVENT_LOCAL(name,params) [name,params] call CBA_fnc_localEvent