
AM_CFLAGS = -Wall -W -Werror -pedantic -Wno-long-long -Wno-unused -Wno-multichar -std=c99 $(YYAST_CFLAGS)
AM_YFLAGS = -d

DEFAULT_INCLUDES=-I$(top_builddir)

BUILT_SOURCES = parser.h

bin_PROGRAMS = taulap

taulap_SOURCES = lexer.l parser.y
taulap_LDADD = $(YYAST_LIBS)

