function [List] = Results(List,savename,nummosq,runcount)

% Calculates averages of data produced by Matrix.m and saves results as
% .mat and .xls files

addpath Results/

avg1 = mean(List(1,:));     % number of mosquitoes finding larger group
avg2 = mean(List(2,:));     % per-capita ratio at larger group
avg3 = mean(List(3,:));     % number of mosquitoes finding smaller group = per-capita ratio
avg4 = mean(List(4,:));     % ratio of smaller to larger per-capita group ratios
avgval = [avg1; avg2; avg3; avg4];
List(:,end+1) = avgval;

% standard deviation
opr = List(4,(end-1));
sd_num = sum(opr);
sd_avg = sd_num/runcount;
sd_pts = (opr-sd_avg).^2;
st_dev = sqrt((sum(sd_pts))/runcount);
List(5,end) = st_dev;

save(['Results/',savename,' ',date,'.mat'],'List','nummosq')

toplabels = 1:runcount;
sidelabels = {'Run'; 'Number of mosquitoes at larger group';...
    'Mosquitoes per-capita at larger group';...
    'Mosquitoes per-capita at smaller group';...
    'Ratio of smaller to larger group per-capita ratios';...
    'Standard deviation'};

xlswrite(['Results/','Results ',date,'.xls'],toplabels,[savename],'B1');
xlswrite(['Results/','Results ',date,'.xls'],sidelabels,[savename],'A1')
xlswrite(['Results/','Results ',date,'.xls'],List,[savename],'B2');