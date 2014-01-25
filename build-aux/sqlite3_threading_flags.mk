# not using threading on this app so don't bother with the thread safe version
SQLITE_THREADING_FLAGS= -DSQLITE_THREADSAFE=0 -DSQLITE_OMIT_LOAD_EXTENSION=1
