#include "macro_defines.hpp"

#define PREFIX DSY_rpf

#define RPFLIM_MAX 16384 // 2^14

#define LOOPCON_C STR(params[["_args",[],[[]]],["_i",0,[0]]];_i < 1;)
#define LOOPCON_S STR(params[["_args",[],[[]]],["_i",0,[0]]];_i < (_args # 2);)
