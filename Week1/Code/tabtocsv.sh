#!/bin/bash
# Author pg5117@ic.ac.uk
# Script: tabtocsv.sh
# Desc: 
#substitute the tabs in the files with commas
#saves the output into a .csv file
# Arguments: 1,file.csv has been created in Data
# the input file, new csv created with same name.csv
#Date October 2017
cd ../Data
echo 'enter tab del filename - PS test.txt has been created'
read varName
echo 'test.txt in Data directory will be converted'
echo "Creating a comma delimited version of" $varName
echo $varName | cut -f 1 -d '.'| tr -s "\t" "," >> test.csv
echo 'test.csv created'

 
