% Practicing Symbolic Integration for Centroids

%% --------------- STEP-BY-STEP 1 --------------- %%
% [] Let's validate that the centroid of a circle is at its center (a,b)
%   [] Here is the equation of a circle centered at (a,b): (x-a)^2 + (y-b)^2 = r^2
% [] First, rearrange the equation into the form y = f(x) (note that the sqrt operation should be returns a positive and a negative side, so the circle will actually be 2 equations, y = f(x), y = g(x))
% [] Using symbolic integration, determine the area of the circle (integrate both f(x) and g(x))
%   [] Note that you have an upper and a lower curve of the circle. In order to represent the circle itself, you have to subtract the lower one from the upper
%   [] Note that the area matches the expected formula, A = pi*r^2
% [] Using symbolic integration, solve for the numerator of the centroid equation in x_bar
% [] Divide the numerator by the area to get x_bar
% [] Repeat for y_bar