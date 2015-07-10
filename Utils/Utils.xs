#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "precis_utils.c"

MODULE = Unicode::Precis::Utils		PACKAGE = Unicode::Precis::Utils

SV *
_map(string)
	SV *string
    PROTOTYPE: $
    ALIAS:
	foldCase       = 1 
	mapSpace       = 2
	decomposeWidth = 3
    PREINIT:
	char *buf, *new = NULL;
	STRLEN buflen, newlen;
    CODE:
	if (SvOK(string))
	    buf = SvPV(string, buflen);
	else
	    XSRETURN_UNDEF;

	newlen = _map((U8 **)&new, (U8 *)buf, buflen, ix);
	if (new == NULL)
	    XSRETURN_UNDEF;

	sv_setpvn(string, new, newlen);
	free(new);
	RETVAL = string;
	SvREFCNT_inc(string);
    OUTPUT:
	RETVAL

