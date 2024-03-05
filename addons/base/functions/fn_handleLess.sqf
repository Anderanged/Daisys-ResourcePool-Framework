#include "defines.hpp"
/* 
// limits, cval, nval, amnt, time, methodO, eParam

return: 
true if rejected, number if not
*/
params["_bound","_cVal","_total","_methodO","_eParams"];
switch (true) do { // check if overflow: priority = bound, <= bound, > bound
	case (_cVal == _bound) : { // is equal to bound?
		// raise event only locally to the obj
		[QPVAR(bound),_eParams,0] call FUNC(raiseEvent);
		// return value
		true;
	};
	case (_total >= _bound)  : {
		[QPVAR(alter),_eParams,0] call FUNC(raiseEvent);
		_total;
	};
	case (_total < _bound)  : { // is less than bound?
		// reject
		if (_methodO) exitWith {
			[QPVAR(reject),_eParams,0] call FUNC(raiseEvent);
			true;
		};
		// clamp
		[QPVAR(clamp),_eParams,0] call FUNC(raiseEvent);
		_total;
	};
	default {
		// debug here
		RPT_DTAIL(ERROR,"How did you do that?",__FILE__,__LINE__);
		[QPVAR(error),[__FILE__,__LINE__,"ERROR","How did you do that?"],0] call FUNC(raiseEvent);
	};
};