clc
clear 
warning off
close all

time=4;
t=.2;
p=.4;
t1=-.1988;
p1=.0;
s=.009;


% t=.22;
% p=.44;
% t1=-0.228481227182522;
% p1= -0.021752932040919;
% s=.013277;


% % long period
% time= 3.882161753531508;
% t=0.199529453849518;
% t1=-0.198982728751878;
% p=2*t;
% p1=-0.015115019410682;
% s=.009;


%%Short period
% time=4;
% alph=-1.090331;
% c1=.866610;
% s=.01328;
% t=.943976*s^(1/3)-.264561*s;
% t1=alph*.943976*s^(1/3)+(alph*(-.264561)+c1)*s;
% p=2*t;
% p1=t1*(1-cos(2*t));


ax = gca;
ax.NextPlot = 'replaceChildren';
F(1000) = struct('cdata',[],'colormap',[]);
cou=1;

x=1;
L=1;

thetap=0;
phip=0;

for z=1:10
    
    sim('invertedPend')
    
    theta=theta.signals.values;
    phi=phi.signals.values;
    thetadot=thetadot.signals.values;
    phidot=phidot.signals.values;
        
    t=-theta(end);
    p=-phi(end);
    t1=cos(phi(end))*thetadot(end);
    p1=(1-cos(phi(end)))*cos(phi(end))*thetadot(end);
    
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
        axis([0 5 -.01 3]);
        pause(.000001)
        F(cou) = getframe(gcf);
        cou=cou+1; 

    end
    
    x=xt2;

    
end

time=linspace(.03,length(thetap)*.03,length(thetap));
figure
plot(time,thetap,'r.')
hold on
plot(time,phip,'b.')
title 'Theta and Phi'
xlabel 'time'
ylabel 'radian'
legend('Theta','Phi')

movie(figure,F,1,100)

