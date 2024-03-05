/*
Macros will be named for their job, for clarity of use.
STANDARD PREFIX LETTERS:
Q will always stand for QUOTE. These macros will change any data entered into type <STRING>
P will always stand for PREFIX. These macros affix your defined PREFIX to the inputted variable.
S will always stand for STRING. These macros only take strings as arguments.
*/

// creates a string from an inputted variable
#define STR(VAR) #VAR

// concatenating variables / strings
#define JOIN(VAR1,VAR2) VAR1##VAR2
#define QJOIN(VAR1,VAR2) STR(JOIN(VAR1,VAR2))
//#define SJOIN(STR1,STR2) STR1 + STR2

// concatenating variables / strings with an underscore
#define UJOIN(VAR1,VAR2) VAR1##_##VAR2
#define QUJOIN(VAR1,VAR2) STR(UJOIN(VAR1,VAR2))
#define SUJOIN(STR1,STR2) STR1##"_"##STR2

// adds your defined prefix to a variable. 
#define PVAR(VAR) UJOIN(PREFIX,VAR)
#define QPVAR(VAR) STR(PVAR(VAR))

// concatenates fnc_ at the end of prefix
#define PFNC UJOIN(PREFIX,fnc) // DSY_rpf_fnc
#define FUNC(NAME) UJOIN(PFNC,NAME) //DSY_rpf_fnc_NAME
//#define FNC_PREF functions\fnc_
//#define FNC_SFFX .sqf
//#define FNC_FILE(NAME) STR(JOIN(JOIN(FNC_PREF,NAME),FNC_SFFX))
//#define FNC_FILE(NAME) STR(UJOIN(functions\fnc,NAME).sqf)

#define FNC_CLASS(NAME) class NAME {\
	file = STR(UJOIN(x\Daisys-ResourcePool-Framework\addons\base\functions\fnc,NAME).sqf);\
	recompile = 1;\
}
#define FNC_CLASS_EXT(NAME,PRE,POST,START) class NAME {\
    file = STR(UJOIN(functions\fnc,NAME).sqf);\
	preInit = PRE;\
	postInit = POST;\
	preStart = START;\
	recompile = 1;\
}

// debug specific manipulation
#define LABELDEF(LABEL) "["+LABEL+"]"
#define QLINE(LINE) "(Line " + #LINE + ")"
#define LOG(DATA) diag_log DATA
#define QLOG(DATA) LOG(#DATA)

// debug macros
#define RPTDEBUG(FILE,LINE,LABEL,INFO) LOG(QJOIN(QJOIN(QJOIN(STR(PREFIX),FILE),QLINE(LINE)),QJOIN(LABELDEF(LABEL),INFO))))
#define HINTDEBUG(LABEL,INFO) hint QJOIN(LABELDEF(LABEL),INFO)