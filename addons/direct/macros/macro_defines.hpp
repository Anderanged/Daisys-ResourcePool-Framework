/*
Macros will be named for their job, for clarity of use.
STANDARD PREFIX LETTERS:
Q 	will always stand for QUOTE. These macros will change any data entered into type <STRING>
P 	will always stand for PREFIX. These macros affix your defined PREFIX to the inputted variable.
S 	will always stand for STRING. These macros only take strings as arguments.
DBG is reserved for under-the-hood DEBUG macros. THese macros are not meant to be called directly.
*/

// creates a string from an inputted variable
#undef QUOTE
#define QUOTE(VAR) #VAR
/* UNUSED ATM. KEPT FOR POSSIBLE NECESSITY
// concatenating variables / strings
#undef JOIN
#undef QJOIN
#define JOIN(VAR1,VAR2) VAR1##VAR2
#define QJOIN(VAR1,VAR2) QUOTE(JOIN(VAR1,VAR2))
*/
// joining with joinString
#undef SJOIN
#undef SJOIN3
#undef SJOIN4
#undef SJOIN5
#undef SJOIN6
#define SJOIN(one,two,sep) ([one,two] joinString sep)
#define SJOIN3(one,two,three,sep) ([one,two,three] joinString sep)
#define SJOIN4(one,two,three,four,sep) ([one,two,three,four] joinString sep)
#define SJOIN5(one,two,three,four,five,sep) ([one,two,three,four,five] joinString sep)
#define SJOIN6(one,two,three,four,five,six,sep) ([one,two,three,four,five,six] joinString sep)

// joining with format
#undef SFORM
#undef SFORM3
#undef SFORM4
#undef SFORM5
#undef SFORM6
#define SFORM(one,two) format ["%1 %2",one,two]
#define SFORM3(one,two,three) format ["%1 %2 %3",one,two,three]
#define SFORM4(one,two,three,four) format ["%1 %2 %3 %4",one,two,three,four]
#define SFORM5(one,two,three,four,five) format ["%1 %2 %3 %4 %5",one,two,three,four,five]
#define SFORM6(one,two,three,four,five,six) format ["%1 %2 %3 %4 %5 %6",one,two,three,four,five,six]

// concatenating variables / strings with an underscore
#undef UJOIN
#undef QUJOIN
#undef SUJOIN
#define UJOIN(var1,var2) var1##_##var2
#define QUJOIN(var1,var2) QUOTE(UJOIN(var1,var2))
#define SUJOIN(str1,str2) SJOIN(str1,str2,"_")

#undef ADDON
#undef CLASSDEF
#define ADDON UJOIN(PREFIX,COMPONENT)
#define CLASSDEF(name) UJOIN(ADDON,name)

// adds your defined prefix to a variable. 
#undef PVAR
#undef QPVAR
#define PVAR(var) UJOIN(PREFIX,var)
#define QPVAR(var) QUOTE(PVAR(var))

// concatenates fnc_NAME at the end of addon
#undef FUNC
#define FUNC(name) ADDON##_fnc_##name

// shorthand for compileScript
#define COMPILE(path) compileScript['##path##']

// debug specific manipulation
#undef SLOG
#undef HNT
#define SLOG(string) diag_log text string
#define HNT(string) hint text string
/* ECLIPSED BY INFO,WARN,ERROR,FATAL
#undef DBGFORM
#undef DBGFORM_FILELINE
#define DBGFORM(msg) (format ["[%1] (%2) :: %3 ",QUOTE(PREFIX),QUOTE(COMPONENT),msg])
#define DBGFORM_FILELINE(msg,file,line) (format ["[%1] (%2) :: %3 |File %4, Line %5|",QUOTE(PREFIX),QUOTE(COMPONENT),msg,file,line])

// debug macros
#undef RPT_BASIC
#undef RPT_DTAIL
#undef HINT_BASIC
#undef HINT_DTAIL
#define RPT_BASIC(msg) SLOG(DBGFORM(msg))
#define RPT_DTAIL(msg,file,line) SLOG(DBGFORM_FILELINE(msg,file,line))
#define HINT_BASIC(msg) HNT(DBGFORM(msg))
#define HINT_DTAIL(msg,file,line) HNT(DBGFORM_FILELINE(msg,file,line))
*/
#undef INFO
#undef WARN
#undef ERROR
#undef FATAL
#define INFO(msg) SLOG((format ["[%1] (%2) INFO: %3 ",QUOTE(PREFIX),QUOTE(COMPONENT),msg]))
#define WARN(msg) SLOG((format ["[%1] (%2) WARNING: %3 ",QUOTE(PREFIX),QUOTE(COMPONENT),msg]))
#define ERROR(msg) SLOG((format ["[%1] (%2) ERROR: %3 ",QUOTE(PREFIX),QUOTE(COMPONENT),msg]))
#define FATAL(msg,file,line) private _uMsg = (format ["[%1] (%2) FATAL: %3 |File %4, Line %5|",QUOTE(PREFIX),QUOTE(COMPONENT),msg,file,line])); SLOG(_uMsg); HNT(_uMsg)

// cfgFunctions macros
#undef FPATH
#undef QFPATH
#undef SQF
#undef SQF_PRE
#undef SQF_POST
#undef SQFC
#undef SQFC_PRE
#undef SQFC_POST
#define FPATH(name) COMPONENT##\##functions##\##fn##_##name
#define QFPATH(name) QUOTE(FPATH(name))
#define SQF(name) class name {file = QFPATH(name.sqf);}
#define SQF_PRE(name) class name {file = QFPATH(name.sqf);preInit=1;}
#define SQF_POST(name) class name {file = QFPATH(name.sqf);postInit=1;}
#define SQFC(name) class name {file = QFPATH(name.sqfc);}
#define SQFC_PRE(name) class name {file = QFPATH(name.sqfc);preInit=1;}
#define SQFC_POST(name) class name {file = QFPATH(name.sqfc);postInit=1;}

// filePath macros
#undef PATH_COMPONENT
#undef SYS_FPATH
#undef SYS_FPATH_SUBF
#define PATH_COMPONENT \MAINPREFIX\PREFIX\addons\COMPONENT
#define SYS_FPATH(name,type) PATH_COMPONENT##\##name##.##type
#define SYS_FPATH_SUBF(subfolder,name,type) PATH_COMPONENT##\subfolder\name.type