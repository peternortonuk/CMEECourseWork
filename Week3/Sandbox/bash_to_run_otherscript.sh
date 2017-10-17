#!/bin/bash

#bash script to run python and R scripts

cd ../Code
Rscript basic_io.R trees.csv
Rscript get_TreeHeight.R trees.csv
Rscript TreeHeight.R trees.csv
python get_TreeHeight.py trees.csv

