# DSY_rpf_fnc_raiseEvent
You may absolutely take and use this in your own mods if you like. No credit necessary.
## Use

Shorthand method of calling CBA Events on different machines.



## Parameters
- Index 0: *_name*
    - \<STRING\> Desc
- Index 1: *_params*
    - \<ARRAY\> Desc
- Index 2: *_type*
    - \<NUMBER\> The type of event.
    - Types of events are:
        - 0 : [local event](https://cbateam.github.io/CBA_A3/docs/files/events/fnc_localEvent-sqf.html)
        - 1 : [server event](https://cbateam.github.io/CBA_A3/docs/files/events/fnc_serverEvent-sqf.html)
        - 2 : [global event](https://cbateam.github.io/CBA_A3/docs/files/events/fnc_globalEvent-sqf.html)
        - 3 : [global event (JIP)](https://cbateam.github.io/CBA_A3/docs/files/events/fnc_globalEventJIP-sqf.html)
        - 4 : [remote event](https://cbateam.github.io/CBA_A3/docs/files/events/fnc_remoteEvent-sqf.html)
        - 5 : [target event](https://cbateam.github.io/CBA_A3/docs/files/events/fnc_targetEvent-sqf.html)
        - 6 : [turret event](https://cbateam.github.io/CBA_A3/docs/files/events/fnc_turretEvent-sqf.html)

## Return

none

## Example

    // raises "eventName" on the local machine and passes [_param1,_param2] to the event handler function (see below)
    ["eventName",[_param1,_param2],0] call DSY_rpf_fnc_raiseEvent;

[Event Handlers (Bohemia)](https://community.bistudio.com/wiki/Arma_3:_Event_Handlers)

[Event Handlers (CBA)](https://cbateam.github.io/CBA_A3/docs/files/events/fnc_addEventHandler-sqf.html)

## Events

none
***