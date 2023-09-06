%% Vectors in MATLAB

clear all
close all
clc

% brief introduction to what a vector is
figure(1)
% this vector stores 5 input points from -2 to 2
x = [-2, -1, 0, 1, 2];
y = x.^2; % here, we apply the formula y = x^2
plot(x,y,'o-b') % graph it
xlim([-3,3]) % this changes the limits of the graph along the x direction
ylim([-1,5]) % this changes the limits of the graph along the y direction

% the above graph barely even resembles y=x^2 because there aren't enough
% input points!

% we can use linspace to create a much denser input field
figure(2)
x = linspace(-2,2); % this will create 100 input points
y = x.^2; % apply the equation
plot(x,y,'o-b') % graph it

%% Vector Operations
a = [1, 2, 3];
b = [3, 2, 1];
sum = a + b % vector addition

difference = a - b % vector subtraction

scaleUp = 3*a % scaling a vector up by some multiple (3, in this case)
scaleDown = (1/3)*a % scaling a vector down by some multiple (1/3, in this case)

dotProduct = dot(a,b) % syntax for taking the dot product between two vectors
crossProduct = cross(a,b) % syntax for taking the cross product between two vectors

%% Unit Vectors

magnitude = norm(a) % calculate the magnitude
unitA = a./magnitude % this is a vectorized operation

normUnit = norm(unitA) % note that this result is 1!

%% Trig

sin(pi/2)
sind(90) % note the 'd' at the end of the trig function for degrees

asin(1)
asind(1) % note the 'd' at the end of the trig function for degrees

% define vectors to calculate the angle between
a = [1, 2, 3];
b = [3, 2, 1];

% calculate the numerator and denominator in the formula
numerator = dot(a,b);
denominator = norm(a) * norm(b);

% calculate the angle in radians and degrees
thetaRadians = acos(numerator / denominator)
thetaDegrees = acosd(numerator / denominator)