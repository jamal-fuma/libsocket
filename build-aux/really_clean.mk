REALLYCLEAN_FILES = $(top_srcdir)/m4/argz.m4    \
		    $(top_srcdir)/m4/libtool.m4         \
		    $(top_srcdir)/m4/ltdl.m4            \
		    $(top_srcdir)/m4/ltoptions.m4       \
		    $(top_srcdir)/m4/ltsugar.m4         \
		    $(top_srcdir)/m4/ltversion.m4       \
		    $(top_srcdir)/m4/lt~obsolete.m4     \
		    $(top_srcdir)/build-aux/depcomp     \
		    $(top_srcdir)/build-aux/install-sh  \
		    $(top_srcdir)/build-aux/ltmain.sh   \
		    $(top_srcdir)/build-aux/missing	\
		    $(top_srcdir)/config.guess		\
		    $(top_srcdir)/config.h.in		\
		    $(top_srcdir)/config.h.in~		\
		    $(top_srcdir)/config.sub		\
		    $(top_srcdir)/aclocal.m4 \
		    $(top_srcdir)/autom4te.cache/output.0 \
		    $(top_srcdir)/autom4te.cache/output.1\
		    $(top_srcdir)/autom4te.cache/requests\
		    $(top_srcdir)/autom4te.cache/traces.0\
		    $(top_srcdir)/autom4te.cache/traces.1

reallyclean: maintainer-clean
	rm -f $(REALLYCLEAN_FILES)
	rm -rf $(top_srcdir)/autom4te.cache
	rm -rf $(top_builddir)/assets
	rm -rf $(top_builddir)/source
	rm -rf $(top_builddir)/tests
	rm -f $(top_builddir)/errors
	rm -f $(top_builddir)/log
