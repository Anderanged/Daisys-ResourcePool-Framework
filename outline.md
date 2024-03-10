implement an energy system and the relevant functions required to allow modders the ability to utilize it for practically ANY purpose.

# Energy System
- able to be initialized on any object
- can be frozen to prevent alteration of resource {DSY_rpf_freeze var and EH}
- can define a loop func to renew or decay the pool over time
- init options:
    - object to init on <OBJ>
        - object
    - custom pool name <STR>
        - "name"
    - limits of pool <ARRAY>
        - [lower, upper]
    - renew/decay/neither deliniator <NUM>
        - static = 0
        - renew  = 1
        - decay  = 2

## Operations
- addition
- subtraction
- [OPTIONAL] multiplication
- [OPTIONAL] division
    - mult and div are both in practice not useful. addition and subtraction are used most frequently.
    - Niche cases for mult and div are at most just interesting, but not practical.
    - Thus, operation deliniator var can be <BOOL>

## Functions
- initPool
    - initializes vars on pool from args
        - args 
            - object to init on <OBJ>
                - obj
            - custom pool name <STR> Default: [DSY_rpf_pool]
                - "name"
            - limits of pool <ARRAY>
                - [lower, upper]
            - renew/decay/neither deliniator <NUM>
                - static = 0
                - renew  = 1
                - decay  = 2
        - vars
            - "name", register for resource amount <NUM>
            - "name_limits", register for limits of pool <ARRAY>
            - "name_frozen", register for frozen property of pool <BOOL>
- alterPool
    - alters resource in a chunk.
        - args
            - object to change pool on <OBJ>
            - pool name <STR>
            - amount <NUM>
            - methods to use <ARRAY>
                - [method Math, method Overflow]
                    - methodMath <BOOL>
                        - addition    = false
                        - subtraction = true
                    - methodOverflow <BOOL>
                        - clamp     = false
                        - reject    = true
### note : this is stupid
    Altering pools should be a one time addition or subtraction action to lesson CPU load. HUD or GUI elements could make use of a smoothing function though. It would load vars into itself and check against them each time it works, and only calls for an alter func once it stops being used (i.e. key stops being held down)
    NOTE: Two types of smoothing functions. One that functions when a key is pressed, and another that functions given a set rate.
        1: Needs to track the total amount increased/decreased to make the call
            E.G. Armor Lock or other functions that have the potential to exit early
        2: Can call once, then call a gui function to smooth the numbers down.
            E.G. A display for your SupplyHub on some item that can display images (billboard とか、texturable thing)
### how to track keystokes?
    1: With addition of CBA Keybinds, we can assign functions to different keys
    Thus, we can have a function that actions on key down and one that actions on key up
    - Activation should start smooth function with player-specified parameters  
    - smoothKeyLoop should be used here:
        - first we grab all vars needed
        - then do all calcs in-loop
        - update display every time
    - Deactivation should break loop and call alter function
EVENTS:
    1: Key pressed
    2: Smoothing function (key press) is called
    3: Smoothing function tracks amount it smooths
- alterPoolSmooth
    - alters resource smoothly over time when given a rate.
        - args
            - object to change pool on <OBJ>
            - pool name <STR>
            - rate of alteration <ARRAY>
                - [amount, time]
                    - amount <NUM>
                    - time (seconds) <NUM>
            - methods to use <ARRAY>
                - [method Math, method Overflow]
                    - methodMath <BOOL>
                        - addition    = false
                        - subtraction = true
                    - methodOverflow <BOOL>
                        - clamp     = false
                        - reject    = true
- loopPool
    - executes a given event while given a loop and continue condition
        - args
            - object to change pool on <OBJ>
            - delay <NUM>
            - arguments <ARRAY>
                - player defined array of args. passed to every code argument.
            - loop condition <CODE>
                - while loop will execute as long as this code returns true
            - continue condition <CODE>
                - while loop will skip execution of event as long as this code returns true
            - event <CODE>
                - event to execute
            - event handler information <ARRAY>
                - [name, arguments]
                    - name of event to call <STR>
                    - arguments to pass to eventHandlers <ARRAY>
# Also COnsider
-   function that allows curators to see current value of Supply Hubs. Put in base? Or GUI?