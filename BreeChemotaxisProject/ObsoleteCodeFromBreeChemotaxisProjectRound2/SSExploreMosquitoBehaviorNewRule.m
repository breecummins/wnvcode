function [SpatialDistX,SpatialDistY]=SSExploreMosquitoBehavior6(newruleparams,fixedvars)

%chemotaxis rules only.  fixed CO2 gradient.

%make arrays to store mosquito position and memory
Xm = repmat(fixedvars.xm0,1,fixedvars.NumMethods);
Ym = repmat(fixedvars.ym0,1,fixedvars.NumMethods);
MosqMem = zeros(fixedvars.Nm,2,fixedvars.NumMethods);

%Store spatial distributions at tSpace times
SpatialDistX=zeros(fixedvars.Nm,fixedvars.NumMethods,0); %gray magic.  assigning SDX = [] makes an append in the 3rd dimension not work quite right
SpatialDistY=zeros(fixedvars.Nm,fixedvars.NumMethods,0);

for t = 0 : fixedvars.dt : fixedvars.Tf;

	%COMMENTED OUT RULES ARE NOT UPDATED!!
	% %Pick both direction and speed based on gradient.
	% method=[];
	% method=find(fixedvars.Methods==1);
	% if ~isempty(method);
	% 	[gradmag, theta0] = findGradMagAngle(Xm(:,method),Ym(:,method),fixedvars.dCdx,fixedvars.dCdy,fixedvars.h);
	% 	gradmagscaled = gradmag/newruleparams.Gsat;
	% 	clear gradmag
	% 	theta = pickDirectionNewRule(theta0,fixedvars.minang,fixedvars.maxang,gradmagscaled,newruleparams.g0,newruleparams.kappag);
	% 	spd = pickSpeedNewRule(fixedvars.minspd,fixedvars.maxspd,gradmagscaled,newruleparams.g0,newruleparams.kappag);
	% 	[Xm(:,method),Ym(:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.domainL);
	% 	clear theta spd gradmagscaled theta0
	% end
	
	%Pick direction based on CO2 gradient; pick speed based on absolute concentration.
	method=[];
	method=find(fixedvars.Methods==2);
	if ~isempty(method);
		Cm = InterpFromGrid(Xm(:,method),Ym(:,method),fixedvars.C,fixedvars.h)./newruleparams.Csat; 
		[gradmag, theta0] = findGradMagAngle(Xm(:,method),Ym(:,method),fixedvars.dCdx,fixedvars.dCdy,fixedvars.h);
		gradmagscaled = gradmag./newruleparams.Gsat; 
		clear gradmag
		theta = pickDirectionNewRule(theta0,fixedvars.minang,fixedvars.maxang,gradmagscaled,newruleparams.g0,newruleparams.kappag);
		spd = pickSpeedNewRule(fixedvars.minspd,fixedvars.maxspd,Cm,newruleparams.c0,newruleparams.kappac);
		[Xm(:,method),Ym(:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.domainL);
		clear theta spd gradmagscaled theta0 Cm
	end	
	
	%COMMENTED OUT RULES ARE NOT UPDATED!!
	% %Pick direction based on CO2 gradient; speed fixed.
	% method=[];
	% method=find(fixedvars.Methods==3);
	% if ~isempty(method);
	% 	[gradmag, theta0] = findGradMagAngle(Xm(:,method),Ym(:,method),fixedvars.dCdx,fixedvars.dCdy,fixedvars.h);
	% 	theta = pickDirection(theta0,newruleparams.minang,newruleparams.maxang,gradmag,fixedvars.maxG);
	% 	spd = newruleparams.fixedspd;
	% 	[Xm(:,method),Ym(:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.L);
	% 	% TimeToTarget = checkTarget(method,TimeToTarget,Xm(:,method),Ym(:,method),sourcex,sourcey,t,TargetRad);
	% 	clear theta spd gradmag theta0
	% end
	% 
	% %Pick direction based on CO2 gradient; speed random.
	% method=[];
	% method=find(fixedvars.Methods==4);
	% if ~isempty(method);
	% 	[gradmag, theta0] = findGradMagAngle(Xm(:,method),Ym(:,method),fixedvars.dCdx,fixedvars.dCdy,fixedvars.h);
	% 	theta = pickDirection(theta0,newruleparams.minang,newruleparams.maxang,gradmag,fixedvars.maxG);
	% 	spd = newruleparams.minspd + (newruleparams.maxspd-newruleparams.minspd)*rand(fixedvars.Nm,1);
	% 	[Xm(:,method),Ym(:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.L);
	% 	% TimeToTarget = checkTarget(method,TimeToTarget,Xm(:,method),Ym(:,method),sourcex,sourcey,t,TargetRad);
	% 	clear theta spd gradmag theta0
	% end
	% 
	% %Pick both direction and speed based on memory of absolute CO2 previous time step.
	% method=[];
	% method=find(fixedvars.Methods==5);
	% if ~isempty(method);
	% 	Cm = InterpFromGrid(Xm(:,method),Ym(:,method),fixedvars.C,fixedvars.h);
	% 	dif = Cm - MosqMem(:,1,method);
	% 	theta = pickDirection(MosqMem(:,2,method),newruleparams.minang,newruleparams.maxang,dif,maxDmem);
	% 	spd = pickSpeed(newruleparams.minspd,newruleparams.maxspd,dif,maxDmem);
	% 	[Xm(:,method),Ym(:,method), MosqMem(:,:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.L,Cm);
	% 	% TimeToTarget = checkTarget(method,TimeToTarget,Xm(:,method),Ym(:,method),sourcex,sourcey,t,TargetRad);
	% 	clear theta spd Cm dif
	% end
	% 
	% 
	% %Pick direction based on memory of absolute CO2 previous time step; pick speed based on absolute concentration.
	% method=[];
	% method=find(fixedvars.Methods==6);
	% if ~isempty(method);
	% 	Cm = InterpFromGrid(Xm(:,method),Ym(:,method),fixedvars.C,fixedvars.h);
	% 	Cmscaled = min(Cm/newruleparams.Csat,1);
	% 	clear Cm
	% 	dif = Cmscaled - MosqMem(:,1,method); 
	% 	theta = pickDirectionNewRule(MosqMem(:,2,method),fixedvars.minang,fixedvars.maxang,dif,newruleparams.c0,newruleparams.kappac);
	% 	spd = pickSpeedNewRule(fixedvars.minspd,fixedvars.maxspd,Cmscaled,newruleparams.c0,newruleparams.kappac);
	% 	[Xm(:,method),Ym(:,method), MosqMem(:,:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.domainL,Cmscaled);
	% 	clear theta spd Cmscaled dif
	% end
	% 
	% %Pick direction based on memory of absolute CO2 previous time step; speed fixed.
	% method=[];
	% method=find(fixedvars.Methods==7);
	% if ~isempty(method);
	% 	Cm = InterpFromGrid(Xm(:,method),Ym(:,method),fixedvars.C,fixedvars.h);
	% 	dif = Cm - MosqMem(:,1,method);
	% 	theta = pickDirection(MosqMem(:,2,method),newruleparams.minang,newruleparams.maxang,dif,maxDfixed);
	% 	spd = newruleparams.fixedspd; 
	% 	[Xm(:,method),Ym(:,method), MosqMem(:,:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.L,Cm);
	% 	% TimeToTarget = checkTarget(method,TimeToTarget,Xm(:,method),Ym(:,method),sourcex,sourcey,t,TargetRad);
	% 	clear theta spd Cm dif
	% end
	% 
	% %Pick direction based on memory of absolute CO2 previous time step; speed random.
	% method=[];
	% method=find(fixedvars.Methods==8);
	% if ~isempty(method);
	% 	Cm = InterpFromGrid(Xm(:,method),Ym(:,method),fixedvars.C,fixedvars.h);
	% 	dif = Cm - MosqMem(:,1,method);
	% 	theta = pickDirection(MosqMem(:,2,method),newruleparams.minang,newruleparams.maxang,dif,maxDrand);
	% 	spd =  newruleparams.minspd + (newruleparams.maxspd-newruleparams.minspd)*rand(fixedvars.Nm,1);
	% 	[Xm(:,method),Ym(:,method), MosqMem(:,:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.L,Cm);
	% 	% TimeToTarget = checkTarget(method,TimeToTarget,Xm(:,method),Ym(:,method),sourcex,sourcey,t,TargetRad);
	% 	clear theta spd Cm dif
	% end	
	% 
	% %Pick speed based on absolute concentration; direction random.
	% method=[];
	% method=find(fixedvars.Methods==9);
	% if ~isempty(method);
	% 	Cm = InterpFromGrid(Xm(:,method),Ym(:,method),fixedvars.C,fixedvars.h);
	% 	theta = 2*pi*rand(fixedvars.Nm,1);
	% 	spd = pickSpeed(newruleparams.minspd,newruleparams.maxspd,Cm,fixedvars.maxC);
	% 	[Xm(:,method),Ym(:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.L);
	% 	% TimeToTarget = checkTarget(method,TimeToTarget,Xm(:,method),Ym(:,method),sourcex,sourcey,t,TargetRad);
	% 	clear theta spd Cm
	% end
	% 
	% %Plain old diffusion
	% method=[];
	% method=find(fixedvars.Methods==10);
	% if ~isempty(method);
	% 	theta = 2*pi*rand(fixedvars.Nm,1);
	% 	spd = newruleparams.fixedspd;	
	% 	[Xm(:,method),Ym(:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.L);
	% 	% TimeToTarget = checkTarget(method,TimeToTarget,Xm(:,method),Ym(:,method),sourcex,sourcey,t,TargetRad);
	% 	clear theta spd
	% end
	
	%save spatial distributions
	if any(abs(fixedvars.tSpace-t) < 1.e-3*fixedvars.dt);
		SpatialDistX(:,:,end+1) = Xm;
		SpatialDistY(:,:,end+1) = Ym;
	end
	
	if mod(t,25)==0;
		disp(['t = ',num2str(t)])
	end

	if  t > fixedvars.dt/2 && mod(t,fixedvars.tGraph)==0; 
		
		figure(1);
		% % clf
		h=fixedvars.h;
		C=fixedvars.C;
		%graph the concentration with 50 contour lines
		contour((h/2:h:1-h/2),(h/2:h:1-h/2),C,30);
		title(['Time = ',num2str(t)],'FontSize',14);
		colormap(hot);
		colorbar;
		axis equal;
		axis([0,fixedvars.domainL,0,fixedvars.domainL]);
		axis off;
		hold on;
		
		%Plot mosquitoes
		c = { 'k.','b.','r.','c.','m.','ks','bs','rs','cs','ms' };
		leg={'CO2'};
		for k =1:fixedvars.NumMethods;
			plot(Xm(:,k),Ym(:,k),c{k});  
			leg{end+1}=int2str(fixedvars.Methods(1));
		end 
		
		legend(leg,'Location','NorthEastOutside');
		
		pause(0.0001);
		
		hold off;
	end
end

