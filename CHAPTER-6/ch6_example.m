% ch6_example

clear all
close all
clc

%% WITHOUT YIELD

% ----- GENERAL PARAMETERS ----- %
PLANE_ANGLE = 45; % [deg] angle of the plane of maximum average shear stress
CYL_RADIUS = 0.05; % [m]
  % solve for
  area_N = pi*CYL_RADIUS^2; % [m^2] area of the mutually orthogonal cross-section
  area_T = area_N/cosd(PLANE_ANGLE); % [m^2] area of the shear cross-section
INITIAL_LOAD = 0; % [kN]
FINAL_LOAD = 5000; % [kN]
NUM_LOADS = 100;

% ----- INITIALIZE VECTORS ----- %
F = linspace(INITIAL_LOAD, FINAL_LOAD, NUM_LOADS); % [kN]
sigma = zeros(1, NUM_LOADS); % to store normal stress values
tau = zeros(1, NUM_LOADS); % to store shear stress values

% ----- LOOP OVER LOADS ----- %
for i = 1 : NUM_LOADS
  load = F(i); % [kN]
  sigma(i) = load / area_N; % [kPa]
  tau(i) = load*sind(PLANE_ANGLE) / area_T; % [kPa]
end

figure(1)
plot(F, sigma, 'b--')
hold on
plot(F, tau, 'r--')
hold off
xlabel('Force [kN]')
ylabel('Stress [kPa]')
title('Stress vs. Force in an Axially Loaded Member')
legend('Normal Stress', 'Shear Stress', 'Location', 'southeast')

%% WITH YIELD

clear all

% ----- GENERAL PARAMETERS ----- %
PLANE_ANGLE = 45; % [deg] angle of the plane of maximum average shear stress
CYL_RADIUS = 0.05; % [m]
  % solve for
  area_N = pi*CYL_RADIUS^2; % [m^2] area of the mutually orthogonal cross-section
  area_T = area_N/cosd(PLANE_ANGLE); % [m^2] area of the shear cross-section
INITIAL_LOAD = 0; % [kN]
FINAL_LOAD = 5000; % [kN]
NUM_LOADS = 100;
SIGMA_Y = 415 * 10^(3); % [kPa]
TAU_Y = SIGMA_Y / 2; % [kPa]

% ----- INITIALIZE VECTORS ----- %
F = linspace(INITIAL_LOAD, FINAL_LOAD, NUM_LOADS); % [kN]
sigma = zeros(1, NUM_LOADS); % to store normal stress values
tau = zeros(1, NUM_LOADS); % to store shear stress values

% ----- LOOP OVER LOADS ----- %
for i = 1 : NUM_LOADS
  load = F(i); % [kN]
  sigma(i) = load / area_N; % [kPa]
  tau(i) = load*sind(PLANE_ANGLE) / area_T; % [kPa]

  % ----- CHECK YIELD CRITERIA ----- %
  if sigma(i) > SIGMA_Y
    % the member has yielded via normal stress
    sigma(i) = SIGMA_Y;
  end

  if tau(i) > TAU_Y
    % the member has yielded via shear stress
    tau(i) = TAU_Y;
  end
end

figure(2)
plot(F, sigma, 'b--')
hold on
plot(F, tau, 'r--')
plot(F, SIGMA_Y*ones(1,NUM_LOADS), 'k--')
plot(F, TAU_Y*ones(1,NUM_LOADS), 'k--')
hold off
xlabel('Force [kN]')
ylabel('Stress [kPa]')
title('Stress vs. Force in an Axially Loaded Member (with yield)')
legend('Normal Stress', 'Shear Stress', 'Location', 'southeast')

%% WHILE LOOPING

clear all

% ----- GENERAL PARAMETERS ----- %
PLANE_ANGLE = 45; % [deg] angle of the plane of maximum average shear stress
CYL_RADIUS = 0.05; % [m]
  % solve for
  area_N = pi*CYL_RADIUS^2; % [m^2] area of the mutually orthogonal cross-section
  area_T = area_N/cosd(PLANE_ANGLE); % [m^2] area of the shear cross-section
INITIAL_LOAD = 0; % [kN]
LOAD_STEP = 1; % [kN]
SIGMA_Y = 415 * 10^(3); % [kPa]
TAU_Y = SIGMA_Y / 2; % [kPa]

% ----- LOOP OVER LOADS ----- %
normal_stress = 0; % initialize a value to enter the loop
shear_stress = 0; % initialize a value to enter the loop
load(1) = INITIAL_LOAD; % initialize
i = 1; % iterator
while (normal_stress <= SIGMA_Y) && (shear_stress < TAU_Y)
  previous_load = load(i); % [kN]
  normal_stress = load(i) / area_N; sigma(i) = normal_stress; % [kPa]
  shear_stress = load(i)*sind(PLANE_ANGLE) / area_T; tau(i) = shear_stress; % [kPa]
  load(i+1) = previous_load + LOAD_STEP; % [kN]
  i = i + 1;
end

% clear the last entry in load because it wasn't valid
load(end) = [];

figure(3)
plot(load, sigma, 'b--')
hold on
plot(load, tau, 'r--')
plot(load, SIGMA_Y*ones(1,length(load)), 'k--')
plot(load, TAU_Y*ones(1,length(load)), 'k--')
hold off
xlabel('Force [kN]')
xlim([0,load(end)])
ylabel('Stress [kPa]')
title('Stress vs. Force in an Axially Loaded Member (while loop)')
legend('Normal Stress', 'Shear Stress', 'Location', 'southeast')

%% Anonymous Functions

clear all

sigma_func = @(F, A, theta) F*cos(theta) ./ (A./cos(theta));
tau_func = @(F, A, theta) F*sin(theta) ./ (A./cos(theta));

F = 10; % [N]
A = 5; % [m^2]
theta = linspace(0,pi);
plot(theta, sigma_func(F,A,theta), '-b')
hold on
plot(theta, tau_func(F,A,theta), '-r')
hold off
xlim([0, pi])
xlabel('$\theta$','Interpreter','latex')
ylabel('Stress [MPa]')
legend('Normal Stress', 'Shear Stress')
title('Stress vs. $\theta$', 'Interpreter', 'latex')