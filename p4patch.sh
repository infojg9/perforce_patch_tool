#!/bin/sh

alias p4patch='P4DIFF=/usr/bin/diff p4 diff -du'
list=`p4 opened | cut -d# -f1`
if [ ! -e $PWD/patch ]; then
    mkdir $PWD/patch
else
    rm -rvf ${PWD}/patch/*
fi
for file in $list
do
    echo "Found p4 opened file: $file"
    filename=`echo $(echo $file | awk -F "/" '{print $NF}')`
    echo "Processing patch for file: $filename"
    p4patch $file > ${PWD}/patch/${filename}.diff
    p4patch $file >> ${PWD}/patch/patch.diff
done
