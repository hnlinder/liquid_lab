%calibration 
% starts at file 33
clear all
close all
h = [45, 39.8, 35, 30, 25, 20, 15, 10]*1e-2;
volt(1) = mean([2.007,2.006,2.011, 2.0025,2.004]);
volt(2) = mean([1.8089, 1.8221, 1.8114, 1.8078, 1.819,1.8175,1.81499,1.809]);
volt(3) = mean([1.612,1.628,1.619,1.618,1.625]);
volt(4) = mean([1.428,1.4337,1.417,1.414,1.4256]);
volt(5) = mean([1.226,1.233,1.227,1.226,1.224]);
volt(6) = mean([1.023,1.019,1.030,1.030,1.026,1.025]);
volt(7) = mean([.816,.826,.833,.824,.824,.827]);
volt(8) = mean([.5958,.6019,.6034,.6095,.6085]);


%%
%convert voltage to height 
P = polyfit(volt,h, 1);
y = polyval(P,volt);
close all
plot(volt,y)
hold on
plot(volt,h,'r*')

%% smallest diameter tube 
% find mu from data
run import_script.m

t = labdata(:,1);
volt = labdata(:,2);
height = P(1)*volt+P(2);
h0 = height(1);
figure
plot(t,log(height/h0))
hold on 
grid on 

% h0 = 
rho = 999.75; %kg/m^3 at temp 9.something degrees C
g = 9.82;
l = 28.95e-2; %length of pipe
r = .14e-2/2;
D = 6.4e-2;
A = pi*(D/2)^2 ;
space = [400:1450];
P1 = polyfit(t(space),log(height(space)/h0),1);
k = -P1(1);
mu1 = pi*r^4*rho*g/(8*A*k*l)
plot(t(space(1)), log(height(space(1))/h0), 'r*')
plot(t(space(end)), log(height(space(end))/h0),'r*')

% plot(t(1650), log(height(1650)/h0), 'r*')
% plot(t(end), log(height(end)/h0),'r*')




figure
plot(t,height)
hold on 
grid on 
h_mean = mean(height(space));
dhdt = (height(space(1)) - height(space(end)))/(t(space(1)) - t(space(end))); %DY/DT

plot(t(400), height(400), 'r*')
plot(t(1450), height(1450),'r*')

u = -dhdt*A/(pi*r^2);
Re = u*rho*(2*r)/mu1
%% second measurement, 
% find mu from data
run import_script2.m

t = labdata2(:,1);
volt = labdata2(:,2);
height = P(1)*volt+P(2);
h0 = P(1)*volt(1)+P(2);
figure
plot(t,log(height/h0))
hold on 
grid on 
% h0 = 
r = .5*.28e-2;
l = 32.25e-2;
D = 6.46e-2;
A = pi*(D/2)^2 ;
P2 = polyfit(t,log(height/h0),1);
k = -P2(1);
mu2 = pi*r^4*rho*g/(8*A*k*l)


space_lam = [250:length(t)];
dhdt = (height(space_lam(1)) - height(space_lam(end)))/(t(space_lam(1)) - t(space_lam(end))); %DY/DT
plot(t(space_lam(1)), log(height(space_lam(1))/h0), 'r*')
plot(t(space_lam(end)), log(height(space_lam(end))/h0),'r*')
u = -dhdt*A/(pi*r^2);
Re_lam = u*rho*(2*r)/mu1

space_trans = [100:250];
dhdt = (height(space_trans(1)) - height(space_trans(end)))/(t(space_trans(1)) - t(space_trans(end))); %DY/DT
plot(t(space_trans(1)), log(height(space_trans(1))/h0), 'r*')
plot(t(space_trans(end)), log(height(space_trans(end))/h0),'r*')
u = -dhdt*A/(pi*r^2);
Re_trans = u*rho*(2*r)/mu1

space_turb = [1:100];
dhdt = (height(space_turb(1)) - height(space_turb(end)))/(t(space_turb(1)) - t(space_turb(end))); %DY/DT
plot(t(space_turb(1)), log(height(space_turb(1))/h0), 'r*')
plot(t(space_turb(end)), log(height(space_turb(end))/h0),'r*')
u = -dhdt*A/(pi*r^2);
Re_turb = u*rho*(2*r)/mu1


figure 
plot(t,height)
hold on 
grid on 
plot(t(space_lam(1)), height(space_lam(1)), 'r*')
plot(t(space_lam(end)), height(space_lam(end)),'r*')
plot(t(space_trans(1)), height(space_trans(1)), 'r*')
plot(t(space_trans(end)), height(space_trans(end)),'r*')
plot(t(space_turb(1)), height(space_turb(1)), 'r*')
plot(t(space_turb(end)), height(space_turb(end)),'r*')

