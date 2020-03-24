clc
clear 
close all
warning off


%%initial Condition
flighty=1.15;
flights=0;

height=flighty;
speed=flights;

ts_max = 1e-1;



%%%Parameters%%%
m=80;
Ls=.5;
d=.04;
lref=.5;
phiref=110/180*pi;
Fmax=22000;
w=.4;
Vmax=12;
N=1.5;
K=5;
lrest=.4;
dp=.015;
eref=.04;
c=0.05;
lopt=.1;


%%%% pre Activation
preA=.01;


%%% Stim parameters

%1
stm0=.05;
G=1.07/Fmax;

% %2
% stm0=.05;
% G=1.2/Fmax;

% %3
% stm0=.05;
% G=2/Fmax;
 
% % 4
% stm0=.065;
% G=1.32/Fmax;

% %5
% stm0=.145;
% G=1.84/Fmax;



for z=1:24
    
    sim 'flight2'
    yF=yF.signals.values;
    yFspeed=yFspeed.signals.values;
   
    stancey=yF(end);
    stances=yFspeed(end);
    
    %%%%%%%%
    
    sim 'stance2'
    
    yS=yS.signals.values;
    ySspeed=ySspeed.signals.values;   
    
    flighty=yS(end);
    flights=ySspeed(end);
    
    
    %%%%%%%
    
    height=[height,yF',yS'];

  
end


%%%%%%%%%% COM %%%%%%%%%%
t=linspace(0,length(height)*.001,length(height));
plot(t,.95*ones(1,length(height)),'r-')
hold on
plot(t,height,'b-')
title 'COM height'
xlabel 't'
ylabel 'y'


%%%%%%%%%% Fleg %%%%%%%%%%
figure
t=linspace(0,length(Fleg.signals.values)*.001,length(Fleg.signals.values));
plot(t,Fleg.signals.values,'g.')
title 'Fleg'
xlabel 't'
ylabel 'F(N)'


%%%%%%%%%% Stim %%%%%%%%%%
figure
t=linspace(0,length(Fleg.signals.values)*.001,length(Fleg.signals.values));
plot(t,Stim.signals.values,'r.')
title 'Stim'
xlabel 't'
ylabel 'ACT'

%%%%%%%%%% force–length %%%%%%%%%%
figure
plot(.95-yS',Fleg.signals.values,'b.')
title 'Force-Lenght'
xlabel 'delta L'
ylabel 'F(N)'

