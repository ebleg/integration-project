clear; close all;

run parameters
filename = 'system_dynamics';

h = 0.003;  % Data sampling rate

%% Prepare input data
load 'H:\Integration project\Data\Identification\step_0.8.mat'

theta1_filter = remove_switching(theta1.Data);
theta1_filter = smoothdata(theta1_filter, 'sgolay', round(0.12/h));
theta2_filter = remove_switching(theta2.Data);
theta2_filter = smoothdata(theta2_filter, 'sgolay', round(0.12/h));

%% Construct identification object
% Without link and ball inertia

%% Set up the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 6);

% Specify sheet and range
opts.Sheet = "Sheet1";
opts.DataRange = "A2:F15";

% Specify column names and types
opts.VariableNames = ["Name", "Value", "Minimum", "Maximum", "Unit", "Fixed"];
opts.VariableTypes = ["char", "double", "double", "double", "char", "double"];

% Specify variable properties
opts = setvaropts(opts, ["Name", "Unit"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Name", "Unit"], "EmptyFieldRule", "auto");

% Import the data
par = readtable("parameters.xlsx", opts, "UseExcel", false);
% par.Value = [d1, d2, l1, l2, I1, I2, Iball, m1, m2, mball, R, L, Kr, A];
par.Value = [d1, d2, l1, l2, 0, 0, 0, m1, m2, mball, R, L, Kr, A]';

% Clear temporary variables
clear opts

idobj = idnlgrey(filename, [2 1 5], ...
                 table2struct(par), ...
                 [0 0 0 0 0]',0,'Name', 'Rotating pendulum');

% Generate the input
u = repmat(0.8, numel(theta1.Time), 1);
u(theta1.Time < 4) = 0;

%% Output data
z = iddata([theta1_filter theta2_filter], u, h, 'Name', 'High-amplitude sine wave');
z.InputName = 'Scaled voltage';
z.InputUnit = '-';
z.OutputName = {'Theta 1', 'Theta 2'};
z.OutputUnit = {'rad', 'rad'};
z.Tstart = 0;
z.TimeUnit = 's';

%% Parameter identification
% opt = nlgreyestOptions('Display', 'on');
% 
% sys = nlgreyest(z, idobj, opt);