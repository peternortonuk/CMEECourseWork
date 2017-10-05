#!/bin/bash
#Author pg5117@ic.ac.uk
# Script: CountLines.sh
# Desc: 
# Count and output number of lines in a file input by user
#October 2017
#

NumLines=`wc -l < $1`
echo "The file $1 has $NumLines lines"
echo
