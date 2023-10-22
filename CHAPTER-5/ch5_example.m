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

%% Matrix Form of Systems of Equations

L_cd = norm([(59-21), 50, 42]);
theta_1 = asin(42/L_cd);
theta_2 = atan(50/(59-21));

% bit matrix equation
M = [1, 0, 0, 0, 0, cos(theta_1)*cos(theta_2);...
     0, 1, 0, 1, 0, -cos(theta_1)*sin(theta_2);...
     0, 0, 1, 0, 1, sin(theta_1);...
     0, 0, -50, 0, -50, 0;...
     0, 0, -53, 0, 11, 0;...
     50, 53, 0, -11, 0, 0];

W = 240;
b = [0; 0; W; -25*W; -21*W; 0];

v = inv(M)*b

%% Symbolic Form for Systems of Equations

% basic system
syms x y
eqn1 = x + y == 10;
eqn2 = (1/2)*x - y == -3;

eqns = [eqn1, eqn2];
vars = [x, y];
solve(eqns, vars)

% door hinge problem
L_cd = norm([(59-21), 50, 42]);                           % get length of CD
theta_1 = asin(42/L_cd);                                  % define theta_1
theta_2 = atan(50/38);                                    % define theta_2

W = 240;                                                  % define weight

syms Rax Ray Raz Rby Rbz Tcd                              % declare variables
sigma_F_x = Rax + Tcd*cos(theta_1)*cos(theta_2) == 0;
sigma_F_y = Ray + Rby - Tcd*cos(theta_1)*sin(theta_2) == 0;
sigma_F_z = Raz + Rbz + Tcd*sin(theta_1) - W == 0;
sigma_M_cx = -Raz*50 - Rbz*50 + W*25 == 0;
sigma_M_cy = -Raz*(74-21) + Rbz*(21-10) + W*(84/2-21) == 0;
sigma_M_cz = Rax*50 + Ray*(74-21) - Rby*(21-10) == 0;

eqns = [sigma_F_x, sigma_F_y, sigma_F_z, sigma_M_cx, sigma_M_cy, sigma_M_cz];
vars = [Rax Ray Raz Rby Rbz Tcd];

soln = solve(eqns, vars);

Rax = double(soln.Rax)
Ray = double(soln.Ray)
Raz = double(soln.Raz)
Rby = double(soln.Rby)
Rbz = double(soln.Rbz)
Tcd = double(soln.Tcd)

%% Friction on an Inclined Plane

clear all
close all
clc

mu_s = 0.61;  % set the coefficient of static friction

phi = linspace(0,90,100);   % define a vector for phi to loop over

SLIPPED = false;    % initiate SLIPPED variable to track whether the block has slipped

for i=1:length(phi)
  % define the generalized vectors for each force
  W = [0, -10];
  F_N = norm(W)*cosd(phi(i))*[sind(phi(i)), cosd(phi(i))];
  F_f = mu_s*norm(F_N)*[-cosd(phi(i)), sind(phi(i))]; % we will come back to this

  % evaluate sum of forces in x-direction
  sigma_F_x(i) = W(1) + F_N(1) + F_f(1);

  if sigma_F_x(i) > 0 && SLIPPED == false
    SLIPPED = true;   % track that the block has slipped
    max_angle = phi(i);   % store the maximum angle
  elseif SLIPPED == false
    % F_f as defined above represents the *maximum* possible force with which it can resist motion.
    % the actual magnitude of F_f is only as high as is necessary to resist the forces present
    F_f(1) = -F_N(1);   % reset the values back down to match the actual applied loads
    F_f(2) = -(W(2) + F_N(2));
  end

  % recalculate the net forces in x and y
  sigma_F_x(i) = W(1) + F_N(1) + F_f(1);
  sigma_F_y(i) = W(2) + F_N(2) + F_f(2);
end

fprintf('\nThe maximum angle at which the block remains stationary is %0.2f degrees\n', max_angle)

figure(1)
plot(phi, sigma_F_x);
hold on
plot(phi, sigma_F_y);
xlim([0,90])
xlabel('phi [deg]')
ylabel('Force [N]')
title('Force Equilibrium for a Block on an Inclined Plane')
legend('sigma_F_x', 'sigma_F_y')
hold off