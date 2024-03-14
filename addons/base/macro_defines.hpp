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

#define SJOIN(one,two,sep) ([one,two] joinString sep)
#define SJOIN3(one,two,three,sep) ([one,two,three] joinString sep)
#define SJOIN4(one,two,three,four,sep) ([one,two,three,four] joinString sep)
#define SJOIN5(one,two,three,four,five,sep) ([one,two,three,four,five] joinString sep)
#define SJOIN6(one,two,three,four,five,six,sep) ([one,two,three,four,five,six] joinString sep)

// concatenating variables / strings with an underscore
#define UJOIN(VAR1,VAR2) VAR1##_##VAR2
#define QUJOIN(VAR1,VAR2) STR(UJOIN(VAR1,VAR2))
#define SUJOIN(STR1,STR2) ([STR1,STR2] joinString "_")

// adds your defined prefix to a variable. 
#define PVAR(VAR) UJOIN(PREFIX,VAR)
#define QPVAR(VAR) STR(PVAR(VAR))

// concatenates fnc_ at the end of prefix
#define PFNC UJOIN(PREFIX,fnc) // DSY_rpf_fnc
#define FUNC(NAME) UJOIN(DSY_rpf_fnc,NAME) //DSY_rpf_fnc_NAME

// debug specific manipulation
#define ERROR "[ERROR]"
#define INFO "[INFO]"
#define LOG(data) diag_log data

// debug macros
#define RPT_BASIC(label,info) LOG(SJOIN(label,info,"|"))
#define RPT_DTAIL(label,info,file,line) LOG(SJOIN4(label,info,file,line,"|"))
#define HINT_BASIC(label,info) hint SJOIN(label,info,"|")
#define HINT_DTAIL(label,info,file,line) hint SJOIN4(label,info,file,line,"|"))

#define ADDON UJOIN(PREFIX,COMPONENT)