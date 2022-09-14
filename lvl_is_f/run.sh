# Make some dirs we need
$FESTVOXDIR/src/general/make_dirs
DATADIR=$1

set -eux pipefail

# Set up the prompts that we will train on.
# ---

# TODO: filter out prompts with unsupported letters
# then use that for creating txt.complete.data and vocabulary.txt

# Create transcriptions for everything
python3 normalize.py $DATADIR/index.tsv txt.complete.data --scm


# Filter out prompts with numbers or unsupported letters (c, w, q and z)
grep -v '"[^"]*[0-9cwqz]' txt.complete.data > txt.nonum.data

# For large databases this can take some time to run as there is a squared aspect 
# to this based on the number of instances of each unit type.
# So lets start with only 100 tokens, this number can be increased for better sound
head -n 2000 txt.nonum.data > etc/txt.done.data
# We've only successfully trained on ~2000 prompts. Training on ~2000 prompts
# needed to be done overnight.
# Using all the tokens uncomment the line below if you want to use all of the tokens
# cp -p txt.nonum.data etc/txt.done.data

# Create a lexicon
# ---

# #Create list of all words in prompts
# python3 process_prompts.py $DATADIR/index.tsv "-" | grep -o "[^ ]*" | sort | uniq > vocabulary.txt

# # Add additional vocabulary
# # This is highly recommended but needs additional resources you can find online
# # mv vocabulary.txt audio-vocabulary.txt
# # cut -f1 framburdarordabok.txt > additional-vocabulary.txt
# # cat audio-vocabulary.txt additional-vocabulary.txt | sort | uniq > vocabulary.txt

# # Create phoneme transcriptions
# python3 f_g2p.py --model $G2P_METHOD --apply vocabulary.txt > lexicon.txt

# # TODO: NOTE this might not be needed anymore since x-sampa already are ascii
# # readable phonemes
# # Create a compiled lexicon from text lexicon
# python3 build_lexicon.py sampa-map.tsv lexicon.txt festvox/lexicon.scm

LC_ALL=C.UTF8 python3 ./process_prompts.py "$1/index.tsv" "-" | sort | uniq 2>/dev/null > lexicon.scm

# Power normalize and format wavs (16kHz, 16bit)
# bin/get_wavs $DATADIR/audio/*.wav
awk -v data_dir=$DATADIR '{print data_dir"/audio/"$2".wav"}' etc/txt.done.data | xargs bin/get_wavs

# Add random noise to audio (see script for more info)
bin/add_noise txt.done.data

# Do the thing
bin/do_build
