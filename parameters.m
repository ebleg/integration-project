%% System parameters

% % Test case
% par.d1 = 0.1;
% par.d2 = 0.1;
% 
% par.l1 = 0.2;
% par.l2 = 0.2;
% 
% par.I1 = 0.01;
% par.I2 = 0.01;
% par.Iball = 0;
% 
% par.m1 = 0.1;
% par.m2 = 0.08;
% par.mball = 0.05;
% par.g = 9.80665;
% 
% par.Kr = 1;
% par.R = 1;
% par.L = 1e-5;

%% Parameters needed to determine system parameters

rho = 2700;        %[kg/m3] for aluminium
d = 0.5e-2;        %[m] Thickness beams

l1_1 = 2.7e-2;     %[m] Length upper section Link 1
l1_2 = 6.5e-2;     %[m] Length lower section Link 1
l1_width = 1.5e-2; %[m] Width Link 1
l1_or = 2.3e-2/2;  %[m] Outer radius upper hollow disk
l1_ir = 1.3e-2/2;  %[m] Inner radius upper hollow disk
m1_motor = 33e-3 + pi*(l1_1/2)^2*d*rho; %[kg] Mass motor and lower disk part of beam
m1_beam = rho*(l1_2*l1_width*d + l1_1*l1_width*d + pi*(l1_or^2-l1_ir^2)*d); %[kg] Mass upper beam

r_2 = 0.15e-2;      %[m] Radius link 2
r_ball = 0.7285e-2; %[m] Radius ball
% l2_uppercilradius = 1.648/2; %[cm] Radius cilinder at connection links
% l2_uppercild = 0.75; %[cm] Thickness cilinder at connection links

%% System Paramters
l1 = 10e-2; %[m]
l2 = 10e-2; %[m]

m1 = (m1_beam + m1_motor); % [kg]
m2 = pi*r_2^2*l2*rho; %[kg] Thin rod, perpendicular to the axis of rotation, rotating about one end.
mball = 4/3*pi*r_ball^3*rho*0.9; %[gr]Point mass distance r from the axis of rotation

d1 = (m1_motor*l1 + m1_beam*0.75e-2)/(m1_motor+m1_beam); %COM link 1 (0.75 is the COM of the beam part of link 1)
d2 = l2/2; %COM link 2 

I1 = m1_motor*l1^2 + 1/12*m1_beam*11.5e-2^2; % Motor as point mass, rod rotating around its center  
I2 = 1/12*m2*l2^2;
Iball = 2/5*mball*0.9*r_ball^2;

R = 0.01; 
L = 0.0001;
Kr = 0.5;

% Scaled voltage to real voltage
A = 5;

%% Clean workspace
clearvars rho dl l1_1 l1_2 l1_width l1_or l1_ir m1_motor m1_beam r_2 r_ball 