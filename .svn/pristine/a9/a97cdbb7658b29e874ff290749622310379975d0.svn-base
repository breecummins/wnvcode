function rulesetcount=SSFindRuleSets(fname,rs,time,d,red)
	
	%fname is one of the 'Averages.mat' files, complete with path
	%rs = rule set, a value in 1:9. The index will be calculated using fudgefactor (index = rs - fugdefactor). fudgefactor is zero when all the rule sets were simulated
	%time = time index, 1:176 (see tSpace vector for the corresponding times)
	%d is the breakpoint distance for counting rule sets: all distances greater than d have their rule sets tabulated. if d =1, then the breakpoint for a second hump is calculated to be the distance d.
	%red is the threshold number of instances of a rule set to count. default is 1 (all instances)
	
pmax=80;
numruns=25;
numfiles=2000;
fudgefactor=0;
%load ~/WNVSecondRuns/ScalarMeasures/AllAverages.mat
load(fname)

%make vector of parameter set numbers
iv=[];
for k=1:pmax;
	iv = [iv;k*ones(numruns,1)];
end

%make param array
if pmax == 80;
	maxspd=	1.25:0.25:2;
	minspd=	0.2:0.2:0.8;
	minang=	pi/6:pi/6:5*pi/6;
elseif pmax == 12;
	maxspd=	[1.25,2];
	minspd=	[0.2,0.8];
	minang=	pi/12:pi/6:5*pi/12;
end
parray=[];			
for k = maxspd;
	for l = minspd;
		for m = minang;
			parray(end+1,:) = [l,k,m];
		end
	end
end

%excise the appropriate method rs at the indicated time and label the values with the parameter set numbers
ruleset(:,1) = squeeze(vals_by_method(rs-fudgefactor,time,:));
ruleset(:,2) = iv;

if d == 1;
	%figure out where the breakpoint is for the second hump
	[h,l]=hist(ruleset(:,1),50);
	cutoff=10;
	posind = find(h(1:end-cutoff) == min(h(cutoff:end-cutoff)));
	pos = (l(posind(end))+l(posind(end)+1))/2 %l contains the bin centers -- must average to get the bin edge
	% pos = l([24,30]);
else;
	pos = d;
end

%count the number of instances that rule sets fall in the second hump
%jnd = intersect(find(ruleset(:,1) >= pos(1)),find(ruleset(:,1) <= pos(2)));
jnd = find(ruleset(:,1) >= pos);
rs2 = ruleset(jnd,2);
rs2u = unique(rs2);
rulesetcount = [rs2u,parray(rs2u,:)];
for k = 1:length(rulesetcount(:,1));
	c = find(rs2 == rulesetcount(k,1));
	rulesetcount(k,5) = length(c);
end

if d==1 && sum(h(posind(end)+1:end)) ~= sum(rulesetcount(:,5));
	disp('Histogram sum:')
	disp(sum(h(k(end)+1:end)))
	disp('Rule set count sum:')
	disp(sum(rulesetcount(:,5)))
	error('Counts do not match. There is a bug.')
end

if nargin < 5 || isempty(red);
	reducedind = find(rulesetcount(:,5) > 0);
else;
	reducedind = find(rulesetcount(:,5) > red);
end
	
rulesetcount = rulesetcount(reducedind,:);
