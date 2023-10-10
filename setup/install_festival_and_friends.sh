#!/bin/sh

##########################################################
#
# This script contains commands to download and install all necessary libraries to build an Icelandic
# voice with Festival and Flite using the recipes in the lvl_is_flite repository.
#
# If you are following the recipes in this repository, you MUST use the repositories listed in this files that
# are in some cases forks from the original libraries with custom settings for Icelandic, e.g. the phoneset
# and lexicon used in the repositories.
#
# Run exports.sh before running this script.
#
###########################################################

pushd $TTS_HOME

# Create home directories and fetch speech packages
mkdir -p festival festvox speech_tools
curl -L https://github.com/grammatek/festival/archive/refs/tags/2.5.2-pre1.tar.gz | \
    tar xz --no-same-owner --no-same-permissions --strip-components=1 -C festival && \
    curl -L https://github.com/grammatek/speech_tools/archive/refs/tags/ds-fix-walloc.tar.gz | \
    tar xz --no-same-owner --no-same-permissions --strip-components=1 -C speech_tools && \
    curl -L http://festvox.org/packed/festival/2.5/festlex_CMU.tar.gz | \
    tar xz --no-same-owner --no-same-permissions --strip-components=1 -C festival && \
    curl -L http://festvox.org/packed/festival/2.5/festlex_OALD.tar.gz | \
    tar xz --no-same-owner --no-same-permissions --strip-components=1 -C festival && \
    curl -L http://festvox.org/packed/festival/2.5/festlex_POSLEX.tar.gz | \
    tar xz --no-same-owner --no-same-permissions --strip-components=1 -C festival && \
    curl -L http://festvox.org/packed/festival/2.5/voices/festvox_kallpc16k.tar.gz | \
    tar xz --no-same-owner --no-same-permissions --strip-components=1 -C festival && \
    curl -L https://github.com/grammatek/festvox/archive/refs/tags/2.8.3-pre1.tar.gz | \
    tar xz --no-same-owner --no-same-permissions --strip-components=1 -C festvox

# We get the SPTK package from the festvox repository
wget http://festvox.org/packed/SPTK-3.6.tar.gz && \
    tar zxvf SPTK-3.6.tar.gz && \
    mkdir SPTK && \
    patch -p0 <festvox/src/clustergen/SPTK-3.6.patch && \
    cd SPTK-3.6 && \
    ./configure --prefix=$SPTKDIR && \
    make && \
    make install
popd

# Build the Edinburgh Speech Tools
pushd $TTS_HOME/speech_tools
./configure && make
popd

# Build Festival
pushd $TTS_HOME/festival
./configure && make
popd

# Build Festvox
pushd $TTS_HOME/festvox
./configure && make
popd

# Setup & build Flite for Linux, Festival needs executables built here for exporting a Flite voice
pushd $TTS_HOME
git clone https://github.com/grammatek/Flite/ && cd Flite && git checkout android-grammatek \
   && ./configure && make
popd
