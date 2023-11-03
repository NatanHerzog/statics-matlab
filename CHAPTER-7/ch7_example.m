clear all
close all
clc

% --------------------------------------------------------------------------- %

% <><><>< GENERAL PARAMETERS ><><><> %

LENGTH = 12;                                  % define the length of the bridge       [m]
HEIGHT = 2;                                   % define the height of the bridge       [m]
AREA_TRUSS = 100 * (10^(-2))^2;               % define the cross-sectional area       [m^2]
BOLT_DIAMETER = 4.1656 * 10^(-3);             % define the bolt diameter              [m]
AREA_BOLT = BOLT_DIAMETER * sqrt(AREA_TRUSS); % define the bolt area                  [m^2]
TENSILE_YIELD = 500 * 10^6;                   % define the tensile yield strength     [Pa]
COMPRESSIVE_YIELD = 300 * 10^6;               % define the compressive yield strength [Pa]
SHEAR_YIELD = 250 * 10^6;                     % define the shear yield strength       [Pa]
THETA = atand(HEIGHT / (LENGTH/2));           % define the angle theta
LOAD = 10 * norm([6,2]);                      % define the load that acts on B and E  [kN]

% <><><>< BRIDGE BROKEN BOOLEANS ><><><> %

TENSILE_FAILUE = false;                       % used to signal a tensile stress failure
COMPRESSIVE_FAILUE = false;                   % used to signal a compressive stress failure
BEARING_FAILURE = false;                      % used to signal a bearing stress failure

% --------------------------------------------------------------------------- %

% <><><>< Global Reactions ><><><> %
syms R_x_A R_y_A R_y_F

% <><><>< Internal Forces ><><><> %
syms F_AB F_AC F_BC F_BD F_CD F_CE F_CF F_DE F_EF

% --------------------------------------------------------------------------- %

% <><><>< Pin A ><><><> %

% ----- Sigma F_x ----- %
F_x_A = R_x_A - F_AB*cosd(THETA) - F_AC == 0;

% ----- Sigma F_y ----- %
F_y_A = R_y_A - F_AB*sind(THETA) == 0;

% --------------------------------------------------------------------------- %

% <><><>< Pin B ><><><> %

% ----- Sigma F_x ----- %
F_x_B = F_AB*cosd(THETA) - F_BD*cosd(THETA) - F_BC*cosd(THETA) == 0;

% ----- Sigma F_y ----- %
F_y_B = F_AB*sind(THETA) - F_BD*sind(THETA) + F_BC*sind(THETA) - LOAD == 0;

% --------------------------------------------------------------------------- %

% <><><>< Pin C ><><><> %

% ----- Sigma F_x ----- %
F_x_C = F_AC + F_BC*cosd(THETA) - F_CE*cosd(THETA) - F_CF == 0;

% ----- Sigma F_y ----- %
F_y_C = -F_BC*sind(THETA) - F_CD - F_CE*sind(THETA) == 0;

% --------------------------------------------------------------------------- %

% <><><>< Pin D ><><><> %

% ----- Sigma F_x ----- %
F_x_D = F_BD*cosd(THETA) - F_DE*cosd(THETA) == 0;

% ----- Sigma F_y ----- %
F_y_D = F_BD*sind(THETA) + F_CD + F_DE*sind(THETA) == 0;

% --------------------------------------------------------------------------- %

% <><><>< Pin E ><><><> %

% ----- Sigma F_x ----- %
F_x_E = F_DE*cosd(THETA) + F_CE*cosd(THETA) - F_EF*cosd(THETA) == 0;

% ----- Sigma F_y ----- %
F_y_E = -F_DE*sind(THETA) + F_CE*sind(THETA) + F_EF*sind(THETA) - LOAD == 0;

% --------------------------------------------------------------------------- %

% <><><>< Pin F ><><><> %

% ----- Sigma F_x ----- %
F_x_F = F_EF*cosd(THETA) + F_CF == 0;

% ----- Sigma F_y ----- %
F_y_F = R_y_F - F_EF*sind(THETA) == 0;

% --------------------------------------------------------------------------- %

% <><><>< SOLVE ><><><> %

eqns = [F_x_A F_x_B F_x_C F_x_D F_x_E F_x_F...
        F_y_A F_y_B F_y_C F_y_D F_y_E F_y_F];
vars = [F_AB F_AC F_BC F_BD F_CD F_CE F_CF F_DE F_EF R_x_A R_y_A R_y_F];
internal_forces = solve(eqns, vars);

F_AB = double(internal_forces.F_AB)
F_AC = double(internal_forces.F_AC)
F_BC = double(internal_forces.F_BC)
F_BD = double(internal_forces.F_BD)
F_CE = double(internal_forces.F_CE)
F_CF = double(internal_forces.F_CF)
F_CD = double(internal_forces.F_CD)
F_DE = double(internal_forces.F_DE)
F_EF = double(internal_forces.F_EF)
R_x_A = double(internal_forces.R_x_A)
R_y_A = double(internal_forces.R_y_A)
R_y_F = double(internal_forces.R_y_F)

internal_forces = [F_AB F_AC F_BC F_BD F_CD F_CE F_CF F_DE F_EF];

normal_stress = internal_forces ./ AREA_TRUSS;  % can still be positive or negative
shear_stress = abs(normal_stress) ./ 2;         % returns a positive value

tensile_stress = normal_stress(normal_stress > 0);            % positive normal stress values
compressive_stress = abs(normal_stress(normal_stress < 0));   % negative normal stress values

bearing_stress = internal_forces ./ AREA_BOLT;
tensile_bearing_stress = bearing_stress(bearing_stress > 0);
compressive_bearing_stress = abs(bearing_stress(bearing_stress < 0));

TENSILE_FAILUE = any(tensile_stress > TENSILE_YIELD)
COMPRESSIVE_FAILURE = any(compressive_stress > COMPRESSIVE_YIELD)
BEARING_FAILURE = any([tensile_bearing_stress > TENSILE_YIELD, compressive_bearing_stress > COMPRESSIVE_YIELD])