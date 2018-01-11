#!/usr/bin/env python

import numpy as nm
import os
import mat2py

def runMe(basedir,fnamestart,newfname):
	'''Make scalar measures based on the vector of distances between each mosquito and the CO2 source.'''
	sims = [f for f in os.listdir(basedir) if f.startswith(fnamestart)]
	lf=len(fnamestart)
	avgs=[]
	pset=[]
	runs=[]
	progress = 0
	for fname in sims:
		progress+=1
		if nm.mod(progress,10) == 0:
			print('Step ' + str(progress) + ' of ' + str(len(sims)) + '.')
		pset.append(int(fname[lf:lf+3]))
		runs.append(int(fname[lf+7:lf+9]))
		md = mat2py.read(os.path.join(basedir,fname))
		EucDist = md['EuclideanDist']
		numrows = EucDist.shape[1]
		numcols = EucDist.shape[2]
		lav = []
		for j in range(numrows):
			for k in range(numcols):
				lav.append(nm.mean(EucDist[:,j,k]))
		lava=nm.asarray(lav).flatten()
		avgs.append(lava)  
	avgs = nm.asarray(avgs).flatten()  #I really wanted this to be a 3D array, but Matlab and Python read dimensions differently and so it was just too much of a hassle. I reshape the vector in SSScalarViz2.m.
	pset = nm.asarray(pset).flatten()
	runs = nm.asarray(runs).flatten()
	psetruns = nm.column_stack([pset,runs])
	mat2py.write(os.path.join(basedir,newfname),{'avgs':avgs,'psetruns':psetruns,'numrows':numrows,'numcols':numcols})
	

if __name__ == '__main__':
	runMe('/Users/bcummins/WNVSixthRuns','Rule5onlyMaxScaling_paramset','ScalarAverages_Rule5onlyMaxScaling.mat')
