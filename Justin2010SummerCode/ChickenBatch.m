clear

load 'ChickenLocsNew.mat' *c

%If this is the first run, need to initialize everything
i = 0;
t_results = zeros(200,4,length(xc(1,:)));
ind_results = zeros(200,4,length(xc(1,:)));

try
  load 'ChickenResultsNew.mat' *_results i
catch
  %Do nothing
end

%If last run was interrupted, pick up where we left off
for i = i+1:length(xc(1,:))
  [t_results(:,:,i), ind_results(:,:,i)] = ExploreChickenPosition(xc(:,i),yc(:,i));
  save 'ChickenResultsNew.mat' *_results i
  disp(['finished #',num2str(i)]);
end