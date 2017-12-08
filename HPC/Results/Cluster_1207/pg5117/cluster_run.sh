#!/bin/bash
#PBS -l walltime=12:00:00
#PBS -l select=1:ncpus=1:mem=2gb
module load R
module load intel-suite
echo "running"
R --vanilla < $WORK/cluster_run.R
mv pg5117* $WORK
echo "finished"
