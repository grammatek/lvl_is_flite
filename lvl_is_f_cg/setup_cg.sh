#!/bin/sh

## Setup directories for the build of a clustergen voice.
## We already assume that the bin/ festival/ and festvox/ directories are in place.
## Also, the etc/ directory has to be setup with the necessary data, wavs for build are extracted in a separate
## script 'extract_wavs.sh'

mkdir prompt-utt lab pm_unfilled prompt-lab f0 ccoefs
mkdir -p festival/coeffs festival/disttabs festival/dur/feats festival/dur/tree festival/feats festival/trees festival/utts festival/utts_hmm

