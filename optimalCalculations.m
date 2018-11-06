%clc; clear all;

%Hand Measurements
clc; clear all;

%Define known constants
nu      = 1.562 * 10^-5;  %Kinematic viscosity of air at 25 [m²/s]
rho     = 1.184;          %Density of air at 25C [kg/m³]
h       = [129.51;116.8;102.35;90.4;78.45;63.52;54.62;39.85;26.66;14.29]; h=h/1000; %m;
c       = 20/100; %m chord length
w       = 60/100; %m chord length
A       = 0.00299795; %m^2 cross sectional Area

%path to data
files  = string(5:2:35) + '.xlsx';
nFiles = length(files);

%Location of data from wind tunnel
path = 'E:\ThermoFluids\Lab_7\max height\';


%Import the data
    timeRaw = cell(nFiles, 1);
    uRaw    = cell(nFiles, 1);
    FlRaw   = cell(nFiles, 1);
    FdRaw   = cell(nFiles, 1);
    
    
    u       = zeros(nFiles, 1);
    Fl      = zeros(nFiles, 1);
    Fd      = zeros(nFiles, 1);
    Re      = zeros(nFiles, 1);
    Cl      = zeros(nFiles, 1);
    Cd      = zeros(nFiles, 1);
    
for i=1 :  1 %For max h/c location
    %Get aveage values for each column
    for j=1 : nFiles %5, 7, 9, 11, ..., 35 m/s
        fileName    = path+string(files(j));
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

%Plot Cl versus Reynolds Number
figure(1);
%Plot left axis
plot(Re(:,1), Cl(:,1));
hold on
xlabel("Reynolds Number");
ylabel("Cl");
set(gca, 'Ydir', 'reverse');
set(gcf,'color','w');
saveas(gcf,'OptimalHeight.fig')
hold off

%Plot Cd versus Reynolds Number
figure(2);
%Plot left axis
plot(Re(:,1), Cd(:,1));
hold on
xlabel("Reynolds Number");
ylabel("Cd");
set(gcf,'color','w');
saveas(gcf,'OptimalHeight.fig')
hold off

