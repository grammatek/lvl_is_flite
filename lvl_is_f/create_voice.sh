#!/bin/bash
DATADIR=${DATADIR:-/data/tts/talromur/published/f}
export FLITEDIR=${FLITEDIR:-/scratch/gunnar/Flite}

rm -r wav nwav prompt-utt prompt-lab ehmm \
    lab pm mcep f0 lpc \
    festival/dur/feats festival/dur/data festival/dur/tree \
    festival/feats festival/trees festival/utts festival/disttabs

mkdir -p wav prompt-utt prompt-lab \
    lab pm mcep f0 lpc \
    festival/dur/feats festival/dur/data festival/dur/tree \
    festival/feats festival/trees festival/utts festival/disttabs

awk -v data_dir=${DATADIR} '{print data_dir"/audio/"$2".wav"}' etc/txt.done.data | xargs bin/get_wavs

# Add random noise to audio (see script for more info)
# Note that dithering is here a precaution to prevent signal processing algos from failing
bin/add_noise etc/txt.done.data



# possibly power normalize

./bin/do_build build_prompts
./bin/do_build label
./bin/do_build build_utts
./bin/do_build do_pm
./bin/do_build do_mcep
./bin/do_build do_dur

./bin/do_build build_clunits

$FLITEDIR/bin/setup_flite


./bin/build_flite
cd flite

sed -i 's/cmu_is_/lvl_is_/g' lvl_is_f.c
sed -i 's/cmu_is_/lvl_is_/g' Makefile

make
