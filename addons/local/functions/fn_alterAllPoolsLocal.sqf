#include "defines.hpp"
if (isDedicated) exitWith {
	RPT_DTAIL(INFO,"Local functions will not execute on dedicated server.",__FILE__,__LINE__);
	[E_LOCSERV,[__FILE__],1] call FUNC(raiseEvent);
	false
};
private _obj = _this param [0,objNull,[objNull]];
if !(local _obj) exitWith {
	RPT_DTAIL(ERROR,SJOIN3("Object",_obj,"is not local to the current machine. Aborting local function."," "),__FILE__,__LINE__);
	false
};
params [
	"_obj",
	["_amount",0,[0]],
	["_methods",ADD_CLAMP,[[]],2]
];
// grab from hash
private _array = [_obj,"r"] call FUNC(accessHash);
// abort if nothing in hash
if (_array isEqualType false) exitWith {
	RPT_BASIC(INFO,SJOIN3("Object",_obj,"has no resource pools on it. Aborting alteration.",""));
	false
};
_methods params [	
	["_methodM",false,[false,""]],				// default add
	["_methodO",false,[false,""]]				// default clamp
];
{// alter all pools
	[_obj,_x,_amount,_methods] call FUNC(alterPoolLocal);
} forEach _array;
// event
[E_ALTEREDA,[_obj],0] call FUNC(raiseEvent);
RPT_BASIC(INFO,SJOIN5("Object",_obj,"has had all resource pools altered by amount",_amount,"."," "));
true