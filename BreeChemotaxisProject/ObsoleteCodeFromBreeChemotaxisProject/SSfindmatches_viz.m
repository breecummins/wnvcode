%SSfindmatches_viz.m

clear
close all

load ~/WNVSixthRuns/bestmatches_rule2_vanished.mat

for k = 1:length(comprs);
	if comprs(k) == 1 || comprs(k) == 6;
		bp = bestmatches(k,1);
		cp = bestmatches(k,2);
		zval = SSUstatStacks(basers,bp,comprs(k),cp,1,0);
	
		legend off
		pvb = SSparamsets(bp);	
		pvc = SSparamsets(cp);	
		title(['RS 2, PS ',int2str(bp),' ([', num2str(pvb(1)),', ',num2str(pvb(2)),', ',num2str(pvb(3)),']), vs RS ',int2str(comprs(k)),', PS ', int2str(cp),' ([', num2str(pvc(1)),', ',num2str(pvc(2)),', ',num2str(pvc(3)),'])'])
	end
end

