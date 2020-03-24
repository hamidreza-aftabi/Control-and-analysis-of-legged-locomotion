
clc
clear 
warning off
close all


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%initialize
 
% %  1.5 m/s perturbation
 alpha=75;
 xpp=-.1;
 xinS=1.13;
 yinS=.21;
 xp=xpp;
 yp=sin(alpha/180*pi);
 k=280;


% % % %  1.5 m/s 
%  alpha=75;
%  xpp=-.1;
%  xinS=1.16;
%  yinS=.21;
%  xp=xpp;
%  yp=sin(alpha/180*pi);
%  k=280;

 
% % % .5 m/s
% alpha=81.28;
% xpp=-.0495;
% xinS=.6163253025;
% yinS=.38;
% k=150;
% xp=xpp;
% yp=sin(alpha/180*pi);
% 


xf=0;
GRF=0;
GRFX=0;
GRFY=0;
height=0;


F(1000) = struct('cdata',[],'colormap',[]);
cou=1;
deltax=0;

 
for z=1:10

  %%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%% find apex
   
   alpha=75;
   sim('findmaxRet')
   ypos=sy.signals.values;
   
   [MAX,t]=max(ypos);
   tMAX=.01*t;
   alphaR=71;
   
    
  %%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%Single support

    sim('ssupLegRet')

    alpha=alpha2.signals.values(end);
    
    xpos=sx.signals.values;
    xspeed=sxs.signals.values;

    ypos=sy.signals.values;
    yspeed=sys.signals.values;
    
    GRFS=GRFS.signals.values;
    GRFSX=GRFSX.signals.values;
    GRFSY=GRFSY.signals.values;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % % Double support

    x=xpos(end);
    y=ypos(end);

    x1=xspeed(end);
    y1=yspeed(end);

    xf1=0;
    xf2=cos(alpha/180*pi)-xpp;
    k1=k;

    sim('dsupLegRet')


    dxs=xd1.signals.values;
    dys=yd1.signals.values;
    dxpos=xd.signals.values;
    dypos=yd.signals.values;


    xinS=xd1.signals.values(end);
    yinS=yd1.signals.values(end);
    xp=xd.signals.values(end)-(cos(alpha/180*pi)-xpp);
    yp=yd.signals.values(end);
    
    GRFD=GRFD.signals.values;
    GRFDX=GRFDX.signals.values;
    GRFDY=GRFDY.signals.values;
    
    swing=linspace(xf-(cos(alpha/180*pi)-xpp)+deltax,xf2+deltax,length(xpos));
    
    GRF=[GRF,GRFS',GRFD(2:end)'];
    GRFY=[GRFY,GRFSY',GRFDY(2:end)'];
    GRFX=[GRFX,GRFSX',GRFDX(2:end)'];
    height=[height,ypos',dypos'];
    
    %%%%%%%%%%%%%%%%  PLOT
      
    for i=1:length(xpos)
        
            clf
            xa = xf+deltax; ya = 0; xb = xpos(i)+deltax; yb = ypos(i)-.07; ne =15; a =1.6 ; ro =.01;
            [xs,ys] = spring(xa,ya,xb,yb,ne,a,ro);
            plot(xs,ys,'LineWidth',2,'color','b')
            hold on
            plot(xf+deltax,0,'or','MarkerSize',7,'MarkerFaceColor','r')
            hold on
            xa =swing(i); ya = 0; xb = xpos(i)+deltax; yb = ypos(i)-.07; ne =15; a =1.6 ; ro =.01;
            [xs,ys] = spring(xa,ya,xb,yb,ne,a,ro);
            plot(xs,ys,'LineWidth',2,'color','b')
            hold on
            plot(swing(i),0,'or','MarkerSize',7,'MarkerFaceColor','r')
            hold on 
            plot(xpos(i)+deltax,ypos(i),'or','MarkerSize',19,'MarkerFaceColor','r')
            
            axis([-1 6 0 3]);
            pause(.000001)
            F(cou) = getframe(gcf);
            cou=cou+1; 
    end

    
    for i=1:length(dxpos)
        
            clf
            xa =xf1+deltax; ya = 0; xb = dxpos(i)+deltax; yb = dypos(i)-.07; ne =15; a =1.6 ; ro =.01;
            [xs,ys] = spring(xa,ya,xb,yb,ne,a,ro);
            plot(xs,ys,'LineWidth',2,'color','b')
            hold on
            xa =xf2+deltax; ya = 0; xb = dxpos(i)+deltax; yb = dypos(i)-.07; ne =15; a =1.6 ; ro =.01;
            [xs,ys] = spring(xa,ya,xb,yb,ne,a,ro);
            plot(xs,ys,'LineWidth',2,'color','b')
            hold on
            plot(xf1+deltax,0,'or','MarkerSize',7,'MarkerFaceColor','r')
            hold on 
            plot(xf2+deltax,0,'or','MarkerSize',7,'MarkerFaceColor','r')
            hold on
            plot(dxpos(i)+deltax,dypos(i),'or','MarkerSize',19,'MarkerFaceColor','r')
            axis([-1 6 0 3]);
            pause(.000001)
            F(cou) = getframe(gcf);
            cou=cou+1; 
            
    end
    
    deltax=xd.signals.values(end)+deltax-(xd.signals.values(end)-(cos(alpha/180*pi)-xpp));
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%
figure
time=linspace(.01,length(GRF)*.01,length(GRF));
plot(time,GRF,'b')
title('GRF')
xlabel 'TIME'
ylabel 'GRF'

%%%%%%%%%%%%%%%%%%%%%%%%%
figure
time=linspace(.01,length(GRFX)*.01,length(GRFX));
plot(time,GRFX,'b')
hold on
plot(time,GRFY,'r')
title('GRFX and GRFY')
xlabel 'TIME'
ylabel 'GRF'

%%%%%%%%%%%%%%%%%%%%%%%%%
figure
time=linspace(0,length(height)*.01,length(height));
plot(time,height,'b')
title('HEIGHT')
xlabel 'TIME'
ylabel 'Y'


movie(figure,F,1,30)
