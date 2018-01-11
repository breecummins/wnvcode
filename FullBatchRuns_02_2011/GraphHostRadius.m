function GraphHostRadius(fname)

close all

load(fname)
hr = p.host_radius;

figure
plot(xc,yc,'k^')
hold on

theta=0:0.01:2*pi;

for k=1:length(xc);
	plot(xc(k)+hr*cos(theta),yc(k)+hr*sin(theta),'k-')
end

axis([0,100,0,100])

xcbar = mean(xc(xc<50));
ycbar = mean(yc(xc<50));

plot(xcbar+hr*cos(theta),ycbar+hr*sin(theta),'r-','LineWidth',2)

hold off	