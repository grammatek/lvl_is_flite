# lvl_is_flite
Voice generation for Icelandic Flite voices

## Preparation
This section describes where the data for this voice comes from and how it is preprocessed.

### Voice data
This repo is intended for use with data from [the Talrómur corpus](https://repository.clarin.is/repository/xmlui/handle/20.500.12537/104), and in particular the first voice; lvl_is_f is created using voice f, named Álfur therein. The corpus is described in these two papers: [[1]: script design](https://aclanthology.org/2020.sltu-1.44/) [[2]: recording and verification](https://aclanthology.org/2021.nodalida-main.50/)
There are 2 primary voice-specific files in this voice build. They are, relative to the voice directory: 
- `etc/txt.done.data`, which contains normalized prompts with inserted phrasing tags
- `festvox/lexicon.scm` which contains a mix of manual and automatic g2p transcriptions of all words that occur in the source data.

For the initial voice, [the Grammatek TTS frontend](https://github.com/grammatek/tts-frontend) was used with phrasing enabled, but as of yet this is a very time consuming step. The phrasing step can optionally be skipped to greatly speed things up, in which case pause tags are only inserted where punctuation is present in the prompts.

Due to serious limitations of Flite in terms of handling phoneme names, we use a modified version of SAMPA, which does not use underscores, digits or colons.

<details>
<summary>See mapping from standard SAMPA to our modified version</summary>

|SAMPA|flite phoneset|
|-----|--------------|
|a:   |aa            |
|a    |a             |
|ai:  |aii           |
|ai   |ai            |
|au:  |auu           |
|au   |au            |
|c    |c             |
|C    |C             |
|c_h  |ch            |
|D    |D             |
|ei:  |eii           |
|ei   |ei            |
|E:   |EE            |
|E    |E             |
|f    |f             |
|G    |G             |
|h    |h             |
|i:   |ii            |
|i    |i             |
|I:   |II            |
|I    |I             |
|j    |j             |
|k_h  |kh            |
|k    |k             |
|l    |l             |
|l_0  |lz            |
|m    |m             |
|m_0  |mz            |
|n    |n             |
|n_0  |nz            |
|J    |J             |
|J_0  |Jz            |
|N    |N             |
|N_0  |Nz            |
|9:   |oee           |
|9    |oe            |
|9i:  |oeii          |
|9i   |oei           |
|ou:  |ouu           |
|ou   |ou            |
|O:   |OO            |
|Oi   |Oi            |
|O    |O             |
|p_h  |ph            |
|p    |p             |
|r    |r             |
|r_0  |rz            |
|s    |s             |
|t_h  |th            |
|t    |t             |
|u:   |uu            |
|u    |u             |
|v    |v             |
|x    |x             |
|Y:   |YY            |
|Yi   |Yi            |
|Y    |Y             |
|T    |T             |

</details>

In addition to these SAMPA phonemes, the token `pau` is used to indicate silence at the phone level, whereas `<sil>` is used at the word level.

When generating `<voice_dir>/festvox/lexicon.scm` this mapping needs to be (as of yet, manually) applied to the outputs after the G2P step is run.

### Dependencies
The voice build relies on a few core toolkits, which each have their own installation instructions.
- [Edinburgh Speech Tools](https://github.com/festvox/speech_tools)
- [Festvox](https://github.com/festvox/festvox)
- [Festival](https://github.com/festvox/festival)
- And finally, [a modified version of CMU Flite](https://github.com/grammatek/Flite)
In addition, we use [the Grammatek TTS frontend](https://github.com/grammatek/tts-frontend) to perform phrasing and Grapheme-to-phoneme(G2P) conversion

The modified CMU Flite contains a partial integration for Icelandic TTS Frontend processing. The integration was partially performed following instructions from [the official Flite documentation](http://cmuflite.org/doc/flite_8.html#Language-Conversion). However, since the documentation is incomplete and following the instructions therein does not produce a working voice, we based parts of the code on the CMU lexicon integration bundled within Flite. 
Since the Flite integration is intended for use in an Android TTS engine where frontend processing is done elsewhere, only parts required by the voice build process were implemented and some essential parts of the TTS frontend were left unimplemented, most notably word syllabification. 

### Environment variables
The build process expects certain environment variables to be set. (e.g. using `export <VARIABLENAME>=<value>` in Linux)
- `DATADIR` should point to the location of the Talrómur data being used. Specifically, the directory containing an `index.tsv` file and an `audio/` subdirectory for the desired voice
- `FLITEDIR` should point to where the Flite source code is located. e.g. `~/Flite` if you clone the Flite repo into your home directory.
- Likewise, `FESTIVALDIR`, `FESTVOXDIR` and `ESTDIR` should point to the locations of Festival, Festvox and Edinburgh Speech Tools, respectively.

## Resulting voice models and usage
This recipe generates two nearly identical voice models, one which can be run within Festival, and another standalone voice using Flite. These voice models are generated by running the `<voice_dir>/create_voice.sh` script after following the preparation instructions above.

The Festival voice can be used by supplying `-eval <voice_dir>/festvox/<voicename>_clunits.scm -eval '(voice_<voicename>_clunits)'` when invoking festival binaries such as `${FESTIVALDIR}/bin/text2wave`. Note that `text2wave` also expects a path to a file containing the text to be synthesized as a required argument, and output can be redirected to a file using the `-o` flag. Example where input.txt contains a text prompt:

```
$FESTIVALDIR/bin/text2wave -eval lvl_is_f/festvox/lvl_is_f_clunits.scm -eval '(voice_lvl_is_f_clunits)' input.txt -o output.wav
```

The generated flite voice binary accepts a sequence of phonemes as input, using the `-p` flag. e.g. 

```
./flite_lvl_is_f -p "C E1 r t n a0 EE1 rz s E1 h t n i0 N k pau s EE1 m T uu1 c aii1 t I0 r n OO1 t a0 T pau" -o output.wav
```

Called from within the `<voice_dir>/flite` subdirectory after the voice build, this should generate a synthetic clip of a voice saying "Hérna er setning sem þú gætir notað" in the file `output.wav`.


As stated above, the word-level token for silence is '<sil>' whereas the phone-level token is 'pau'.

## Known issues and further development
The voices resulting from this recipe are by no means SOTA voices and have significant limitations, particulary in terms of audible joins. This issue can be caused by 3 potential causes.
- Firstly, the pitch marks (extracted into the `<voice_dir>/pm` subdirectory) may be incorrectly computed and the extraction script `<voice_dir>/bin/make_pm_wave` may need tweaking for that particular voice.
- Secondly, the join cost function may have suboptimal parameters. In the festival voice, they are set in `<voice_dir>/festvox/<voice_name>_clunits.scm` in the case of runtime parameters and in `<voice_dir>/festvox/build_clunits.scm` in the case of build-time parameters, as the `<voice_name>::dt_params` variable.
  - In particular, the parameters of note here are `f0_join_weight` and `f0_pen_weight`, which denotes the weighting placed upon mismatches in pitch, and `join_weights` and `ac_weights`, which correspond to mismatches in `f0` and `MFCC` features on joins. `MFCCs` roughly correspond to the overall shape of the spectrum at the join points. 
  - Other parameters can also be tweaked, they are documented on pages 116-122 of [the manual for building synthetic voices by Alan W. Black and Kevin A. Lenzo](http://festvox.org/bsv/bsv.pdf)
  - In Flite, these parameters are stored in the `<voicename>_db` variable which is set near the bottom of `flite/<voicename>_clunits.c`
- Thirdly, the waveform join method may be suboptimal. That is set by the `join_method` parameter in the runtime parameters of Festival. 
  - Supported values in festival are *windowed*, *none* and *modified_lpc*.
  - In Flite, only *simple_join*, which corresponds to *none* and *modified_lpc* are implemented, and they are specified in the `register_<voicename>` function in `flite/<voicename>.c`, along with other parameters. It can be set by e.g.:

```
flite_feat_set_string(v->features,"join_type","simple_join");
```

Modifying the number of input speech samples may also yield different results. Greatly increasing the number of input samples will severely slow down the voice build process as various superlinear algorithms are used. In addition, the voice build process may fail due to stack overflows so care must be taken when doing so. Additionally, the space requirements of the voice will grow linearly with the number of samples, and generation will also be slightly slowed down.
Greatly reducing the number of input samples, on the other hand, will result in worse joins, as intuition tells us that when we reduce the number of available units, we also reduce the likelihood of finding a set that matches nicely.

Decreasing the number of samples can be achieved by simply truncating the etc/txt.done.data file for the voice in question, as that file is used to fetch `.wav` files from the corpus. Increasing the number of samples requires transcribing the additional sentences using [the Grammatek TTS frontend](https://github.com/grammatek/tts-frontend) as described in [the voice data description above](#voice-data). Additionally, the lexicon may need to be expanded with any OOV words the text may contain. Since automatic transcriptions may prove incorrect and thus produce bad units, care must be taken in using them.

The Icelandic language integration into the [modified version of Flite](https://github.com/grammatek/Flite) is not fully implemented so as of yet the Flite voice only supports phoneme input.
- In particular, a syllabification method is missing, possibly among other things. This causes text processing for full TTS to fail.
- Due to the use case of the Flite voice, this should be acceptable as the Android TTS engine which utilizes the voice performs frontend processing in advance.
