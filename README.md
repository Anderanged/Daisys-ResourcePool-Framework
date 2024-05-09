This work is licensed under the Arma Public License - Share Alike <br><a rel="license" href="https://www.bohemia.net/community/licenses/arma-public-license-share-alike" target="_blank" ><img src="https://data.bistudio.com/images/license/APL-SA.png" > </a>

# [RPF] Resource Pool Framework 

![rpf_icon_128](https://github.com/Anderanged/Daisys-ResourcePool-Framework/assets/92063434/fc885392-e5a0-422b-8238-9041e78252a8)

This repository documents the addons for the Arma 3 Mod with the above name. 

## Purpose

Certain addons may want to incorporate an action or ability that has a cost, or draws from a pool of some resource. Generally, any incorporation of this cost-based ability requires in-mod development of its own system of a resource pool to draw from, a subtraction and/or addition function, limits, etc. This all results in many decentralized systems used to manage individual resource pools and their alterations. Resource Pool Framework aims to centrilize all the systems necessary for creation, management, and interaction with resource pools into a scriptable framework that can be easily optimized with minimal change to dependent mods.

Feature and optimization suggestions, as well as general bug reports and feedback, are greatly [appreciated and encouraged.](https://github.com/Anderanged/Daisys-ResourcePool-Framework/wiki/Bug-Reporting-and-Community-Contributions) 

## Links

[Wiki](https://github.com/Anderanged/Daisys-ResourcePool-Framework/wiki)

[Function Library](https://anderanged.github.io/Daisys-ResourcePool-Framework/)

[Bug Reporting & Contributing](https://github.com/Anderanged/Daisys-ResourcePool-Framework/wiki/Bug-Reporting-and-Community-Contributions)

## Roadmap

#### Published Addons:

- base
> Provides base functionalities. Creation, removal, subtraction, addition, automatic renewal/decay, etc. All CBA Events take place on the server.
- local
> Provides local functionalities. Almost identical to base, but does not broadcast anything over the network (information of the pool is not shared), besides the existence of the pool. All CBA Events take place on the local machine.
- qol
> Provides Quality of Life functions. Allows manual changing of pool variables, and automatic calls for renew/decay with the change. Provides both local and server events.

#### In-Progress Addons:

- gui
> Provides functions specifically to work with GUI elements. Mainly supports smooth incrementation for both key actions and script calls.
- modules
> Provides modules to allow usage of the framework in non-scripting (Eden Editor) environments.
- namespace
> provides a script framework to create and manage resource pools within a namespace.

