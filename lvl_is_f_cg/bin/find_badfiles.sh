#!/bin/sh

# Because sometimes the feature extraction fails (not sure why)
# Let's be very careful here, and remove files that weren't processed well

for i in ccoefs/*.mcep
do
    printf "$i "
    $ESTDIR/bin/ch_track -info $i | grep "Number of channels:" | awk '{print $NF}'
done | awk '{if ($NF != 52) print $1}' >bad.files
cp -pr etc/txt.done.data etc/txt.done.data.precombine
cat bad.files |
while read x
do
    fname=`basename $x .mcep`
    echo "( "$fname
 done >etc/bad.data
 $FESTVOXDIR/src/promptselect/dataset_minus etc/txt.done.data.precombine etc/bad.data >etc/txt.done.data
 
 # If there isn't a predefined train/test split, we'll make one
 if [ ! -f etc/txt.done.data.test ]
 then
    ./bin/traintest etc/txt.done.data
fi
