#!/bin/bash
#Author pg5117@ic.ac.uk
# Script: ConcatenateTwoFiles.sh
# Desc: 
# take file 1 and file 2 and merge into file 3
#October 2017
#
cat $1 > $3
cat $2 >> $3
echo "Merged File is"
cat $3
