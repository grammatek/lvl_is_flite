## Clustergen voice for voice f, Álfur, from Talrómur

### Data

The utterances in etc/txt.done.data are the 1200 utterances with the least deviation from the overall f0 value of
the Álfur recordings. Additionally 9 utterances from the low-deviation-from-f0 dataset (< 2.0 Hz deviation) that
include the most rare phoneme "Jz", and lastly 38 utterances containing letter and digits reading, independently
of f0 values.

The original utterance list is additionally stored in etc/alfur_utterances_f0_letters_digits.txt, which is not touched by
the voice building process.

For full utterance list for the Álfur voice, see the Talrómur dataset.

### Load audio

We assume that the full dataset is stored outside this repository. To load the audio files that correspond to
the utterances in etc/txt.done.data, create a directory 'wav' and load the .wav files from your data storage:
Make sure the ESTDIR environment variable is set before running extract_wavs.sh, e.g. `/home/user/tts/speech_tools/`

```
$ export DATADIR=<path/to/talromur/f>
$ ./extract_wavs.sh
```

### Prepare for voice building

Create some folders, since the voice building process fails if there are certain folders missing.

```
$ ./setup_cg.sh
```

Now you are all set up to start building a clustergen voice.

Export the FESTVOXDIR environment variable to Festvox home, e.g. `home/user/tts/festvox`
Export the SPTKDIR environment variable to SPTK home IF using SPTK. SPTK is needed for random forests but can
be omitted for baseline clustergen voice building.

If building an Icelandic voice, DO NOT follow the first step of the Festival documentation by calling 
``$FESTVOXDIR/src/clustergen/setup_cg <INST> <LANG> <VOICENAME>`` since it will override Icelandic customization

```
# Build a baseline clustergen voice, this has to build succsessful before we continue
$ ./bin/build_cg_voice
```

The script `bin/build_cg_rfs_voice` contains a call to `bin/build_cg_voice`, and additional steps for mixed excitation
and random forests. The build_cg_rfs_voice is split into two scripts: `bin/do_mixed_excitation` and `bin/do_rfs`.

