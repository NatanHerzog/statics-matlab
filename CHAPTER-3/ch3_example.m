clear all
close all
clc

% ----- Vector Projection ----- %

a = [1, 1, 1]; % define vector a
b = [1, 0, 0]; % define vector b
normB = norm(b); % calculate the magnitude of b
e_ob = b./normB; % get the unit direction vector for b
proj = e_ob.*(dot(a, e_ob)); % perform the projection of a onto b

% ----- Alternative Vector Projection ----- %

a = [1, 1, 1]; % define vector a
b = [1, 0, 0]; % define vector b
proj = (b./norm(b)) .* (dot(a, b./norm(b)));

% ----- Vector Cross Products ----- %
a = [3, 2, 1];
b = [5, 4, 3];
cross(a, b)