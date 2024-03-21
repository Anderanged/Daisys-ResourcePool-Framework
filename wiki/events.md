## Server Events
The below CBA events are raised on the server machine.
###  Function Actions:
freezePool
#### DSY_rpf_onIce
#### DSY_rpf_freeze
#### DSY_rpf_unfreeze
handleGreater/Less
#### DSY_rpf_uBound
#### DSY_rpf_lBound
#### DSY_rpf_reject
#### DSY_rpf_clamp
alterPool
#### DSY_rpf_altered
#### DSY_rpf_alteredAll
RemovePool/AllPool
#### DSY_rpf_removed
#### DSY_rpf_removedAll
Renew/Decay
#### DSY_rpf_renewed
#### DSY_rpf_decayed
Edited Pool
#### DSY_rpf_edited
InitPool
#### DSY_rpf_repeatPool
#### DSY_rpf_created

###  Errors:
#### DSY_rpf_error
#### DSY_rpf_locOnServer

## Local Events
The below CBA events are raised on **only** the local machine executing the function.

###  Function Actions:
#### DSY_rpf_onIce
#### DSY_rpf_freeze
#### DSY_rpf_unfreeze
#### DSY_rpf_uBound
#### DSY_rpf_lBound
#### DSY_rpf_reject
#### DSY_rpf_clamp
#### DSY_rpf_alter
#### DSY_rpf_removed
#### DSY_rpf_renewed
#### DSY_rpf_decayed