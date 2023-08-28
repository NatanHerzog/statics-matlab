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

%% BASIC LOOPING

% In solving problems, it is common to repeat the same operation over and
% over until some threshold is met. Let's introduce the pieces for
% performing such a repetition.

% An 'if' statement allows you to check *something* and to perform certain
% actions according to the result of *something*. For example:

a = 5;
b = 4;
if a > b % Because we just defined 'a' and 'b', we expect this message:
    fprintf(['a = ', num2str(a), ' is greater than b = ', num2str(b),'\n'])
elseif a == b % We do not expect to see this message
    fprintf(['a = ', num2str(a), ' is equal to b = ', num2str(b),'\n'])
else % We do not expect to see this message
    fprintf(['a = ', num2str(a), ' is less than b = ', num2str(b),'\n'])
end

% But if we change 'a' and 'b', the message will also change. Let's do this
% with a loop.
for i=1:3
    if a > b % Because we just defined 'a' and 'b', we expect this message:
    fprintf(['a = ', num2str(a), ' is greater than b = ', num2str(b),'\n'])
    elseif a == b % We do not expect to see this message
        fprintf(['a = ', num2str(a), ' is equal to b = ', num2str(b),'\n'])
    else % We do not expect to see this message
        fprintf(['a = ', num2str(a), ' is less than b = ', num2str(b),'\n'])
    end
    b = b + 1;
end

% The for loop we just used is great for performing a known number of
% iterations. But sometimes, you want the operation to repeat an indefinite
% number of times until some condition is met. This is the perfect use
% case for a while loop.

% Here, I define 'a' to be a random number between 5-10 and 'b' to be
% random between 1-4. The loop should repeat until b > a, but because both
% numbers are random, I don't know ahead of time how many iterations it has
% to complete.
a = randi([5,10]);
fprintf(['a = ', num2str(a),'\n'])
b = randi([1, 4]);
fprintf(['b = ', num2str(b),'\n'])

i = 0; % this variable will be used to count the number of iterations
while a >= b
    b = b + 1;
    i = i + 1;
end
fprintf([num2str(i), ' iterations were performed before b > a\n'])