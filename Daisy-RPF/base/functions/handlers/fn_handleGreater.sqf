/* 
// limits, cval, nval, amnt, time, methodO, eParam

return: 
nothing. do it all here!
*/
params["_bound","_cVal","_total","_loopArgs","_methodO","_eParam"];

switch (true) do { // check if overflow
	case (_cVal == _bound) : {[QPVAR(bound),_eParam,0] call FUNC(raiseEvent);};
	case (_total > _bound)  : {
		// reject
		if (_methodO) exitWith {[QPVAR(reject),_eParam,0] call FUNC(raiseEvent);};
		// clamp
		private _tempArray = _loopArgs # 2; // get 3rd element (args array)
		_tempArray set [2,_bound]; // change absolute amount to the bound
		_loopArgs set [2,_tempArray]; // change args array of _loopArgs into [_varName, _amnt, _bound]
		_loopArgs call FUNC(loopPool);
		[QPVAR(clamp),_eParam,0] call FUNC(raiseEvent);
	};
	case (_total <= _bound)  : {
		// loop go here
		_loopArgs call FUNC(loopPool);
		[QPVAR(alter),_eParam,0] call FUNC(raiseEvent);
	};
	default {
		// debug here
		RPTDEBUG(__FILE__,__LINE__,"ERROR","How did you do that?");
		[QPVAR(error),[__FILE__,__LINE__,"ERROR","How did you do that?"],1] call FUNC(raiseEvent);
	};
};