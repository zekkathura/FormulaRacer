clc; clear all;

%Hand Measurements


%Define known constants
nu      = 1.562 * 10^-5;  %Kinematic viscosity of air at 25 [m²/s]
rho     = 1.184;          %Density of air at 25C [kg/m³]
h       = [129.51;116.8;102.35;90.4;78.45;63.52;54.62;39.85;26.66;14.29]; h=h/1000; %m;
c       = 20/100; %m chord length
w       = 60/100; %m chord length
A       = 0.00299795; %m^2 cross sectional Area

%path to data
speedsRan   = [30, 35]; %m/s
files    = string(1:1:10) + '.xlsx';
nFiles   = length(files);

%Location of data from wind tunnel
if ispc 
    path = 'E:\ThermoFluids\Lab_7\';
elseif ismac
    path = '';
end

%Import the data
for i=1 : length(speedsRan) %30, 35
    %Get aveage values for each column
    timeRaw = cell(nFiles, 1);
    uRaw    = cell(nFiles, 1);
    FlRaw   = cell(nFiles, 1);
    FdRaw   = cell(nFiles, 1);
    
    u       = zeros(nFiles, 1);
    Fl      = zeros(nFiles, 1);
    Fd      = zeros(nFiles, 1);
    for j=1 : nFiles %Run1, Run2, Run3, Run4, etc
        fileName    = path+string(speedsRan(i))+'\Run'+j;
        [data, ~]   = xlsread(fileName);
        
        timeRaw{j}  = data(:,1);
        uRaw{j}     = data(:,2);
        FlRaw{j}    = data(:,3);
        FdRaw{j}    = data(:,4);

        u(j)  = mean(double(uRaw{j}));
        Fl(j) = mean(double(FlRaw{j}));
        Fd(j) = mean(double(FdRaw{j}));
    end%for
end%for

%Calculate Re, Cl, Cd from average vectors
Re = u.*c/nu;
Cl = (Fl)./(rho.*u.^2.*A);
Cd = (Fd)./(rho.*u.^2.*A);