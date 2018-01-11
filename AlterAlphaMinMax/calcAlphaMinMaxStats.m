function stats=calcAlphaMinMaxStats(datadir,numwinds);

	% Calculates average and std over numwinds different types of stochastic flow.
	% datadir contains the files of interest.

	if nargin < 2;
		numwinds = 4;
	end

	if nargin < 1;
		datadir = '/scratch03/bcummins/mydata/wnv/AlterAlpha/';
	end

	stats.filenames = {};
	stats.totalmosqreleased = [];
	stats.totalcontacts = [];
	stats.avgtimetohost = [];
	stats.stdtimetohost = [];
	stats.medtimetohost = [];

	for k = 1:numwinds;
		datafiles = dir(fullfile(datadir,['*_wind',int2str(k),'.mat']));
		stats.filenames{k} = datafiles;
		for m = 1:length(datafiles);
			load(fullfile(datadir,datafiles(m).name))
			stats.totalmosqreleased(k,m) = p.Nm;
			stats.totalcontacts(k,m) = length(results.whichchicken);
			stats.avgtimetohost(k,m) = mean(results.tmfinal - results.tmentrance);
			stats.stdtimetohost(k,m) = std(results.tmfinal - results.tmentrance);
			stats.medtimetohost(k,m) = median(results.tmfinal - results.tmentrance);
		end
	end

	stats.avgnumcontacts_uwind = [];
	stats.stdnumcontacts_uwind = [];
	stats.avgmedtimetohost_uwind = [];
	stats.stdmedtimetohost_uwind = [];

	stats.avgnumcontacts_dwind = [];
	stats.stdnumcontacts_dwind = [];
	stats.avgmedtimetohost_dwind = [];
	stats.stdmedtimetohost_dwind = [];

	stats.avgnumcontacts_cwind = [];
	stats.stdnumcontacts_cwind = [];
	stats.avgmedtimetohost_cwind = [];
	stats.stdmedtimetohost_cwind = [];

	xticklabels_uwind = {};
	xticklabels_dwind = {};
	xticklabels_cwind = {};

	for m = 1:length(datafiles);
		fname = stats.filenames{1}(m).name(1:end-10)
		if strfind(fname,'C');
			stats.avgnumcontacts_cwind(end+1) = mean(stats.totalcontacts(:,m));
			stats.stdnumcontacts_cwind(end+1) = std(stats.totalcontacts(:,m));
			xticklabels_cwind{end+1} = makeXlabels(fname);
		elseif strfind(fname,'D');
			stats.avgnumcontacts_dwind(end+1) = mean(stats.totalcontacts(:,m));
			stats.stdnumcontacts_dwind(end+1) = std(stats.totalcontacts(:,m));
			xticklabels_dwind{end+1} = makeXlabels(fname);
		elseif strfind(fname,'U');
			stats.avgnumcontacts_uwind(end+1) = mean(stats.totalcontacts(:,m));
			stats.stdnumcontacts_uwind(end+1) = std(stats.totalcontacts(:,m));
			xticklabels_uwind{end+1} = makeXlabels(fname);
		end
		% bar(stats.totalcontacts(:,m))
		% title(fname)
		% xlabel('wind instances')
		% ylabel('total contacts')
		saveas(gcf,fullfile(datadir,'frames',[fname,'_totalcontacts.png']))
		if strfind(fname,'C');
			stats.avgmedtimetohost_cwind(end+1) = mean(stats.medtimetohost(:,m));
			stats.stdmedtimetohost_cwind(end+1) = std(stats.medtimetohost(:,m));
		elseif strfind(fname,'D');
			stats.avgmedtimetohost_dwind(end+1) = mean(stats.medtimetohost(:,m));
			stats.stdmedtimetohost_dwind(end+1) = std(stats.medtimetohost(:,m));
		elseif strfind(fname,'U');
			stats.avgmedtimetohost_uwind(end+1) = mean(stats.medtimetohost(:,m));
			stats.stdmedtimetohost_uwind(end+1) = std(stats.medtimetohost(:,m));
		end
		% bar(stats.medtimetohost(:,m))
		% title(fname)
		% xlabel('wind instances')
		% ylabel('median time to host')
		% saveas(gcf,fullfile(datadir,'frames',[fname,'_medtimetohost.png']))
	end

	bar(stats.avgnumcontacts_uwind,'FaceColor',[0.8,0.8,0.8])
	hold on
	errorbar(stats.avgnumcontacts_uwind,stats.stdnumcontacts_uwind,'k+')
	title('Upwind total contacts','FontSize',24)
	set(gca,'XTickLabel',xticklabels_uwind,'FontSize',24)
	ylabel('avg total contacts','FontSize',24)
	saveas(gcf,fullfile(datadir,'frames/summarystats','Upwind_totalcontacts.png'))
	hold off
	bar(stats.avgmedtimetohost_uwind,'FaceColor',[0.8,0.8,0.8])
	hold on
	errorbar(stats.avgmedtimetohost_uwind,stats.stdmedtimetohost_uwind,'k+')
	title('Upwind median time to host','FontSize',24)
	set(gca,'XTickLabel',xticklabels_uwind,'FontSize',24)
	ylabel('avg median time to host','FontSize',24)
	saveas(gcf,fullfile(datadir,'frames/summarystats','Upwind_medtimetohost.png'))
	hold off

	bar(stats.avgnumcontacts_dwind,'FaceColor',[0.8,0.8,0.8])
	hold on
	errorbar(stats.avgnumcontacts_dwind,stats.stdnumcontacts_dwind,'k+')
	title('Downwind total contacts','FontSize',24)
	set(gca,'XTickLabel',xticklabels_dwind,'FontSize',24)
	ylabel('avg total contacts','FontSize',24)
	saveas(gcf,fullfile(datadir,'frames/summarystats','Downwind_totalcontacts.png'))
	hold off
	bar(stats.avgmedtimetohost_dwind,'FaceColor',[0.8,0.8,0.8])
	hold on
	errorbar(stats.avgmedtimetohost_dwind,stats.stdmedtimetohost_dwind,'k+')
	title('Downwind median time to host','FontSize',24)
	set(gca,'XTickLabel',xticklabels_dwind,'FontSize',24)
	ylabel('avg median time to host','FontSize',24)
	saveas(gcf,fullfile(datadir,'frames/summarystats','Downwind_medtimetohost.png'))
	hold off

	bar(stats.avgnumcontacts_cwind,'FaceColor',[0.8,0.8,0.8])
	hold on
	errorbar(stats.avgnumcontacts_cwind,stats.stdnumcontacts_cwind,'k+')
	title('Crosswind total contacts','FontSize',24)
	set(gca,'XTickLabel',xticklabels_cwind,'FontSize',24)
	ylabel('avg total contacts','FontSize',24)
	saveas(gcf,fullfile(datadir,'frames/summarystats','Crosswind_totalcontacts.png'))
	hold off
	bar(stats.avgmedtimetohost_cwind,'FaceColor',[0.8,0.8,0.8])
	hold on
	errorbar(stats.avgmedtimetohost_cwind,stats.stdmedtimetohost_cwind,'k+')
	title('Crosswind median time to host','FontSize',24)
	set(gca,'XTickLabel',xticklabels_cwind,'FontSize',24)
	ylabel('avg median time to host','FontSize',24)
	saveas(gcf,fullfile(datadir,'frames/summarystats','Crosswind_medtimetohost.png'))
	hold off


end %function

function xt = makeXlabels(fname);
	if strfind(fname,'original');
		xt = 'orig';
	elseif strfind(fname,'twothirds');
		xt = '2/3';
	elseif strfind(fname, 'third');
		xt = '1/3';
	else;
		xt = '1/6';
	end
	if strfind(fname,'Min');
		xt = [xt,' both'];
	end

end %function








