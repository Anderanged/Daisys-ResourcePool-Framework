
params["_name","_params","_type"];
// 0 = local, 1 = server, 2 = global, 3 = globalJIP, 4 = remote, 5 = target, 6 = turret, 
switch (_type) do {
	case 0:{[_name,_params] call CBA_fnc_localEvent;};
	case 1:{[_name,_params] call CBA_fnc_serverEvent;};
	case 2:{[_name,_params] call CBA_fnc_globalEvent;};
	case 3:{[_name,_params] call CBA_fnc_globalEventJIP;};
	case 4:{[_name,_params] call CBA_fnc_remoteEvent;};
	case 5:{[_name,_params] call CBA_fnc_targetEvent;};
	case 6:{[_name,_params] call CBA_fnc_turretEvent;};
}
