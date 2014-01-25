SUFFIXES = .fumarc .fumarc.cpp

.cpp.fumarc:
	$(top_srcdir)/scripts/file_to_source.sh $< > $@

DISTCLEANFILES = $(BUILT_SOURCES)
