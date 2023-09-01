clear all % this statement clears all variables from the workspace
close all % this statement closes all figures
clc % this statement clears the command window

% This is an introductory script to review basic MATLAB functionality

%% HELLO WORLD 
% note that double % indicates a section break in MATLAB

% Using the fprintf() function, let's print "Hello World"
fprintf("Hello World\n") % NOTE: the '\n' is the sequence for a new line

% Now let's do the same thing, but with a variable declaration instead
message = "Hello World\n";
fprintf(message)

% This way, we can redefine the variable 'message' and just reprint it
message = "New Message\n";
fprintf(message)

%% BASIC MATH

% The first step is define a variable
a = 5;

% Now we can modify it and reassign the new value to a new variable
b = a + 2
c = a - 2
d = a * 2
e = a / 2
f = a^2
g = sqrt(a)

% We can also work with multiple variables together and PEMDAS still applies in MATLAB
h = (b * c) + d - (e / f)^2