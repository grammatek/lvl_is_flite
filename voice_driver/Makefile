# Makefile replacement for main Flite Makefile

SHFLAGS=true
TOP=$(FLITEDIR)
DIRNAME=flite
VOICENAME=lvl_is_f
VOICETYPE=clunits

FLITE_LANG=lvl_is_lang
FLITE_LEX=lvl_is_lex
LOCAL_INCLUDES = -I$(TOP)/lang/$(FLITE_LANG) -I$(TOP)/lang/$(FLITE_LEX)
LOCAL_LANGLEX_LIBS = -lflite_$(FLITE_LANG) -lflite_$(FLITE_LEX)
LOCAL_LIBS = -L . -l$(VOICENAME) 
H = 

CSRCS = $(VOICENAME).c

VOICES=$(VOICENAME)

## Clunits/ldom
CSRCS += $(VOICENAME)_clunits.c
CSRCS += $(VOICENAME)_cltrees.c $(VOICENAME)_lpc.c $(VOICENAME)_mcep.c
CSRCS += $(VOICENAME)_cl_durmodel.c
MCEPSRCS = $(shell if [ -f $(VOICENAME)_mcep_000.c ]; then ls $(VOICENAME)_mcep_*.c ; fi)
MCEPOBJS = $(MCEPSRCS:.c=.o)
LPCSRCS= $(shell if [ -f $(VOICENAME)_lpc_000.c ] ; then ls $(VOICENAME)_lpc_*.c; fi )
LPCOBJS = $(LPCSRCS:.c=.o)
RESSRCS= $(shell if [ -f $(VOICENAME)_res_000.c ] ; then ls $(VOICENAME)_res_*.c; fi )
RESOBJS = $(RESSRCS:.c=.o)

OBJS = $(CSRCS:.c=.o) $(LPCOBJS) $(MCEPOBJS) $(RESOBJS) 
CFLAGS=$(CFLAGS) -W
ALL = lib$(VOICENAME).a flite_$(VOICENAME)

ifdef SHFLAGS
ALL += lib$(VOICENAME).so
ALL += flite_dyn_$(VOICENAME)
endif

include $(FLITEDIR)/config/common_make_rules

LIBDIR=.

$(VOICENAME)_lpc.o: $(VOICENAME)_lpc.c
	$(CC) $(CFLAGS) -I. -I$(FLITEDIR)/include -c -o $@ $<

$(VOICENAME)_mcep.o: $(VOICENAME)_mcep.c
	$(CC) $(CFLAGS) -I. -I$(FLITEDIR)/include -c -o $@ $<

flite_$(VOICENAME): flite_main.o flite_voice_list.o flite_lang_list.o $(FLITELIBS) lib$(VOICENAME).a
	$(CC) $(CFLAGS) -o $@ flite_main.o flite_voice_list.o flite_lang_list.o $(LOCAL_LIBS)  $(LOCAL_LANGLEX_LIBS) $(FLITELIBFLAGS) $(LDFLAGS)

lib$(VOICENAME).a: $(OBJS)
	@ $(AR) cruv lib$(VOICENAME).a $(OBJS)
	@ $(RANLIB) lib$(VOICENAME).a
	@ touch .build_lib

flite_dyn_$(VOICENAME): flite_main.o flite_voice_list.o flite_lang_list.o lib$(VOICENAME).so
	$(CC) $(CFLAGS) -o $@ flite_main.o flite_voice_list.o flite_lang_list.o $(LOCAL_LIBS)  $(LOCAL_LANGLEX_LIBS) $(FLITELIBFLAGS) $(LDFLAGS)

lib$(VOICENAME).so: $(OBJS) $(FLITELIBS) flite_voice_list.o flite_lang_list.o voice_driver.o
	$(CC) -shared $(OBJS) flite_voice_list.o flite_lang_list.o voice_driver.o $(FLITELIBFLAGS) $(LOCAL_LANGLEX_LIBS) $(LDFLAGS) -o $@
	@ touch .build_lib

flite_voice_list.c:
	$(TOP)/tools/make_voice_list $(VOICES)

flite_lang_list.c:
	$(TOP)/tools/make_lang_list $(FLITE_LANG) $(FLITE_LEX)
