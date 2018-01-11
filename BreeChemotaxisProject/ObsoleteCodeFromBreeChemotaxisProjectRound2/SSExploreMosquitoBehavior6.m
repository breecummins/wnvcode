function [SpatialDistX,SpatialDistY]=SSExploreMosquitoBehavior6(ruleparams,fixedvars)

%chemotaxis rules only.  fixed CO2 gradient.

%make arrays to store mosquito position and memory
Xm = repmat(fixedvars.xm0,1,fixedvars.NumMethods);
Ym = repmat(fixedvars.ym0,1,fixedvars.NumMethods);
MosqMem = zeros(fixedvars.Nm,2,fixedvars.NumMethods);

%calculate scaling factors for temporal gradient rule sets ( = max(spatial gradient * speed * dt) )
% maxDmem = fixedvars.maxG *( ruleparams.maxspd^2/(4*(ruleparams.maxspd-ruleparams.minspd)) )*fixedvars.dt; %based on approx speed as being chosen over the spatial gradient
maxDmem = fixedvars.maxG * ruleparams.maxspd *fixedvars.dt; %largest possible
maxDconc = fixedvars.maxG *((1-exp(-0.5))*ruleparams.maxspd + exp(-0.5)*ruleparams.minspd)*fixedvars.dt; %max occurs at inflection pt of C
maxDfixed = fixedvars.maxG *ruleparams.fixedspd*fixedvars.dt; %max occurs at max gradient with fixed flight speed
maxDrand = fixedvars.maxG *ruleparams.maxspd*fixedvars.dt; % max is seen when max speed is randomly picked at max gradient

%Store spatial distributions at tSpace times
SpatialDistX=zeros(fixedvars.Nm,fixedvars.NumMethods,0); %gray magic.  assigning SDX = [] makes an append in the 3rd dimension not work quite right
SpatialDistY=zeros(fixedvars.Nm,fixedvars.NumMethods,0);

% fixedvars.tGraph=5;
% % %initialize figures
% figure(1)  %comment out
% %change size of window
% g=get(gcf,'Position');  %comment out
% set(gcf,'Position',[g(1)-g(1)/2,2*g(2),2*g(3),2*g(4)]) %comment out

