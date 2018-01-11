function N = Visuals(s,C,index,mx,my,vx,vy,mxkeep,mykeep,savename,mosqcount,run,mxind,myind);
% Produces animations of the current data being processed; screen captures
% are possible with lines 34-36; the direction field of wind flow can be
% shown with line 18


minC = min(min(C));
maxC = max(max(C));

switch mosqcount
    case '2'
        contour(s.X,s.Y,C,minC:((maxC-minC)/20):maxC);
        title({[savename, ': run ', num2str(run)];['t = ',num2str(s.tn(index)) ' min']},'FontSize',11,'FontWeight','b');
        axis equal, axis([s.x0 s.xf s.y0 s.yf]), colorbar
        colormap(cool)
        hold on
            contour(s.X,s.Y,C,[s.dCm,s.dCM],':k','LineWidth',2);
            plot(s.Sx,s.Sy,'dk','MarkerSize',5,'MarkerFaceColor','y')
            plot(mx,my,'.k','MarkerSize',6,'MarkerFaceColor','k')
            plot(mxkeep,mykeep, '.r','MarkerSize',5,'MarkerFaceColor','r')
        % wind vector field
        %     quiver(X,Y,vx,vy)
        hold off
        N = getframe(gcf);
    case '1'
        contour(s.X,s.Y,C,minC:((maxC-minC)/20):maxC);
        title({[savename, ': run ', num2str(run)];['t = ',num2str(s.tn(index)) ' min']},'FontSize',11,'FontWeight','b');
        axis equal, axis([s.x0 s.xf s.y0 s.yf]), colorbar
        colormap(cool)
        hold on
            contour(s.X,s.Y,C,[s.dCm,s.dCM],':k','LineWidth',2);
            plot(s.Sx,s.Sy,'dk','MarkerSize',5,'MarkerFaceColor','y')
            plot(mx,my,'ok','MarkerSize',3,'MarkerFaceColor','r')
            plot(mxind,myind,'-k','MarkerSize',2,'MarkerFaceColor','k')
        hold off
        N = getframe(gcf);
end

% if index == 3000
%     saveas(gcf,'MosquitoPath.bmp')
% end