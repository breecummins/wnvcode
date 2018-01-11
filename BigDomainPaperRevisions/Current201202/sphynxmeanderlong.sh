#!/bin/bash
#PBS -q ccs_long
#PBS -l walltime=20:00:00 
#PBS -l nodes=1:ppn=1 
#PBS -m ae
#PBS -d /scratch03/bcummins/wnvcode/BigDomainPaperRevisions/Current201202/

module load MATLAB 

time matlab -nojvm -nosplash < BatchChickenJuice_NewMeander.m

echo End Job
