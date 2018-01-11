#!/bin/bash
#PBS -q ccs_long
#PBS -l walltime=9:30:00 
#PBS -l nodes=1:eightcore:ppn=3 
#PBS -d /scratch03/bcummins/BigDomainPaperRevisions

#module load MATLAB #only on sphynx

time matlab -nojvm -nosplash < BatchChickenJuice_StraightPlume_InitNoDiff.m

echo End Job
