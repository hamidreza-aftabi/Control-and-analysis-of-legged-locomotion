clc
clear 
warning off
close all


t=.2;
p=.4;
t1=-.2155;
p1=-.043;

ax = gca;
ax.NextPlot = 'replaceChildren';
F(1000) = struct('cdata',[],'colormap',[]);
cou=1;

x=1;
L=1;
pu=.0445;

thetap=0;
phip=0;
energy=0;
Energy=0;

stepsize=10;

for z=1:stepsize
    
    sim('impu')
    
    theta=theta.signals.values;
    phi=phi.signals.values;
    thetadot=thetadot.signals.values;
    phidot=phidot.signals.values;
        
    t=-theta(end);
    p=-phi(end);
    t1=cos(phi(end))*thetadot(end)+pu(1)*sin(phi(end));
    p1=(1-cos(phi(end)))*cos(phi(end))*thetadot(end)+pu(1)*(1-cos(phi(end)))*sin(phi(end));
    
    energy=energy+1/2*pu^2;
    
    Energy=[Energy,energy];
    
    
    thetap=[thetap,theta'];
    phip=[phip,phi'];
    
    for i=1:length(theta)
    
        dx=L*sin(theta(i));
        xt=x-dx;
        yt=sqrt(L^2-dx^2);
        dx1=L*sin(phi(i)-theta(i));
        xt2=x-dx1-dx;
        yt2=yt-sqrt(L^2-dx1^2);
 
        clf
        plot([x,xt],[0,yt],'Linewidth',2.3,'color','b')
        hold on
        plot([xt2,xt],[yt2,yt],'Linewidth',2.3,'color','b')
        hold on
        plot(xt2,yt2,'or','MarkerSize',7,'MarkerFaceColor','r')
        hold on 
        plot(xt,yt,'or','MarkerSize',17,'MarkerFaceColor','r')
        hold on
        plot(x,0,'or','MarkerSize',7,'MarkerFaceColor','r')    
        axis([0 5 -.02 3]);
        pause(.000001)
        F(cou) = getframe(gcf);
        cou=cou+1; 

    end
    
    x=xt2;

    
end

time=linspace(.02,length(thetap)*.02,length(thetap));
figure
plot(time,thetap,'r.')
hold on
plot(time,phip,'b.')
title 'Theta and Phi'
xlabel 'time'
ylabel 'radian'
legend('Theta','Phi')

step=linspace(1,stepsize,stepsize);
figure
plot(step,Energy(2:end),'b*')
title 'Energy'
ylabel 'J'
xlabel 'step'


 movie(figure,F,1,100)

