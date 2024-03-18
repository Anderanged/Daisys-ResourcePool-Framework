#define PREFIX DSY_rpf
#include "macro_defines.hpp"

#define RPFLIM_MAX 16384 // 2^14
#define ADD_CLAMP [false,false]
#define SUB_CLAMP [true,false]
#define ADD_REJCT [false,true]
#define SUB_REJCT [true,true]

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
#define E_DECAYED	QPVAR(decayed)
#define E_EDITED	QPVAR(edited)
#define E_REPEATP	QPVAR(repeatPool)
#define E_CREATED	QPVAR(created)
#define E_ERROR		QPVAR(error)
#define E_LOCSERV	QPVAR(locOnServer)