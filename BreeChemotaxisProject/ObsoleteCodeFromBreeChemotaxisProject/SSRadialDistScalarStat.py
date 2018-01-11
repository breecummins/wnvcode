#!/usr/bin/env python

import numpy as nm
import mien.parsers.fileIO as io
import mien.nmpml.data as miendata
import mien.parsers.nmpml as nmpml
import os

def runMe():
	'''Make scalar measures based on the vector of distances between each mosquito and the CO2 source.'''
	basedir = '/Users/bree/WNVThirdRuns'
	sims = [f for f in os.listdir(basedir) if f.startswith("MemoryRules_paramset")]
	odoc = nmpml.blankDocument() #make output document
	ds = miendata.newData(None, {'SampleType':'group'}) #group type can have an empty payload, unlike function
	odoc.newElement(ds)
	for fname in sims:
		gmfname = os.path.join(basedir,'ScalarMeasures/geomean_'+ fname[12:28]+'.mdat')
		avfname = os.path.join(basedir,'ScalarMeasures/average_'+ fname[12:28]+'.mdat')
		idoc = io.read(os.path.join(basedir,fname))
		EucDist = idoc.elements[3].data
		idoc.sever() #sever input doc to avoid memory leak
		power = 1./EucDist.shape[0]
		numrows = EucDist.shape[1]
		numcols = EucDist.shape[2]
		lgm = []
		lav = []
		for j in range(numrows):
			for k in range(numcols):
				lgm.append(nm.prod(EucDist[:,j,k])**power)
				lav.append(nm.mean(EucDist[:,j,k]))
		lgma=nm.asarray(lgm).flatten()
		lava=nm.asarray(lav).flatten()
		gmmatrix = nm.reshape(lgma,(numrows,numcols),'C') #row major order: each row r contains the time sequence for method r
		avmatrix = nm.reshape(lava,(numrows,numcols),'C') 
		#do not worry about transposing for mien b/c this is not really a time series -- not equal spacing in time.
		ds.datinit(gmmatrix, {'SampleType':'function'})
		io.write(odoc, gmfname)
		ds.datinit(avmatrix, {'SampleType':'function'})
		io.write(odoc, avfname)
	

if __name__ == '__main__':
	runMe()
