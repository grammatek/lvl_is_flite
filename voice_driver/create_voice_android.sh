#!/bin/bash

# This script creates Android voice from a previous successful run of a
# natively compiled voice build

set -euo pipefail

CURDIR=`pwd`
VOICE_OUTPUT_DIR=${CURDIR}/voice_deliverables
MAKEFILE_SNIPPET=${CURDIR}/flite/Makefile.android.in

# prepare voice building
mkdir -p ${VOICE_OUTPUT_DIR}
cp ${CURDIR}/voice_driver/Makefile ${MAKEFILE_SNIPPET}
cp ${CURDIR}/voice_driver/voice_driver* flite

# build voice for all Android platforms
pushd flite

# Available target platforms:
#   - aarch64-linux-android
#   - armv7a-linux-androideabi
#   - i686-linux-android
#   - x86_64-linux-android
ARCHS="armv7a-linux-androideabi aarch64-linux-android i686-linux-android x86_64-linux-android"
for TARGET in ${ARCHS}
do
  export AR=$ANDROID_NDK_TOOLCHAIN/bin/llvm-ar
  export CC=$ANDROID_NDK_TOOLCHAIN/bin/$TARGET$ANDROID_API-clang
  export AS=$CC
  export CXX=$ANDROID_NDK_TOOLCHAIN/bin/$TARGET$ANDROID_API-clang++
  export LD=$ANDROID_NDK_TOOLCHAIN/bin/ld
  export NM=$ANDROID_NDK_TOOLCHAIN/bin/nm
  export RANLIB=$ANDROID_NDK_TOOLCHAIN/bin/llvm-ranlib
  export STRIP=$ANDROID_NDK_TOOLCHAIN/bin/llvm-strip
  
  echo "Building voice for Android platform ${TARGET}"
  
  pushd $FLITEDIR
  echo "Need to regenerate Flite first for ${TARGET} ..."
  make clean >/dev/null
  rm -rf bin
  rm -f main/*.o
  rm -f config/config config/system.mak
  rm -f config.log config.status
  ./configure --host "$TARGET" --prefix=$(pwd)/install/"$TARGET" >build.log || tail -n 20 build.log
  make -j >>build.log || tail -n 20 build.log
  popd

  echo "****** Building Android voice for platform ${TARGET} starts"
  cp ${MAKEFILE_SNIPPET} Makefile.${TARGET}
  make -f Makefile.${TARGET} clean
  rm -f *.so *.o
  echo "make all ..."
  make -f Makefile.${TARGET} >build.log || tail -n 20 build.log
  echo "****** Building Android voice for platform ${TARGET} finished"

  echo "Showing last 10 lines of build.log:"
  tail -n 10 build.log
  
  echo "Saving voice file(s): "
  mkdir -p ${VOICE_OUTPUT_DIR}/${TARGET}
  cp -v lib*.so ${VOICE_OUTPUT_DIR}/${TARGET}/
  cp -v voice_driver.h ${VOICE_OUTPUT_DIR}/${TARGET}/
  ${STRIP} --strip-debug ${VOICE_OUTPUT_DIR}/${TARGET}/*.so
done

make clean

popd

echo "Finished building Android voice"
