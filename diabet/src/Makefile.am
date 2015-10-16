NULL = 

ACLOCAL_AMFLAGS = -I m4

DISTCHECK_CONFIGURE_FLAGS = --enable-introspection

lib_LTLIBRARIES = libdiabet.la

AM_CFLAGS = \
	    -I$(top_srcdir)/src \
	    @DIABET_CFLAGS@ \
	    $(GLIB_CFLAGS) 

AM_LDFLAGS = @DIABET_LIBS@

pkgdatadir = $(datadir)/diabet
pkglibdir = $(libdir)/diabet
libdiabetincludedir = $(includedir)/diabet
libdiabetinclude_HEADERS = $(top_srcdir)/src/diabet.h

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = $(top_srcdir)/diabet.pc

diabet_header = $(top_srcdir)/src/diabet.h
diabet_vapi_file = Diabet-1.0.vapi
diabet_gir_file = Diabet-1.0.gir

libdiabet_la_SOURCES = \
		     diab.vala \
		     person.vala \
		     person_manager.vala \
		     bolus_manager.vala \
		     bolus_history_manager.vala \
		     exceptions.vala \
		     $(NULL)
			  
libdiabet_la_LDFLAGS = -module -export-dynamic @DIABET_ABI_MAJOR@:0:0
libdiabet_la_LIBADD = @DIABET_LIBS@ 

src_libdiabet_la_CPPFLAGS = \
			  -I$(top_srcdir)/src \
			  -DG_LOG_DOMAIN=\"Diabet\"

AM_VALAFLAGS = --vapi=$(diabet_vapi_file) --vapidir=$(top_srcdir)/src  -H $(diabet_header) --gir=$(diabet_gir_file) --library diabet

CLEANFILES = \
	     $(diabet_vapi_file) \
	     $(diabet_header) \
	     libdiabet_la_vala.stamp \
	     $(libdiabet_la_SOURCES:.vala=.c) \
	     $(diabet_gir_file) \
	     $(NULL)

EXTRA_DIST = \
	     $(diabet_vapi_file) \
	     diabet.pc.in \
	     m4/introspection.m4 \
	     $(NULL)

vapidir = $(datadir)/vala/vapi
vapi_DATA = \
	    $(top_srcdir)/src/$(diabet_vapi_file) \
	    $(NULL)

-include $(INTROSPECTION_MAKEFILE)
INTROSPECTION_COMPILER_ARGS = --includedir=$(srcdir)

if HAVE_INTROSPECTION
INTROSPECTION_CFLAGS += $(AM_CFLAGS)
introspection_sources = $(libdiabet_la_SOURCES)
DIABET-1.0.gir: $(lib_LTLIBRARIES)
DIABET_1_0_gir_INCLUDES = GObject-2.0
DIABET_1_0_gir_CFLAGS = $(AM_CFLAGS)
DIABET_1_0_gir_LIBS = $(lib_LTLIBRARIES)
DIABET_1_0_gir_FILES = $(addprefix $(srcdir)/,$(introspection_sources))
DIABET_1_0_gir_PACKAGES = gobject-2.0 
introspection_file = Diabet-1.0.gir
girdir = $(datadir)/gir-1.0
gir_DATA = $(introspection_file)

typelibsdir = $(libdir)/girepository-1.0
typelibs_DATA = $(introspection_file:.gir=.typelib)
CLEANFILES += $(dist_gir_DATA) $(typelibs_DATA)
endif

