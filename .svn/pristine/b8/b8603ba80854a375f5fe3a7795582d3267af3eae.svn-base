function Visuals(s,C,index,mx,my,vx,vy,mxkeep,mykeep,savename,mosqcount,run,mxind,myind,time)
% Produces animations of the current data being processed; screen captures
% are possible with end lines; the direction field of wind flow can be
% shown with the quiver command in case 2.

% for fullscreen: figure('Units','normalized','Position',[0 0 1 1])

minC = min(min(C));
maxC = max(max(C));

switch mosqcount
    case '2'
        contour(s.X,s.Y,C,minC:((maxC-minC)/20):maxC);
        title({[savename, ': run ', num2str(run)];['t = ',(num2str(s.tn(index)/60)) ' min']},'FontSize',11,'FontWeight','b');
        axis equal, axis([s.x0 s.xf s.y0 s.yf]), colorbar
        colormap(cool)
        hold on
            contour(s.X,s.Y,C,[s.Cthresh,s.Csat],':k','LineWidth',2);
            plot(s.Sx,s.Sy,'dk','MarkerSize',5,'MarkerFaceColor','y')
            plot(mx,my,'.k','MarkerSize',6,'MarkerFaceColor','k')
            plot(mxkeep,mykeep, '.r','MarkerSize',5,'MarkerFaceColor','r')
        % wind vector field
        %     quiver(X,Y,vx,vy)
        hold off
        saveas(gcf,['Movies/',[date,' ',time,' ',savename,' ',num2str(run) ],'/',num2str(index/s.frames),'.png'])
%         N = getframe(gcf);
    case '1'
        contour(s.X,s.Y,C,minC:((maxC-minC)/20):maxC);
        title({[savename, ': run ', num2str(run)];['t = ',(num2str(s.tn(index)/60)) ' min']},'FontSize',11,'FontWeight','b');
        axis equal, axis([s.x0 s.xf s.y0 s.yf]), colorbar
        colormap(cool)
        hold on
            contour(s.X,s.Y,C,[s.Cthresh,s.Csat],':k','LineWidth',2);
            plot(s.Sx,s.Sy,'dk','MarkerSize',5,'MarkerFaceColor','y')
            plot(mx,my,'ok','MarkerSize',3,'MarkerFaceColor','r')
            plot(mxind,myind,'-k','MarkerSize',2,'MarkerFaceColor','k')
        hold off
        saveas(gcf,['Movies/',[date,' ',time,' ',savename,' ',num2str(run) ],'/',num2str(index/s.frames),'.png'])
%         N = getframe(gcf);
end