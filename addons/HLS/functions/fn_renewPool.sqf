#include "\DSY-RPF\defines.hpp"
// obj, delay, args, loopcon, contcon, event, ehInfo
params [
	["_obj",objNull,[objNull]],
	["_varName",QPVAR(pool),[""]],
	["_rate",[],[[]]], 
	["_methods",[],[[]]]
];
private _time = _rate param [1,1,[0],2];
[
	_obj,
	_time,
	[_obj,_varName,_rate,_methods],
	{true},
	{false},
	{
		_args = param [1,[],[[]]];
		_args call FUNC(alterPool);
	},
	[QPVAR(renewed),[_obj,_varName,_rate,_methods]]
] call FUNC(loopPool);

