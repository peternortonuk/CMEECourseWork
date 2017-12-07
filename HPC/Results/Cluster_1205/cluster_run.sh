#!/bin/bash
#PBS -l walltime=01:00:00
#PBS -l select=1:ncpus=1:mem=1gb
module load R
module load intel-suite
echo "R about to run"
R --vanilla < $WORK/cluster_run_30.R
mv pg5117* $WORK
echo "finished"
