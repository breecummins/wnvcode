#!/bin/bash
#PBS -q ccs_long
#PBS -l walltime=168:00:00 
#PBS -l nodes=1:ppn=1 
#PBS -m ae
#PBS -d /scratch03/bcummins/wnvcode/PaperRevisionsNewHostSeeking

time matlab -nodisplay -nosplash < BatchChickenJuice_Density.m # -nojvm breaks matlabpool parallelization, use ppn=n for memory intensive jobs (or when using n processors), but don't go over ppn=32. And remember to use eightcore if a lot of memory is needed.

echo End Job
