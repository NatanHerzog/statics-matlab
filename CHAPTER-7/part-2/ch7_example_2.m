% This script will make use of the `BRIDGE_MODEL()` function defined in this folder to solve and optimize a bridge

clear all
close all
clc

simulation_start = tic;

% --------------------------------------------------------------------------- %

% <><><>< GENERAL PARAMETERS ><><><> %

% List out all global variables from the problem

LENGTH = 12;                                  % length of the bridge                    [m]
HEIGHT = @(t) tand(t) * LENGTH/2;             % height of the bridge                    [m]
AREA_TRUSS = 100 * (10^(-2))^2;               % cross-sectional area                    [m^2]
INITIAL_LOAD = 1000;                          % initial load for the first iteration    [N]
THETA_START = 15;                             % beginning of the theta array            [deg]
THETA_END = 75;                               % end of the theta array                  [deg]
THETA = linspace(THETA_START, THETA_END, THETA_END - THETA_START + 1);

TENSILE_YIELD = 19.9 * 10^6;                  % define the tensile yield strength       [Pa]
COMPRESSIVE_YIELD = 12.1 * 10^6;              % define the compressive yield strength   [Pa]
SHEAR_YIELD = 5 * 10^6;                       % define the shear yield strength         [Pa]
DENSITY = 150;                                % define the density                      [kg/m^3]

BALSA_CpI = 0.0407;                           % Balsa wood cost                         [$/m]
WASHER_CpU = 0.0411;                          % Washer cost                             [$/unit]
NUT_CpU = 0.0457;                             % Nut cost                                [$/unit]
BOLT_CpU = 0.1564;                            % 1.5" Bolt cost                          [$/unit]

NODE_COUNT = 6;                               % Number of nodes

% <><><>< BRIDGE BROKEN BOOLEANS ><><><> %

% Initialize these as `false`
% They will be toggled to `true` if a corresponding stress exceeds its limit

TENSILE_FAILURE = false;                      % signal a tensile stress failure
COMPRESSIVE_FAILURE = false;                  % signal a compressive stress failure
BEARING_FAILURE = false;                      % signal a bearing stress failure
SHEAR_FAILURE = false;                        % signal a shear stress failure

% --------------------------------------------------------------------------- %

% <><><>< SOLVE THE BRIDGE ><><><> %

PI = zeros(length(THETA), 1);
max_load = zeros(length(THETA), 1);
failure_condition = false(4, length(THETA));

for i = 1:length(THETA)
  theta = THETA(i);
  % [1] define LOAD
  LOAD = INITIAL_LOAD;

  while ~any([TENSILE_FAILURE, COMPRESSIVE_FAILURE, SHEAR_FAILURE, BEARING_FAILURE])
    % [1, 4] define LOAD, increment it each iteration
    LOAD = LOAD + 10;

    % [2] apply LOAD to the truss
    starttime = tic;
    [tensile_stress, compressive_stress, shear_stress, bearing_stress] = BRIDGE_MODEL(LOAD, theta);
    endtime = toc(starttime);

    fprintf('bridge, angle %d, solved for LOAD = %d [N] in %.5f [s]\n', theta, LOAD, endtime)

    % [3] check all the stresses
    TENSILE_FAILURE = any(tensile_stress > TENSILE_YIELD);
    COMPRESSIVE_FAILURE = any(compressive_stress > COMPRESSIVE_YIELD);
    SHEAR_FAILURE = any(shear_stress > SHEAR_YIELD);
    BEARING_FAILURE = any(bearing_stress > COMPRESSIVE_YIELD);
  end

  failure_condition(:, i) = [TENSILE_FAILURE; COMPRESSIVE_FAILURE; SHEAR_FAILURE; BEARING_FAILURE];

  % [5] at least one stress was too high, so the `while` loop exited
  fprintf('The bridge, angle %d, failed at a load of %d [N]\n\n', theta, LOAD)    % print out the LOAD at which the bridge failed

  L_tot = 6*sqrt((LENGTH/4)^2 + (HEIGHT(theta)/2)^2) + 2*LENGTH/2 + HEIGHT(theta);
  W = DENSITY * L_tot * AREA_TRUSS * 9.81;
  hardware_cost = sum([WASHER_CpU*(2*NODE_COUNT), ...
    NUT_CpU*(NODE_COUNT), ...
    BOLT_CpU*(NODE_COUNT), ...
    BALSA_CpI*(L_tot)]);

  PI(i) = LOAD / (W*hardware_cost);
  max_load(i) = LOAD;
  INITIAL_LOAD = LOAD - 10;

  TENSILE_FAILURE = false;
  COMPRESSIVE_FAILURE = false;
  SHEAR_FAILURE = false;
  BEARING_FAILURE = false;
end

% --------------------------------------------------------------------------- %

% <><><>< PLOT AND ANALYZE ><><><> %

figure(1)
plot(THETA, PI, 'o--r')
xlim([0, 90])
ylabel('PI $\left[\frac{1}{\$}\right]$', 'Interpreter', 'latex')
xlabel('Angle $\theta\,[^{\circ}]$', 'Interpreter', 'latex')
title('Example Bridge PI versus angle $\theta$', 'Interpreter', 'latex')

[max_performance, location] = max(PI);
optimal_angle = THETA(location);
expected_load = max_load(location);

fprintf('The bridge achieves a maximum Performance Index of %.3f at an angle %d degrees\n', max_performance, optimal_angle)
fprintf('It is expected to support %0.2f [N]\n', expected_load)

figure(2)
plot(THETA, max_load, 'o--r')
xlim([0, 90])
ylabel('Maximum Load $\left[N\right]$', 'Interpreter', 'latex')
xlabel('Angle $\theta\,[^{\circ}]$', 'Interpreter', 'latex')
title('Example Bridge Maximum Load verus angle $\theta$', 'Interpreter', 'latex')

simulation_end = toc(simulation_start);
fprintf('Total Simulation Time : %0.2f', simulation_end)