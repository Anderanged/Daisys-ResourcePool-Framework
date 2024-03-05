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
#define SUJOIN(STR1,STR2) STR1+"_"+STR2

// adds your defined prefix to a variable. 
#define PVAR(VAR) UJOIN(PREFIX,VAR)
#define QPVAR(VAR) STR(PVAR(VAR))

// concatenates fnc_ at the end of prefix
#define PFNC UJOIN(PREFIX,fnc) // DSY_rpf_fnc
#define FUNC(NAME) UJOIN(DSY_rpf_fnc,NAME) //DSY_rpf_fnc_NAME

// debug specific manipulation
#define LABELDEF(LABEL) [##LABEL##]
#define LINEDEF(LINE) (Line:##LINE##)
#define LOG(DATA) diag_log DATA
#define QLOG(DATA) LOG(#DATA)

#define JOIN_DIV(var1,var2) var1##|##var2
#define JOIN3_DIV(var1,var2,var3) var1##|##var2##|##var3
#define QJOIN3_DIV(var1,var2,var3) STR(JOIN3_DIV(var1,var2,var3))
#define SJOIN_DIV(str1,str2) str1 + "|" + str2
// debug macros
#define RPT_BASIC(label,info) LOG(SJOIN_DIV(LABELDEF(label),info))
#define RPT_DTAIL(label,info,file,line) LOG(SJOIN_DIV(QJOIN3_DIV(LABELDEF(label),file,line),info))
//#define DBGJOIN(file,line,label,info) JOIN4_DBG(STR(LABELDEF(label)),STR(file),STR(LINEDEF(line)),info)
