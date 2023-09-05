%% Vectors in MATLAB

clear all
% close all
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

scaleUp = 3*a
scaleDown = (1/3)*a

dotProduct = dot(a,b)

%% Unit Vectors

magnitude = norm(a)
unitA = a./magnitude % this is a vectorized operation

%% Trig

sin(pi/2)
sind(90)

asin(1)
asind(1)

a = [1, 2, 3];
b = [3, 2, 1];
numerator = dot(a,b);
denominator = norm(a) * norm(b);
thetaRadians = acos(numerator / denominator)
thetaDegrees = acosd(numerator / denominator)