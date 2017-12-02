#!/bin/bash
#PBS -l walltime=00:10:00
#PBS -l select=1:ncpus=1:mem=1gb
module load R
module load intel-suite
echo "running"
R --vanilla < $WORK/cluster_run_10.R
mv pg5117* $WORK
echo "finished"
