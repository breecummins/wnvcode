clc

% Second-order centered difference approximations of concentrations given
% by the diffusion equation at positions over time

% dC/dt = D*((d2C)/(dx2))
% initial condition T(x,0) = x^2
% boundary conditions T(0,t) = 0, T(1,t) = 1
% 0<x<1, ti<t<tf

% diffusion constant D; number of intervals N
% interval length h
% D*dt/h^2 <= 1/2 (stability analysis); dt <= (h^2)/(2*D)
% position step j from 0 to N, position xj = jh
% time step n from 0 to 5/dt, time tn = n*dt

% C_k = C(xj,k)
% Derived approximation technique:
% C_k = C(:,k-1) + (D*dt/h^2)*A*(C(:,k-1))

D = .1; xi = 0; xf = 1; ti = 0; tf = 5; N = 16;
h = (xf-xi)/N; dt = (h^2)/(2*D);
n = ti:floor(tf/dt); j = 0:N;
xj = (j*h)'; tn = (n*dt);
C_0 = (xj).^2;

% creates coefficient matrix A
A = zeros(N+1,N+3);
for m = j+1
    A(m,m) = 1;
    A(m,m+1) = -2;
    A(m,m+2) = 1;
end
A(:,1) = [];
A(:,N+2) = [];

% inserts C_0 (initial condition) as first column in what will be the
% solution matrix
C = zeros(N+1,n(end));
C(:,1) = C_0;

% the approximations of the concentration for C_1 to C_end, inserted as
% columns in C
% the second and third lines are Dirichlet conditions; they pin the
% boundary conditions
for k = 2:(n(end))
    C(:,k) = C(:,k-1) + (D*dt/h^2)*A*(C(:,k-1));
    C(1,k) = 0;
    C(end,k) = 1;
end

% plot of concentration at xj over time
% initial condition plotted in red
hold on
plot(xj',C(:,1),'r')
for q = 2:(N+1)
    plot(xj',C(:,q))
end
hold off

title('\bf\fontsize{11}Concentrations at x_j over Time')
xlabel('Position')
ylabel('Concentration')