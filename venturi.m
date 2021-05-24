%Just adding a comment to see that git works the way I think
%I THINK IT WORKS!!

% this is the first (very wrong one) that we did
% u = [0, 10, 20, 30, 40, 50, 60];
% volt = [-108e-3, -.107e-3, -51e-3, 0.01, 0.32, 0.52, 0.81] ;%mV
clear 
close all 


%calibration
% Voltage from pitot tube at atm pressure, not sure why I called it U...
atmU = mean([-110.3, -109.9, -110.409, -110.362, -110.895, -110.484])*1e-3;
c2 = 98.8;
c1 = -c2*atmU;

% constants
rho = 1.2754;
A1 = pi*(.1/2)^2;
A2 = pi*(.05/2)^2;


% Task 1
%-------------------------------------------------------------
%-------------------------------------------------------------

u_fan = [20, 25, 30, 35, 40, 45, 50, 55, 60, 65]; %Unitless, speed of fan
pitot = [-82.6e-3, 13e-3, 65e-3, .216, .27, .45, .58, .69, .85, 1.01]; %Volts
Pdiff = [40, -590+715, 760-540, 820-490, 870-430, 950-355, 1020-280,1100-185, 1210-95, 1325+25]; %Pascal ?

Pdiff_pitot = c1+c2*pitot;

%Calc w1 and u for task 1
w1 = sqrt(2*Pdiff/rho)*A2/sqrt(A1^2-A2^2);
u = sqrt(2*Pdiff_pitot/rho);

% close all 
figure
plot(u,w1)
hold on 
grid on 
xlabel('u [m/s]')
ylabel('W1??')




%% Task 2
%-------------------------------------------------------------
%-------------------------------------------------------------
close all
dist = [15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]*1e-3; %Distance from top of tube in m
volt2 = [.33, .35, .41, .45, .48, .48, .52, .53, .54, .52, .53, .51, .47, .48, .45, .41, .35, .27]; %Volt from pitot tube


Pdiff_pitot = c1+c2*volt2;
u = sqrt(2*Pdiff_pitot/rho);

% figure
% plot(dist,u,'*')
% hold on
% grid on 
% xlabel('Distance from top [m]')
% ylabel('Speed of air [m/s]')

% extra measurement in the middle of the tube to see if it was really asymmetric
dist_middle = 50e-3;
volt_middle = mean([56.7, 62.1,53.0,51.8,43.5, 49.7])*1e-2;
% plot(dist_middle,volt_middle,'r*')
% uniform flow
% plot(dist,ones(1,length(dist))*max(u))
% plot laminar flow here as well (otto or johannes has theoretiucal solution?)
r = linspace(-dist_middle,dist_middle,100);
dist2 = linspace(0,0.1,100);




% Ur = @(k) 1*max(u)*(1-((r-.0075)/(0.5*max(dist))).^2).^(1/k);
% 
% figure;
% for i = 4:10
%     plot(Ur(i),dist2);
%     hold on
% end
% plot(u,dist,'*')
% plot(ones(1,length(dist2))*max(u),dist2)
% grid on 
% xlabel('u [m/s]')
% ylabel('Distance from top [m]')
% xlim([0,11])
% ylim([.01,.1])
% 

r2 = linspace(0,dist_middle,100);
Ur2 = @(k) max(u)*(1-((r2)/(0.5*max(dist)))).^(1/k);

figure(99);
for i = 6:15
    plot(Ur2(i),r2);%+0.005);
    hold on
end
plot(u(1:18),dist-dist_middle,'*')
% plot(ones(1,length(dist2))*max(u),dist2)%-.05)
grid on 
xlabel('u [m/s]')
ylabel('Distance from top [m]')

% figure 
for i = 6:10
    plot(Ur2(i),-r2);%+0.005);
    hold on
end
% set(gca, 'YDir','reverse')


r3 = linspace(-dist_middle,dist_middle,100);
Ur3 = @(k) max(u)*(1-((r3)/(0.5*max(dist))).^2).^(1/k);
% With laminar comparison
figure
plot(Ur3(1),dist2)
hold on 
grid on 
plot(u,dist,'*')
plot(ones(1,length(dist2))*max(u),dist2)%-.05)
grid on 
xlabel('u [m/s]')
ylabel('Distance from top [m]')
legend('Laminar', 'Experimental', 'Uniform','Location','west')

%% 
U_max = max(u);
Ur3 =@(n) U_max*2*n.^2/(2*n^2+3*n+1);

figure();
for i = 6:10
    plot(Ur3(i),dist2);
    hold on
end



%% Task 3 , redo task 1 with pitot tube in the back
%-------------------------------------------------------------
%-------------------------------------------------------------
u_fan2 = [20, 25, 30, 35, 40, 45, 50, 55, 60, 65]; %Unitless, speed of fan
Pdiff2 = [675-625, 710-590, 740-553, 705-497, 860-440, 915-380, 1025-270, 1115-180, 1205-87, 1345+50]; %Pascal ? 
pitot2 = [-.075, -.022, -.025, .12, .19, .28, .43, .53, .68, .86]; % Volt



Pdiff_pitot2 = c1+c2*pitot2;

%same calculations as task 1 (literally copy-pasted)
w1_2 = sqrt(2*Pdiff2/rho)*A2/sqrt(A1^2-A2^2);
u2 = sqrt(2*Pdiff_pitot2/rho);



% close all 
figure
plot(u2,w1_2)
hold on 
grid on 
xlabel('u [m/s]')
ylabel('W1??')