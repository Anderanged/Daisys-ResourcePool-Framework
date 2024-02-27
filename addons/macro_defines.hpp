/*
Macros will be named for their job, for clarity of use.
STANDARD PREFIX LETTERS:
Q will always stand for QUOTE. These macros will change any data entered into type <STRING>
P will always stand for PREFIX. These macros affix your defined PREFIX to the inputted variable.
*/

// creates a string from an inputted variable
#define STR(VAR) #VAR

// concatenating variables / strings
#define JOIN(VAR1,VAR2) VAR1##VAR2
#define QJOIN(STR1,STR2) STR1 + STR2

// concatenating variables / strings with an underscore
#define UJOIN(VAR1,VAR2) VAR1##_##VAR2
#define QUJOIN(STR1,STR2) STR1 + "_" + STR2

// adds your defined prefix to a variable. 
#define PVAR(VAR) UJOIN(PREFIX,VAR)
#define QPVAR(VAR) STR(PVAR(VAR))

// concatenates fnc_ at the end of prefix
#define FADD fnc
#define PFNC UJOIN(PREFIX,FADD) // DSY_ef_fnc
#define FUNC(NAME) UJOIN(PFNC,NAME) //DSY_ef_fnc_NAME

// debug specific manipulation
#define LABELDEF(LABEL) "["+LABEL+"]"
#define QLINE(LINE) "(Line " + #LINE + ")"
#define LOG(DATA) diag_log DATA
#define QLOG(DATA) LOG(#DATA)

// debug macros
#define RPTDEBUG(FILE,LINE,LABEL,INFO) LOG(QJOIN(QJOIN(QJOIN(STR(PREFIX),FILE),QLINE(LINE)),QJOIN(LABELDEF(LABEL),INFO))))
#define HINTDEBUG(LABEL,INFO) hint QJOIN(LABELDEF(LABEL),INFO)