#!/bin/bash
#PBS -q ccs_long
#PBS -l walltime=168:00:00 
#PBS -l nodes=1:ppn=1   #nodes=1:ppn=3 when more memory or more helpers are needed 
#PBS -m ae
#PBS -d /scratch03/bcummins/wnvcode/PaperRevisionsNewHostSeeking

module load MATLAB 

time matlab -nodisplay -nosplash < BatchChickenJuice_Density.m # -nojvm breaks matlabpool parallelization

echo End Job
