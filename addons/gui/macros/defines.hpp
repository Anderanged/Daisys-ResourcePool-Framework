#define PREFIX RPF
#include "macro_defines.hpp"

#define RPFLIM_MAX 65536 // 2^16
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
#define E_DESTRYD	QPVAR(destroyed)
#define E_ERROR		QPVAR(error)
#define E_LOCSERV	QPVAR(locOnServer)

// y=\frac{\sqrt[3]{x}}{2} 	(desmos notation)
// y = x^(1/3) / 2		(human  notation)
// all values between 0 and 1 
// 10 point 
#define SLEEP_TABLE 		[0.009125, 0.01825, 0.0365, 0.073, 0.146, 0.292, 0.368, 0.422, 0.464, 0.5] 
//#define RPF_EXP_TBLE_DBL	[0.292, 0.292, 0.368, 0.368, 0.422, 0.422, 0.464, 0.464, 0.5, 0.5]
// 7 point sleep values to interpolate up to preTable for
//#define RPF_EXP_TBLE_PRE	[0.146, 0.073, 0.0365, 0.01825, 0.009125, 0.0045, 0.00228]

// 10 point 
#define RPF_EXP_TBLE_L 	[0.232, 0.292, 0.335, 0.368, 0.397, 0.422, 0.444, 0.464, 0.483, 0.5]
#define RPF_EXP_TBLE_L_TIME 3.937