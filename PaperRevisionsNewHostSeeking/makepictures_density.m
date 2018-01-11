%makepictures_density.m

basedirold = '~/WNV_Archived/WNVNewHostSeeking/ChangingDensityAverageChickPos_DensityAtOneQuarter';
basedir = '~/WNVNewHostSeeking_CorrectedInterpolation/ChangingDensityAverageChickPos';

% %consolidate data and calculate statistics (only needs to be done once)
% collateSimdata_density(basedir);

%load the file made in collateSimdata_density and make pictures. Return values are the y-intercepts (P0 in paper).
% [p11,p12,p13,c11,c12,c13]=checkPredictions_density(basedirold,1);
% [p11,p12,p13,p21,p22,p23,c11,c12,c13]=checkPredictions_density(basedir,0);
[c11,c12,c13]=checkPredictions_density_sqrt(basedir,0);


