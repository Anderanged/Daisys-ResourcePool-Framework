#include "defines.hpp"
/* 
// limits, cval, nval, amnt, time, methodO, eParam

return: 
false if rejected, number if not
*/
params["_bound","_cVal","_total","_methodO","_eParams"];
switch (true) do { // check if overflow: priority = bound, <= bound, > bound
	case (_cVal == _bound) : { // is equal to bound?
		// raise event only locally to the obj
		[E_LBOUND,_eParams,0] call FUNC(raiseEvent);
		// return value
		false
	};
	case (_total >= _bound)  : {
		_total
	};
	case (_total < _bound)  : { // is less than bound?
		// reject
		if (_methodO) exitWith {
			[E_REJECT,_eParams,0] call FUNC(raiseEvent);
			false
		};
		// clamp
		[E_CLAMP,_eParams,0] call FUNC(raiseEvent);
		_bound
	};
	default {
		// debug here
		RPT_DTAIL(ERROR,"How did you do that?",__FILE__,__LINE__);
		[E_ERROR,[__FILE__,__LINE__,"ERROR","How did you do that?"],1] call FUNC(raiseEvent);
	};
};