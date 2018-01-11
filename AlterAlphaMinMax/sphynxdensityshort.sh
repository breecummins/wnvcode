#!/bin/bash
#PBS -q ccs_short
#PBS -l walltime=1:00:00 
#PBS -l nodes=1:ppn=1    
#PBS -m ae
#PBS -d /scratch03/bcummins/wnvcode/AlterAlphaMinMax

module load MATLAB 

time matlab -nodisplay -nosplash < BatchChickenJuice_Density_Uniform.m # -nojvm breaks matlabpool parallelization

echo End Job
