% This script will make use of the `BRIDGE_MODEL()` function defined in this folder to solve and optimize a bridge

clear all
close all
clc

% --------------------------------------------------------------------------- %

% <><><>< GENERAL PARAMETERS ><><><> %

% List out all global variables from the problem

LENGTH = 12;                                  % define the length of the bridge       [m]
HEIGHT = @(t) tand(t) * LENGTH/2;             % define the height of the bridge       [m]
AREA_TRUSS = 100 * (10^(-2))^2;               % define the cross-sectional area       [m^2]
% THETA = linspace(15, 75);                     % define the angle theta
THETA = 30;

TENSILE_YIELD = 19.9 * 10^6;                  % define the tensile yield strength     [Pa]
COMPRESSIVE_YIELD = 12.1 * 10^6;              % define the compressive yield strength [Pa]
SHEAR_YIELD = 5 * 10^6;                       % define the shear yield strength       [Pa]
DENSITY = 150;                                % define the density                    [kg/m^3]

BALSA_CpI = 0.0407;                           % Balsa wood cost [$/m]
WASHER_CpU = 0.0411;                          % Washer cost [$/unit]
NUT_CpU = 0.0457;                             % Nut cost [$/unit]
BOLT_CpU = 0.1564;                            % 1.5" Bolt cost [$/unit]

NODE_COUNT = 6;                               % Number of nodes

% <><><>< BRIDGE BROKEN BOOLEANS ><><><> %

% Initialize these as `false`
% They will be toggled to `true` if a corresponding stress exceeds its limit

TENSILE_FAILURE = false;                      % used to signal a tensile stress failure
COMPRESSIVE_FAILURE = false;                  % used to signal a compressive stress failure
BEARING_FAILURE = false;                      % used to signal a bearing stress failure
SHEAR_FAILURE = false;                        % used to signal a shear stress failure

% --------------------------------------------------------------------------- %

% [1] define LOAD
LOAD = 2 * 10^3;

while ~any([TENSILE_FAILURE, COMPRESSIVE_FAILURE, SHEAR_FAILURE, BEARING_FAILURE])
  % [1, 4] define LOAD, increment it each iteration
  LOAD = LOAD + 10;

  % [2] apply LOAD to the truss
  starttime = tic;
  [tensile_stress, compressive_stress, shear_stress, bearing_stress] = BRIDGE_MODEL(LOAD, THETA);
  endtime = toc(starttime);

  fprintf('bridge solved for LOAD = %d [N] in %.5f [s]\n', LOAD, endtime)

  % [3] check all the stresses
  TENSILE_FAILURE = any(tensile_stress > TENSILE_YIELD);
  COMPRESSIVE_FAILURE = any(compressive_stress > COMPRESSIVE_YIELD);
  SHEAR_FAILURE = any(shear_stress > SHEAR_YIELD);
  BEARING_FAILURE = any(bearing_stress > COMPRESSIVE_YIELD);
end

% [5] at least one stress was too high, so the `while` loop exited
fprintf('The bridge failed at a load of %d [N]\n', LOAD)    % print out the LOAD at which the bridge failed

L_tot = 6*sqrt((LENGTH/4)^2 + (HEIGHT(THETA)/2)^2) + 2*LENGTH/2 + HEIGHT(THETA);
W = DENSITY * L_tot * AREA_TRUSS * 9.81;
hardware_cost = sum([WASHER_CpU*(2*NODE_COUNT), ...
                     NUT_CpU*(NODE_COUNT), ...
                     BOLT_CpU*(NODE_COUNT), ...
                     BALSA_CpI*(L_tot)]);

PI = LOAD / (W*hardware_cost);