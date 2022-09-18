#!/bin/bash
DATADIR=${1:"/data/tts/talromur/published/f"}

rm -r wav nwav prompt-utt prompt-lab ehmm \
    lab pm mcep f0 \
    festival/dur/feats festival/dur/data \
    festival/feats festival/trees festival/utts

mkdir -p wav prompt-utt prompt-lab \
    lab pm mcep f0 \
    festival/dur/feats festival/dur/data \
    festival/feats festival/trees festival/utts

awk -v data_dir=/data/tts/talromur/published/f '{print data_dir"/audio/"$2".wav"}' etc/txt.done.data | xargs bin/get_wavs

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