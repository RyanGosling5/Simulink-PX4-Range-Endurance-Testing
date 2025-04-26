%

%   Copyright 2020-2022 The MathWorks, Inc.

%Based on the quadcopter model used in jMAVSim

Ixx = 0.0291; %Kgm^2
Iyy = 0.0241;
Izz = 0.0473;


inertia = diag([Ixx, Iyy, Izz]);

mass = 3.3 ; %Kg
g = 9.81; %m/s^2

armLength = 0.33/2; % length of Arm measured from center in m

rotorThrustMax = 12; %N

rotorTorqueMax = 0.16 ;%Nm

rotorTimeConst = 0.005 ;% time constant of rotor (motor + propeller)

%rotorOffset = [0 0 0]; % Rotors position offsets from Gravity center

dragCoeffMov = 0.3; %drag coefficient for linear motion of quadcopter
windVel = [1 0 0]';

% Initial states
init.posNED = [0, 0, 0]; % m
init.vb = [0 0 0]'; %m/s
init.euler = [0, 0, 0]'; %Roll Pitch Yaw Rads
init.angRates = [0, 0, 0]; %rad/s 


%position motors of the UAV
motorposx=0.225; %actual distances of the motors relative to cg
motorposy=0.169;
motorposz=0.1;
rotorPositions = zeros(3,4);
axisD = armLength/sqrt(2);
rotorPositions(:,1) = [motorposx, motorposy, motorposz]';
rotorPositions(:,2) = [-motorposx, -motorposy, motorposz]';
rotorPositions(:,3) = [+motorposx, -motorposy, motorposz]';
rotorPositions(:,4) = [-motorposx, motorposy, 0]';
rotorDir = [-1, -1, 1, 1]; %rotation direction. +ve = clockwise

% Sample Time
SampleTime = 0.008;

%Gain to convert m to mm
m_to_mm = 1000;

%Gain to convert m/s^2 to mG
ms2_to_mg = (1/9.80665)*1000;

%Gain to convert m/s to cm/s
ms_to_cms = 100;

%Reference height for 'Flat Earth to LLA'
ref_height = -71.3232;

altToPrsGain = 12.0173;
altToPrsBias = 101270.95;

% Contact model
contact.translation.spring = 3100;
contact.translation.damper = 100;
contact.translation.friction = 0.5;
contact.translation.vd = 0.02;
contact.translation.maxFriction = 20;
contact.translation.maxNormal = 80;

contact.rotation.spring = 2;
contact.rotation.damper = 1;
contact.rotation.friction = 0.03;
control.rotation.maxMoment = 0.1;
control.rotation.friction = 0.025;
control.rotation.vd = 0.2;

battCapacity=9282; %battery capacity in Wmin
correction=0.001*304.8/470;
c=correction.*table2array(readtable("propgeometry.xlsx", "Range", "E4:E25"));
b=correction.*table2array(readtable("propgeometry.xlsx", "Range", "C4:C25"));


