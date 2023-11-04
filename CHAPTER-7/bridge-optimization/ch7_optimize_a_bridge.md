# Chapter 7 (Part 2)

Before diving into how to optimize the bridge, be sure to read through `ch7_model_a_bridge.md` and the associated MATLAB script, `ch7_example_1.m`. This portion of Chapter $7$ builds upon what was covered there in order to introduce the concept of optimizing your bridge designs.

## Bridge Optimization

Previously, I analyzed a Queen Post truss at a single load. But for your project, you are interested in predicting how much weight your bridge can withstand before breaking. We can do this in MATLAB in the same way that a real-life test rig behaves: slowly increase the applied load until the bridge breaks.

Well, slowly increasing a variable until reaching a condition is the *perfect* scenario for implementing a loop! Refer back to `ch5_plan.md` and `ch6_plan.md` for some simple examples of this.

Fow now, we can write a pseudo-code version just to wrap our heads around what will actually be happening here.

```MATLAB
% [1] define LOAD at some low value to start off with
% [2] apply LOAD to the truss structure at the relevant nodes and solve (part 1 of this chapter's content)
% [3] check whether any stresses in the bridge are too high
% [4] if not, go back to step [2] and increase LOAD a little bit
% [5] if yes, exit the loop
```

Although the whole thing may look intimidating, those individual instructions are pretty simple to implement.

A note before you read this demonstration: *The whole code to solve the bridge is pretty long (`ch7_example_1.m`), so I'm going to pretend that it's a separate function for right now for visual simplicity. It will be treated as some magic box where you input the LOAD and $\theta$ and it tells you all the internal stresses*

```MATLAB
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
  [tensile_stress, compressive_stress, shear_stress, bearing_stress] = BRIDGE_MODEL(LOAD, THETA);

  % [3] check all the stresses
  TENSILE_FAILURE = any(tensile_stress > TENSILE_YIELD)
  COMPRESSIVE_FAILURE = any(compressive_stress > COMPRESSIVE_YIELD)
  SHEAR_FAILURE = any(shear_stress > SHEAR_YIELD)
  BEARING_FAILURE = any(bearing_stress > COMPRESSIVE_YIELD)
end

% [5] at least one stress was too high, so the `while` loop exited
```

In order to accomplish this, we can make a couple of slight changes to what was covered in Part $1$ to define a function that will solve the bridge, `BRIDGE_MODEL()`, for some input value of $\theta$ and the LOAD. This will be an adaption of `ch7_example_1.m`

```MATLAB
function [tensile_stress, compressive_stress, shear_stress, bearing_stress] = BRIDGE_MODEL(LOAD, THETA)

  % --------------------------------------------------------------------------- %

  % <><><>< GENERAL PARAMETERS ><><><> %

  AREA_TRUSS = 100 * (10^(-2))^2;               % define the cross-sectional area       [m^2]
  BOLT_DIAMETER = 4.1656 * 10^(-3);             % define the bolt diameter              [m]
  AREA_BOLT = BOLT_DIAMETER * sqrt(AREA_TRUSS); % define the bolt area                  [m^2]

  % <><><>< STRESS CALCULATION FUNCTION ><><><> %

  calculate_stress = @(F, A) F ./ A;

  % --------------------------------------------------------------------------- %

  % ----------------------- %
  % SYMBOLIC SYSTEM OF EQNS %   % intentionally not rewritten because it's too big
  % ----------------------- %

  % create a vector to of all 9 internal forces

  internal_forces = [F_AB F_AC F_BC F_BD F_CD F_CE F_CF F_DE F_EF];

  % --------------------------------------------------------------------------- %

  % <><><>< STRESSES ><><><> %

    % calculate the normal (compressive/tensile), shear, and bearing stresses ([Pa])

  normal_stress = calculate_stress(internal_forces, AREA_TRUSS);  % can still be positive or negative
  shear_stress = abs(normal_stress) ./ 2;                         % returns a positive value

  tensile_stress = normal_stress(normal_stress < 0)             % positive normal stress values
  compressive_stress = abs(normal_stress(normal_stress > 0))    % negative normal stress values

  bearing_stress = calculate_stress(abs(internal_forces), AREA_BOLT);

end
```

What we have just accomplished is determining the load that the truss structure, as defined by the angle $\theta$, with stand. Now we want to optimize the design (optimize the angle $\theta$).

We can do this by placing the entire `while` loop we have just written into a `for` loop that iterates over a range of values for $\theta$. This way, we can evaluate the performance of the bridge at every value of $\theta$ and determine the best value of $\theta$ based on our definition of best 'performance'.
