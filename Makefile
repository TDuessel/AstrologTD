# Astrolog (Version 7.60) File: Makefile (Unix version)
#
# IMPORTANT NOTICE: Astrolog and all chart display routines and anything
# not enumerated elsewhere in this program are Copyright (C) 1991-2023 by
# Walter D. Pullen (Astara@msn.com, http://www.astrolog.org/astrolog.htm).
# Permission is granted to freely use, modify, and distribute these
# routines provided these credits and notices remain unmodified with any
# altered or distributed versions of the program.
#
# First created 11/21/1991.
#
# This Makefile is for building the Linux/X11 version of Astrolog 7.60
# aswell as the Windows version with the MinGW compiler. For this the
# MinGW has to be accessible in your path and to run astrolog.exe you
# need Wine (version 9.0 does it). First target is the Linux version
# and the Windows version can be build with 'make win'.
#
# The 'PC', 'WIN', 'GRAPH', 'X11' definitions in astrolog.h have to be
# outcommented there because they are defined from here accordingly.
# Some little modifications need to be in place in the original sources
# in order to run through with MinGW.
#
# First in 'wdriver.cpp':
# Some min() and max() macros somehow found with MS Visual Bla bla
# aren't available in MinGW, so we use the local definitions which
# are used anywhere else in the code.
#
# Second an explicit cast in 'wdriver.cpp', line 2677:
# ...(char *)(!wi.fAutoSaveWire...)
# avoids -fpermissive for the compiler
#
# Modified 02/18/2024.

NAME_linux = astrolog
NAME_mingw = astrolog.exe

OBJDIR_linux := objs_linux
OBJDIR_mingw := objs_mingw

OBJS := $(patsubst %.cpp,%.o, $(wildcard *.cpp))
OBJS_linux := $(addprefix $(OBJDIR_linux)/, $(OBJS))
OBJS_mingw := $(addprefix $(OBJDIR_mingw)/, $(OBJS))
OBJS_mingw += $(addprefix $(OBJDIR_mingw)/, astrolog.res)

# Don't use -s and when using -g!
#CXXFLAGS = -O -Wno-write-strings -Wno-narrowing -Wno-comment
CXXFLAGS = -O -Wno-write-strings -g
CPPFLAGS = -D X11 -D GRAPH
LDFLAGS = -lm -lX11 -ldl

# Make sure MinGW is in your path:
CC_mingw = x86_64-w64-mingw32-cc
CXX_mingw = x86_64-w64-mingw32-c++
RC_mingw = x86_64-w64-mingw32-windres
AR_mingw = x86_64-w64-mingw32-ar

CXXFLAGS_mingw = -Wno-write-strings
CPPFLAGS_mingw = -D PC -D WIN -D GRAPH
RCFLAGS_mingw = -O coff

LDFLAGS_mingw = -mwindows

DLLS_mingw := comdlg32 shell32 shlwapi user32 gdi32 advapi32 comctl32 msvcrt
DLLS_mingw += odbc32 ole32 oleaut32 winspool odbccp32
DLLS_mingw += uuid

$(OBJDIR_linux)/%.o: %.cpp *.h | $(OBJDIR_linux)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

$(OBJDIR_mingw)/%.o: %.cpp *.h | $(OBJDIR_mingw)
	$(CXX_mingw) $(CPPFLAGS_mingw) $(CXXFLAGS_mingw) -c -o $@ $<

$(OBJDIR_mingw)/%.res: %.rc | $(OBJDIR_mingw)
	$(RC_mingw) $(RCFLAGS_mingw) -o $@ $<

$(NAME_linux): $(OBJS_linux) 
	$(CC) $(LDFLAGS) -o $@ $^

$(NAME_mingw): $(OBJS_mingw) 
	$(CXX_mingw) $(LDFLAGS_mingw) -o $@ $^ $(DLLS_mingw:%=-l%)

$(OBJDIR_linux) $(OBJDIR_mingw):
	mkdir $@

win: $(NAME_mingw)

.PHONY: clean distclean

clean:
	$(RM) $(OBJS_linux)
	$(RM) $(OBJS_mingw)

distclean:
	$(RM) -r $(OBJDIR_linux)
	$(RM) -r $(OBJDIR_mingw)
	$(RM) $(NAME_linux)
	$(RM) $(NAME_mingw)
