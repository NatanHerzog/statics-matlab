clear all % this statement clears all variables from the workspace
close all % this statement closes all figures
clc % this statement clears the command window

% This is an introductory script to review basic MATLAB functionality

%% HELLO WORLD

% Using the fprintf() function, let's print "Hello World"
fprintf("Hello World\n") % NOTE: the '\n' is the sequence for a new line

% Now let's do the same thing, but with a variable declaration instead
message = "Hello World\n";
fprintf(message)

% This way, we can redefine the variable 'message' and just reprint it
message = "New Message\n";
fprintf(message)