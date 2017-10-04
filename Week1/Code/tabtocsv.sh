#!/bin/bash
# Author pg5117@ic.ac.uk
# Script: tabtocsv.sh
# Desc: substitute the tabs in the files with commas
#
#saves the output into a .csv file
# Arguments: 1-> ta
#Date October 2017

echo "Creating a comma delimited version of $1 ..."
cat $1 | tr -s "\t" "," >> $1.csv
echo "Done!"
exit