for t = 0 : fixedvars.dt : fixedvars.Tf;

	%Pick both direction and speed based on gradient.
	method=[];
	method=find(fixedvars.Methods==1);
	if ~isempty(method);
		[gradmag, theta0] = findGradMagAngle(Xm(:,method),Ym(:,method),fixedvars.dCdx,fixedvars.dCdy,fixedvars.h);
		theta = pickDirection(theta0,ruleparams.minang,ruleparams.maxang,gradmag,fixedvars.maxG);
		spd = pickSpeed(ruleparams.minspd,ruleparams.maxspd,gradmag,fixedvars.maxG);
		[Xm(:,method),Ym(:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.L);
		% TimeToTarget = checkTarget(method,TimeToTarget,Xm(:,method),Ym(:,method),sourcex,sourcey,t,TargetRad);
		clear theta spd gradmag theta0
	end
	
	%Pick direction based on CO2 gradient; pick speed based on absolute concentration.
	method=[];
	method=find(fixedvars.Methods==2);
	if ~isempty(method);
		Cm = InterpFromGrid(Xm(:,method),Ym(:,method),fixedvars.C,fixedvars.h);
		[gradmag, theta0] = findGradMagAngle(Xm(:,method),Ym(:,method),fixedvars.dCdx,fixedvars.dCdy,fixedvars.h);
		theta = pickDirection(theta0,ruleparams.minang,ruleparams.maxang,gradmag,fixedvars.maxG);
		spd = pickSpeed(ruleparams.minspd,ruleparams.maxspd,Cm,fixedvars.maxC);
		[Xm(:,method),Ym(:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.L);
		% TimeToTarget = checkTarget(method,TimeToTarget,Xm(:,method),Ym(:,method),sourcex,sourcey,t,TargetRad);
		clear theta spd gradmag theta0 Cm
	end	
	
	%Pick direction based on CO2 gradient; speed fixed.
	method=[];
	method=find(fixedvars.Methods==3);
	if ~isempty(method);
		[gradmag, theta0] = findGradMagAngle(Xm(:,method),Ym(:,method),fixedvars.dCdx,fixedvars.dCdy,fixedvars.h);
		theta = pickDirection(theta0,ruleparams.minang,ruleparams.maxang,gradmag,fixedvars.maxG);
		spd = ruleparams.fixedspd;
		[Xm(:,method),Ym(:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.L);
		% TimeToTarget = checkTarget(method,TimeToTarget,Xm(:,method),Ym(:,method),sourcex,sourcey,t,TargetRad);
		clear theta spd gradmag theta0
	end
	
	%Pick direction based on CO2 gradient; speed random.
	method=[];
	method=find(fixedvars.Methods==4);
	if ~isempty(method);
		[gradmag, theta0] = findGradMagAngle(Xm(:,method),Ym(:,method),fixedvars.dCdx,fixedvars.dCdy,fixedvars.h);
		theta = pickDirection(theta0,ruleparams.minang,ruleparams.maxang,gradmag,fixedvars.maxG);
		spd = ruleparams.minspd + (ruleparams.maxspd-ruleparams.minspd)*rand(fixedvars.Nm,1);
		[Xm(:,method),Ym(:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.L);
		% TimeToTarget = checkTarget(method,TimeToTarget,Xm(:,method),Ym(:,method),sourcex,sourcey,t,TargetRad);
		clear theta spd gradmag theta0
	end
	
	%Pick both direction and speed based on memory of absolute CO2 previous time step.
	method=[];
	method=find(fixedvars.Methods==5);
	if ~isempty(method);
		Cm = InterpFromGrid(Xm(:,method),Ym(:,method),fixedvars.C,fixedvars.h);
		dif = Cm - MosqMem(:,1,method);
		theta = pickDirection(MosqMem(:,2,method),ruleparams.minang,ruleparams.maxang,dif,maxDmem);
		spd = pickSpeed(ruleparams.minspd,ruleparams.maxspd,dif,maxDmem);
		[Xm(:,method),Ym(:,method), MosqMem(:,:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.L,Cm);
		% TimeToTarget = checkTarget(method,TimeToTarget,Xm(:,method),Ym(:,method),sourcex,sourcey,t,TargetRad);
		clear theta spd Cm dif
	end
	
	%Pick direction based on memory of absolute CO2 previous time step; pick speed based on absolute concentration.
	method=[];
	method=find(fixedvars.Methods==6);
	if ~isempty(method);
		Cm = InterpFromGrid(Xm(:,method),Ym(:,method),fixedvars.C,fixedvars.h);
		dif = Cm - MosqMem(:,1,method);
		theta = pickDirection(MosqMem(:,2,method),ruleparams.minang,ruleparams.maxang,dif,maxDconc);
		spd = pickSpeed(ruleparams.minspd,ruleparams.maxspd,Cm,fixedvars.maxC);
		[Xm(:,method),Ym(:,method), MosqMem(:,:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.L,Cm);
		% TimeToTarget = checkTarget(method,TimeToTarget,Xm(:,method),Ym(:,method),sourcex,sourcey,t,TargetRad);
		clear theta spd Cm dif
	end
	
	%Pick direction based on memory of absolute CO2 previous time step; speed fixed.
	method=[];
	method=find(fixedvars.Methods==7);
	if ~isempty(method);
		Cm = InterpFromGrid(Xm(:,method),Ym(:,method),fixedvars.C,fixedvars.h);
		dif = Cm - MosqMem(:,1,method);
		theta = pickDirection(MosqMem(:,2,method),ruleparams.minang,ruleparams.maxang,dif,maxDfixed);
		spd = ruleparams.fixedspd; 
		[Xm(:,method),Ym(:,method), MosqMem(:,:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.L,Cm);
		% TimeToTarget = checkTarget(method,TimeToTarget,Xm(:,method),Ym(:,method),sourcex,sourcey,t,TargetRad);
		clear theta spd Cm dif
	end
	
	%Pick direction based on memory of absolute CO2 previous time step; speed random.
	method=[];
	method=find(fixedvars.Methods==8);
	if ~isempty(method);
		Cm = InterpFromGrid(Xm(:,method),Ym(:,method),fixedvars.C,fixedvars.h);
		dif = Cm - MosqMem(:,1,method);
		theta = pickDirection(MosqMem(:,2,method),ruleparams.minang,ruleparams.maxang,dif,maxDrand);
		spd =  ruleparams.minspd + (ruleparams.maxspd-ruleparams.minspd)*rand(fixedvars.Nm,1);
		[Xm(:,method),Ym(:,method), MosqMem(:,:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.L,Cm);
		% TimeToTarget = checkTarget(method,TimeToTarget,Xm(:,method),Ym(:,method),sourcex,sourcey,t,TargetRad);
		clear theta spd Cm dif
	end	
	
	%Pick speed based on absolute concentration; direction random.
	method=[];
	method=find(fixedvars.Methods==9);
	if ~isempty(method);
		Cm = InterpFromGrid(Xm(:,method),Ym(:,method),fixedvars.C,fixedvars.h);
		theta = 2*pi*rand(fixedvars.Nm,1);
		spd = pickSpeed(ruleparams.minspd,ruleparams.maxspd,Cm,fixedvars.maxC);
		[Xm(:,method),Ym(:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.L);
		% TimeToTarget = checkTarget(method,TimeToTarget,Xm(:,method),Ym(:,method),sourcex,sourcey,t,TargetRad);
		clear theta spd Cm
	end
	
	%Plain old diffusion
	method=[];
	method=find(fixedvars.Methods==10);
	if ~isempty(method);
		theta = 2*pi*rand(fixedvars.Nm,1);
		spd = ruleparams.fixedspd;	
		[Xm(:,method),Ym(:,method)]=SSupdateMosq(Xm(:,method),Ym(:,method),theta,spd,fixedvars.dt,fixedvars.h,fixedvars.L);
		% TimeToTarget = checkTarget(method,TimeToTarget,Xm(:,method),Ym(:,method),sourcex,sourcey,t,TargetRad);
		clear theta spd
	end
	
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
		
		%graph the concentration with 50 contour lines
		Cmx = max(max(fixedvars.C));
		contour((fixedvars.h/2:fixedvars.h:1-fixedvars.h/2),(fixedvars.h/2:fixedvars.h:1-fixedvars.h/2),fixedvars.C,(0:0.05*Cmx:Cmx));
		title(['Time = ',num2str(t)],'FontSize',14);
		colormap(hot);
		colorbar;
		axis equal;
		axis([0,1,0,1]);
		axis off;
		hold on;
		
		%Plot mosquitoes
		c = { 'k.','b.','r.','c.','m.','ks','bs','rs','cs','ms' };
		leg={'CO2'};
		for k =1:fixedvars.NumMethods;
			plot(Xm(:,k),Ym(:,k),c{k});  %flip x and y to be compatible with the meshgrid representation of the CO2
			leg{end+1}=fixedvars.descriptions{k};
		end 
		
		legend(leg,'Location','NorthEastOutside');
		
		pause(0.0001);
		
		hold off;
	end
end

