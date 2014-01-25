#!/bin/bash
export CXX="${CCACHE} g++"
export CC="${CCACHE} gcc"

# extract version of build
project_with_version=`grep AC_INIT configure.ac | cut -f 2,3 -d '[' | cut -f 1,2 -d ']' | sed -e 's/\],\[/-/'`
project=`grep AC_INIT configure.ac | cut -f 2 -d '[' | cut -f 1 -d ']' | sed -e 's/\],\[/-/'`

# serialise extracted version of build
echo "${project_with_version}" > version.txt
echo "Building ${project_with_version}"

# cross-configure
autoreconf -fvi
mkdir -p build-native/root;

PREFIX="/usr/local";
cd build-native;
../configure                                                            \
    --prefix=${PREFIX}                                                  \
    --enable-maintainer-mode                                            \
    --with-libevent2-lib-dir=/Users/me/workspace/fake-ec2/lib/staging/usr/local/lib          \
    --with-libevent2-include-dir=/Users/me/workspace/fake-ec2/lib/staging/usr/local/include          \
    2>&1 | tee build.log

make ctags
make
DESTDIR=`pwd`/root make install
# hack so the files depended on by tests are in place
exit $?
