#!/bin/bash

[ -e test.wav ] && rm test.wav
[ -e input_temp.txt ] && rm input_temp.txt
echo "halló ég kann að tala íslensku" > input_temp.txt
$FESTIVALDIR/bin/text2wave -eval festvox/lvl_is_f_clunits.scm -eval '(voice_lvl_is_f_clunits)' input_temp.txt -o test.wav
rm input_temp.txt