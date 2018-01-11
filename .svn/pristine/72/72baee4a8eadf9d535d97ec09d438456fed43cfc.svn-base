%%%%%%
% ExploreChickenPosition.m
%
% Function to test the effects of relative positioning and distribution
% of the CO2 sources.
%
% Input parameters define the positions of the different CO2 sources.
%%%%%%
function [tDist,hostInd] = ExploreChickenPosition(xc,yc)
%Initialization code borrowed from ChickenJuice
rand('twister',sum(100*clock))
randn('state',sum(100*clock)) 

%INITIALIZE VALUES
[L,Ng,nu,dt,Tf,U,xg,yg,h] = setParams;

%CREATE MOSQUITOES
[xm1,ym1,tm,tMosq,tReport,mem1] = setMosquitoes(L,h,Tf,dt,1);
[xm2,ym2,tm,tMosq,tReport,mem2] = setMosquitoes(L,h,Tf,dt,2);
[xm3,ym3,tm,tMosq,tReport,mem3] = setMosquitoes(L,h,Tf,dt,3);
[xm4,ym4,tm,tMosq,tReport,mem4] = setMosquitoes(L,h,Tf,dt,4);

%CREATE WIND
[V1,V2,Vmag] = setInitialVel(Ng);
[r1,r2,V1p,V1m,V2p,V2m,tRand] = setRandomVel(V1,V2,Vmag,Ng,dt);

%Store the timestep at which a mosquito finds a host as well as which
%host it finds.
tDist = zeros(200,4);
hostInd = zeros(200,4);
%Helper variable to track how many points have been added to
%tDist and hostInd
num_entries = ones(1,4);

C = zeros(Ng,Ng);
count = zeros(4,length(xc));

lost = 0;
tBegin = 2;
%RUN THE FOR LOOP
for t = 0 : dt : Tf
	
	% MAKE MATRICES FOR CALCULATING DERIVATIVES
	[Cxp,Cxm,Cyp,Cym] = SliceC(C);
	
	% SPREAD THE SOURCE CO2 TO THE UNDERLYING GRID
	S = SpreadToGrid(xc,yc,C,h,U*dt);
	
	% CALCULATE DIFFUSION
	D = DiffuseC(C, dt, h, nu, Cxp, Cxm, Cyp, Cym);

	% CALCULATE ADVECTION
  	A = AdvectC(dt, h, V1p, V1m, V2p, V2m, Cxp, Cxm, Cyp, Cym, C);	

	% SUM ALL OF THE TERMS.
	C = S + D + A; % S has both the old C and the new source C in it.

    %Hold the mosquitoes from entering until the CO2 has had some
    %time to diffuse.
    if (t > tBegin)
        %Move the mosquitoes in each individual simulation
        if (mod(t,tMosq) == 0)
            tempCount = zeros(1,length(xc));
            
            if (sum(count(2,:)) < 200)
            [xm1,ym1,tempCount,lost,mem1] = MoveMosquitoes(xm1,ym1,tMosq,V1p,V1m,V2p,V2m,C,Cxp,Cxm,Cyp,Cym,h,L,xc,yc,count(1,:),lost,mem1,1);
            %Check if any mosquitoes hit a host on the last step
            dif = tempCount - count(1,:);
            ind_dif = find(dif ~= 0);
            if (length(ind_dif) ~= 0)
                for i = ind_dif
                    to_add_host = ones(dif(i),1).*i;
                    to_add_time = ones(dif(i),1).*t;
                    curr_index = num_entries(1);
                    tDist(curr_index:curr_index+dif(i)-1,1) = to_add_time;
                    hostInd(curr_index:curr_index+dif(i)-1,1) = to_add_host;
                    num_entries(1) = num_entries(1) + dif(i);
                end
            end
            count(1,:) = tempCount;
            end

            if (sum(count(2,:)) < 200)
            [xm2,ym2,tempCount,lost,mem2] = MoveMosquitoes(xm2,ym2,tMosq,V1p,V1m,V2p,V2m,C,Cxp,Cxm,Cyp,Cym,h,L,xc,yc,count(2,:),lost,mem2,2);
            %Check if any mosquitoes hit a host on the last run
            dif = tempCount - count(2,:);
            ind_dif = find(dif ~= 0);
            if (length(ind_dif) ~= 0)
                for i = ind_dif
                    to_add_host = ones(dif(i),1).*i;
                    to_add_time = ones(dif(i),1).*t;
                    curr_index = num_entries(2);
                    tDist(curr_index:curr_index+dif(i)-1,2) = to_add_time;
                    hostInd(curr_index:curr_index+dif(i)-1,2) = to_add_host;
                    num_entries(2) = num_entries(2) + dif(i);
                end
            end
            count(2,:) = tempCount;
            end

            if (sum(count(3,:)) < 200)
            [xm3,ym3,tempCount,lost,mem3] = MoveMosquitoes(xm3,ym3,tMosq,V1p,V1m,V2p,V2m,C,Cxp,Cxm,Cyp,Cym,h,L,xc,yc,count(3,:),lost,mem3,3);
            %Check if any mosquitoes hit a host on the last run
            dif = tempCount - count(3,:);
            ind_dif = find(dif ~= 0);
            if (length(ind_dif) ~= 0)
                for i = ind_dif
                    to_add_host = ones(dif(i),1).*i;
                    to_add_time = ones(dif(i),1).*t;
                    curr_index = num_entries(3);
                    tDist(curr_index:curr_index+dif(i)-1,3) = to_add_time;
                    hostInd(curr_index:curr_index+dif(i)-1,3) = to_add_host;
                    num_entries(3) = num_entries(3) + dif(i);
                end
            end
            count(3,:) = tempCount;
            end

            if (sum(count(4,:)) < 200)
            [xm4,ym4,tempCount,lost,mem4] = MoveMosquitoes(xm4,ym4,tMosq,V1p,V1m,V2p,V2m,C,Cxp,Cxm,Cyp,Cym,h,L,xc,yc,count(4,:),lost,mem4,4);
            %Check if any mosquitoes hit a host on the last run
            dif = tempCount - count(4,:);
            ind_dif = find(dif ~= 0);
            if (length(ind_dif) ~= 0)
                for i = ind_dif
                    to_add_host = ones(dif(i),1).*i;
                    to_add_time = ones(dif(i),1).*t;
                    curr_index = num_entries(4);
                    tDist(curr_index:curr_index+dif(i)-1,4) = to_add_time;
                    hostInd(curr_index:curr_index+dif(i)-1,4) = to_add_host;
                    num_entries(4) = num_entries(4) + dif(i);
                end
            end
            count(4,:) = tempCount;
            end
        end
    end
    
    % RECALCULATE RANDOM WIND
	if (mod(t,tRand) == 0)
		[r1,r2,V1p,V1m,V2p,V2m] = setRandomVel(V1,V2,Vmag,Ng,dt);
	end 

	clear Cxp Cxm Cyp Cym S D A
end
