% This script will make use of the `BRIDGE_MODEL()` function defined in this folder to solve and optimize a bridge

clear all
close all
clc

% --------------------------------------------------------------------------- %

% <><><>< GENERAL PARAMETERS ><><><> %

  % List out all global variables from the problem

  LENGTH = 12;                                  % define the length of the bridge       [m]
  HEIGHT = 2;                                   % define the height of the bridge       [m]
  THETA = atand(HEIGHT / (LENGTH/2));           % define the angle theta
  TENSILE_YIELD = 500 * 10^6;                   % define the tensile yield strength     [Pa]
  COMPRESSIVE_YIELD = 300 * 10^6;               % define the compressive yield strength [Pa]
  SHEAR_YIELD = 250 * 10^6;                     % define the shear yield strength       [Pa]
  
  % <><><>< BRIDGE BROKEN BOOLEANS ><><><> %
  
    % Initialize these as `false`
    % They will be toggled to `true` if a corresponding stress exceeds its limit
  
  TENSILE_FAILURE = false;                      % used to signal a tensile stress failure
  COMPRESSIVE_FAILURE = false;                  % used to signal a compressive stress failure
  BEARING_FAILURE = false;                      % used to signal a bearing stress failure
  SHEAR_FAILURE = false;                        % used to signal a shear stress failure
  
  % --------------------------------------------------------------------------- %
  
  % [1] define LOAD
  LOAD = 35 * 10^3;
  
  while ~any([TENSILE_FAILURE, COMPRESSIVE_FAILURE, SHEAR_FAILURE, BEARING_FAILURE])
    % [1, 4] define LOAD, increment it each iteration
    LOAD = LOAD + 100;
  
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