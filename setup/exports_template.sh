############################################################################
#
# This is a template for an exports.sh file to set all relevant environment variables when building a
# Festival voice for Icelandic.
# Create your own local setup/exports.sh file with the actual paths in your environment.
#
# To set the variables on start, run: 'source ./setup/exports.sh'
#
#############################################################################

# Path to audio data. Make sure the wavs are stored in a directory 'audio/' at the end of this path,
# if this is not the case, adjust the script 'extract_wavs.sh' accordingly
export DATADIR=/home/user_name/tts/talromur/d

# Festvox and speech tools paths
export TTS_HOME=/home/user_name/tts
export FESTVOXDIR=/home/user_name/tts/festvox
export ESTDIR=/home/user_name/tts/speech_tools/
export SPTKDIR=/home/user_name/tts/SPTK/

# If you are using an external server with multiple CPUs it might be sensible to set a max number on
# available CPUs, per default the training process utilizes all available CPUs
# export FESTVOX_NUM_CPUS=32