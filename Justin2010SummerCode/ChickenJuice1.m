% ChickenJuice.m

clear

%SET RANDOM SEED
a=version;
if str2num(a(1:3)) >= 7.7;
	RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock)));
%	defaultStream = RandStream.getDefaultStream;
%	savedState = defaultStream.State;
else;
	rand('twister',sum(100*clock))
	randn('state',sum(100*clock)) 
end

%INITIALIZE VALUES
[L,Ng,nu,dt,Tf,U,xg,yg,h,tGraph] = setParams;

for wind_mode = 1:4
    [xc,yc,tChick] = setChickens(L);
    [xm0,ym0,tm,tMosq,tReport, mem0] = setMosquitoes(L,h,Tf,dt,wind_mode); %%NEW
    [V1,V2,Vmag] = setInitialVel(Ng);
    [r1,r2,V1p,V1m,V2p,V2m,tRand] = setRandomVel(V1,V2,Vmag,Ng,dt);
    %[distsqd] = initialCalculations(xc,yc,xg,yg);

    C = zeros(Ng,Ng);
    xm=[];
    ym=[];
    mem=[];
    count = zeros(1,length(xc));
    lost=0;


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

        % MOVE THE CRITTERS
        if (mod(t,tChick) == 0)
            [xc,yc] = MoveChickens(xc,yc,tChick);
        end
        if (mod(t,tMosq) == 0)
            if ~isempty(xm);
                [xm,ym,count,lost, mem] = MoveMosquitoes(xm,ym,tMosq,V1p,V1m,V2p,V2m,C,Cxp,Cxm,Cyp,Cym,h,L,xc,yc,count,lost,mem,wind_mode,Vmag);
            end
        end
        if ~isempty(tm) && t > tm(1);
            [xm,ym,tm,xm0,ym0, mem, mem0] = insertMosquitoes(t,tm,xm,ym,mem,xm0,ym0, mem0); %%NEW
        end
%         if (mod(t,tReport) == 0) && (~isempty(xm) || isempty(tm));
%            disp([int2str(lost),' mosquitoes have left the area.'])
%            disp('Bites per host: ')
%            disp(count)
%         end


        % RECALCULATE RANDOM WIND
        if (mod(t,tRand) == 0)
            [r1,r2,V1p,V1m,V2p,V2m] = setRandomVel(V1,V2,Vmag,Ng,dt);
        end 

        % GRAPH CO2, CHICKENS, AND MOSQUITOES
        if mod(t,tGraph)==0;
            GraphC(C,t,h,xm,ym,xc,yc);
        end

        clear Cxp Cxm Cyp Cym S D A

    end
   
    disp('Bites per host: ')
    disp(count)
    if (wind_mode ~= 4)
      evalResponse = input('Press enter to continue','s');
    end
end