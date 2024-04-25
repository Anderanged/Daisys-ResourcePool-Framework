/*
Macros will be named for their job, for clarity of use.
STANDARD PREFIX LETTERS:
Q 	will always stand for QUOTE. These macros will change any data entered into type <STRING>
P 	will always stand for PREFIX. These macros affix your defined PREFIX to the inputted variable.
S 	will always stand for STRING. These macros only take strings as arguments.
DBG is reserved for under-the-hood DEBUG macros. THese macros are not meant to be called directly.
*/

// creates a string from an inputted variable
#define STR(VAR) #VAR

// concatenating variables / strings
#define JOIN(VAR1,VAR2) VAR1##VAR2
#define QJOIN(VAR1,VAR2) STR(JOIN(VAR1,VAR2))

// joining with joinString
#define SJOIN(one,two,sep) ([one,two] joinString sep)
#define SJOIN3(one,two,three,sep) ([one,two,three] joinString sep)
#define SJOIN4(one,two,three,four,sep) ([one,two,three,four] joinString sep)
#define SJOIN5(one,two,three,four,five,sep) ([one,two,three,four,five] joinString sep)
#define SJOIN6(one,two,three,four,five,six,sep) ([one,two,three,four,five,six] joinString sep)

// joining with format
#define SFORM(one,two) format ["%1, %2",one,two]
#define SFORM3(one,two,three) format ["%1, %2, %3",one,two,three]
#define SFORM4(one,two,three,four) format ["%1, %2, %3, %4",one,two,three,four]
#define SFORM5(one,two,three,four,five) format ["%1, %2, %3, %4, %5",one,two,three,four,five]
#define SFORM6(one,two,three,four,five,six) format ["%1, %2, %3, %4, %5, %6",one,two,three.four,five,six]

// concatenating variables / strings with an underscore
#define UJOIN(VAR1,VAR2) VAR1##_##VAR2
#define QUJOIN(VAR1,VAR2) STR(UJOIN(VAR1,VAR2))
#define SUJOIN(STR1,STR2) ([STR1,STR2] joinString "_")

// adds your defined prefix to a variable. 
#define PVAR(VAR) UJOIN(PREFIX,VAR)
#define QPVAR(VAR) STR(PVAR(VAR))

// concatenates fnc_ at the end of prefix
#define FUNC(NAME) PREFIX##_##fnc##_##NAME

// debug specific manipulation
#define SLOG(string) diag_log text string
#define HNT(string) hint text string

#define DBGFORM(msg) (format ["[%1] (%2) | %3 ",STR(PREFIX),STR(COMPONENT),msg])
#define DBGFORM_FILELINE(msg,file,line) (format ["[%1] (%2) | %3 | %4, %5",STR(PREFIX),STR(COMPONENT),msg,file,line])

// debug macros
#define RPT_BASIC(msg) SLOG(DBGFORM(msg))
#define RPT_DTAIL(msg,file,line) SLOG(DBGFORM_FILELINE(msg,file,line))
#define HINT_BASIC(msg) HNT(DBGFORM(msg))
#define HINT_DTAIL(msg,file,line) HNT(DBGFORM_FILELINE(msg,file,line))

#define ADDON UJOIN(PREFIX,COMPONENT)

// config function macros
#define FPATH(name) COMPONENT##\##functions##\##fn##_##name
#define QFPATH(name) STR(FPATH(name))
#define SQF(name) class name {file = QFPATH(name.sqf);}
#define SQF_PRE(name) class name {file = QFPATH(name.sqf);preInit=1;}
#define SQF_POST(name) class name {file = QFPATH(name.sqf);postInit=1;}
#define SQFC(name) class name {file = QFPATH(name.sqfc);}
#define SQFC_PRE(name) class name {file = QFPATH(name.sqfc);preInit=1;}
#define SQFC_POST(name) class name {file = QFPATH(name.sqfc);postInit=1;}