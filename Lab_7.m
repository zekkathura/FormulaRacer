%clc; clear all;

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
    subDir = '\Run';
elseif ismac
    path = 'Data/';
    subDir = '/Run';
end

%Import the data
    timeRaw = cell(nFiles, 2);
    uRaw    = cell(nFiles, 2);
    FlRaw   = cell(nFiles, 2);
    FdRaw   = cell(nFiles, 2);
    
    
    u       = zeros(nFiles, 2);
    Fl      = zeros(nFiles, 2);
    Fd      = zeros(nFiles, 2);
    Re      = zeros(nFiles, 2);
    Cl      = zeros(nFiles, 2);
    Cd      = zeros(nFiles, 2);
    
for i=1 :  2 %length(speedsRan) %30, 35
    %Get aveage values for each column
    for j=1 : nFiles %Run1, Run2, Run3, Run4, etc
        fileName    = path+string(speedsRan(i))+subDir+j;
        [data, ~]   = xlsread(fileName);
        
        timeRaw{j,i}  = data(:,1);
        uRaw{j,i}     = data(:,2);
        FlRaw{j,i}    = data(:,3);
        FdRaw{j,i}    = data(:,4);
        u (j,i) = mean(double(uRaw{j,i}));
        Fl(j,i) = mean(double(FlRaw{j,i}));
        Fd(j,i) = mean(double(FdRaw{j,i}));
    end%for
    %Calculate Re, Cl, Cd from average vectors
    Re(:,i) = u(:,i).*c/nu;
    Cl(:,i) = 2*(Fl(:,i))./(rho.*u(:,i).^2.*c*w);
    Cd(:,i) = 2*(Fd(:,i))./(rho.*u(:,i).^2.*c*w);
end%for


% Re = u.*c/nu;
% Cl = (Fl)./(rho.*u.^2.*A);
% Cd = (Fd)./(rho.*u.^2.*A);

%Plot Cl over h/c
hOverC = h/c;
figure(1);
%Plot left axis
%yyaxis left
plot(hOverC, Cl(:,1) / Cd(:,1));
hold on
plot(hOverC, Cl(:,2) / Cd(:,2));
%set(gca, 'Ydir', 'reverse');
xlabel("h/c");
ylabel("Cl/Cd");
set(gca, 'Ydir', 'reverse');
legend({'30 m/s' , '35 m/s'}, 'Location', 'southeast');
hold off

figure(2);
plot(hOverC, Cl(:,1));
hold on
plot(hOverC, Cl(:,2));
set(gca, 'Ydir', 'reverse');
xlabel("h/c");
ylabel("Cl");
legend({'30 m/s' , '35 m/s'}, 'Location', 'southeast');

