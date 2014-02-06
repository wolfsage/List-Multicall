#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

/* Most of this code pulled from List::Util. Thank you! */

#if PERL_BCDVERSION >= 0x5006000
#  include "multicall.h"
#endif

#ifndef CvISXSUB
#  define CvISXSUB(cv) CvXSUB(cv)
#endif

MODULE = List::Multicall		PACKAGE = List::Multicall		

void
multicall(block,...)
    SV *block
PROTOTYPE: $@
PPCODE:
{
    GV *gv;
    HV *stash;
    SV **args = &PL_stack_base[ax];
    CV *cv    = sv_2cv(block, &stash, &gv, 0);

    if(cv == Nullcv)
        croak("Not a subroutine reference");

    SAVESPTR(GvSV(PL_defgv));

    if(!CvISXSUB(cv)) {
        dMULTICALL;
        I32 gimme = G_SCALAR;
        int index;

        PUSH_MULTICALL(cv);
        for(index = 1; index < items; index++) {
            GvSV(PL_defgv) = args[index];

            MULTICALL;
        }
        POP_MULTICALL;
    }
    else
    {
        int index;
        for(index = 1; index < items; index++) {
            dSP;
            GvSV(PL_defgv) = args[index];

            PUSHMARK(SP);
            call_sv((SV*)cv, G_VOID);
        }
    }
}
