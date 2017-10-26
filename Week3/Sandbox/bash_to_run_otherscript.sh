#!/bin/bash

#bash script to run python and R scripts

cd ../Code
Rscript basic_io.R trees.csv
Rscript boilerplate.R
Rscript get_TreeHeight.R trees.csv
Rscript TreeHeight.R trees.csv
python get_TreeHeight.py trees.csv
Rscript control.R
Rscript apply1.R
Rscript apply2.R
Rscript break.R
Rscript next.R
Rscript Vectorize1.R
Rscript Vectorize2.R
python Vectorize1.py
python Vectorize2.py
Rscript sample.R
Rscript try.R
Rscript browse.R
Rscript PP_Lattice.R
Rscript TAutoCorr.R
Rscript maps.R
Rscript PP_Regress.R
#PP_Regress_loc.R.
#DataWrang.R
#DataWrangTidy.R.

#23





