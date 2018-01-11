%testChickPos.m

close all

colors = {'k^', 'r^', 'b^', 'm^', 'g^'};
for a = 1:5;
	figure
	hold on
	axis([25,75,25,75])
	for k = 1:10;
		fname = ['~/WNVFullBatchRuns/ChangingDensityAverageChickPos/Upwind_numchicks',int2str(a),'_iternum',int2str(k),'.mat'];
		load(fname)
		plot(xc,yc,colors{a})
	end
end
		