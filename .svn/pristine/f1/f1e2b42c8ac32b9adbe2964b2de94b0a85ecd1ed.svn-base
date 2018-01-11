function [List] = Results(List,savename,nummosq,runcount,time,day)

% Calculates averages of data produced by Matrix.m and saves results as
% .mat file

avg1 = mean(List(1,:));     % number of mosquitoes finding larger group
avg2 = mean(List(2,:));     % per-capita ratio at larger group
avg3 = mean(List(3,:));     % number of mosquitoes finding smaller group = per-capita ratio
avg4 = mean(List(4,:));     % ratio of smaller to larger per-capita group ratios
avgval = [avg1; avg2; avg3; avg4];
List(:,end+1) = avgval;

% standard deviation
opr = List(4,1:(end-1));
sd_num = sum(opr);
sd_avg = sd_num/runcount;
sd_pts = (opr-sd_avg).^2;
st_dev = sqrt((sum(sd_pts))/runcount);
List(5,end) = st_dev;

save(['Results/',day,'/',time,'/',savename,'.mat'],'List','nummosq')
fprintf('\n')
disp('Columns sorted by run')
disp('Row 1: number of mosquitoes finding larger group')
disp('Row 2: per-capita ratio at larger group')
disp('Row 3: number of mosquitoes finding smaller group = per-capita ratio')
disp('Row 4: ratio of smaller to larger per-capita group ratios')
disp('Row 5: standard deviation')
fprintf('\n')
disp(List)