%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CO2 GRID PARAMETERS
L = 1; % Everything takes place in the square [0,L]x[0,L]
Ng = 100;
h = L/Ng;
[xg,yg] = meshgrid( h/2 : h : L-h/4 );  
%%

%INITIAL CO2 CONCENTRATION
nu = 0.000;
C = exp( -40*((xg-0.4).^2+(yg-0.37).^2) );
C = 0.5*xg;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

dt = h;
Tf = 40; % FINAL TIME 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MOSQUITOES                            
                                        
Nm = 200; %NUMBER OF MOSQUITOES    
[xm,ym] = PlacePoints(Nm,[0.49 0.51]*L,[0.79 0.81]*L);        
dxm = 0*xm;  dym = 0*ym;  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RANDOM WALK PARAMETERS FOR MOSQUITOES
% dx = S*cos(theta), dy = S*sin(theta)
% WHERE S = unif. random in [0,csi*dt] AND
% theta = unif. random in [0 2pi]

csiMax = 0.05; % RATIO: RANDOM SPEED OF MOSQ/RANDOM SPEED OF GRADIENT

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% START THE TIME LOOP

tcount = 0;
for t = 0 : dt : Tf
    tcount = tcount + 1;
%% DIFFUSE THE CO2 (Neumann conditions)
C_ym1 = [C(1,:); C(1:end-1,:)];
C_yp1 = [C(2:end,:); C(end,:)];
C_xp1 = [C(:,2:end), C(:,end)];
C_xm1 = [C(:,1),C(:,1:end-1)];

C = C + (nu*dt/h^2)*(C_ym1 + C_yp1 + C_xp1 + C_xm1 - 4*C);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIND THE CONCENTRATION AT THE MOSQUITO LOCATIONS

Cm = interp2(xg,yg,C,xm,ym);

% RANDOM WALK STEP WILL DEPEND ON THE LOCAL CONCENTRATION
theta = 2*pi*rand(Nm,1);
stp = csiMax ./ (1 + 10*abs(Cm));

dxm = stp.*cos(theta);
dym = stp.*sin(theta);
xm = xm + dxm;
ym = ym + dym;

% KEEP THEM IN BOUNDS IN CASE THEY STEP OUT OF THE BOX
   idxj = find( ym>1-2*h ); if isempty(idxj)==0, ym(idxj) = ym(idxj)-dym(idxj); end
   idxj = find( ym<2*h );   if isempty(idxj)==0, ym(idxj) = ym(idxj)-dym(idxj); end
   idxi = find( xm>1-2*h ); if isempty(idxi)==0, xm(idxi) = xm(idxi)-dxm(idxi); end
   idxi = find( xm<2*h );   if isempty(idxi)==0, xm(idxi) = xm(idxi)-dxm(idxi); end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT THE CURRENT POSITIONS AND THE CO2 CONCENTRATION
Cmx = max(max(C))+1;

if mod(tcount,1)==0, 
	figure(1)
    contour(xg,yg,C,(0.01:0.05:Cmx))
    hold on,  plot(xm,ym,'b.'), hold off
    title(['Time = ',num2str(t)],'FontSize',14)
    axis equal,axis([0 1 0 1]),view(2),pause(0.01),hold off
end

end


clear advC alpha dCdx dCdy dx dxm dy dym gradmag gradxm gradym 