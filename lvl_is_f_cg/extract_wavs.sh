#!/bin/bash

# Load the wav files from the main corpus according to the utterances in etc/txt.done.data
# You need to set two env variables:
#   $DATADIR - a path to the correct location of the Talrómur corpus, the path should end with the letter denoting
#     the corpus, e.g. '/home/user/tts/talromur/f'
#   $ESTDIR - a path to the installation of speech_tools

mkdir wav
awk -v data_dir="$DATADIR" '{print data_dir"/audio/"$2".wav"}' etc/txt.done.data | xargs bin/get_wavs