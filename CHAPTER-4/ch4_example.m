%% Basic Symbolic Integration (indefinite integral)

syms x                          % define symbolic x
expr = x^2;                     % define expression y = x^2
integratedExpr = int(expr,x)    % solve indefinite integral

%% Basic Symbolic Integration (definite integral)

clear all

syms x                              % define symbolic x
expr = x^2;                         % define expression y = x^2
integratedExpr = int(expr,x,0,5)    % solve definite integral on interval [0,5]

%% Center of Area (y=x^2 on interval [1,6])

clear all

syms x                                              % define symbolic x
numerator = int(x^3, x, 1, 6);                      % integrate numerator
denominator = int(x^2, x, 1, 6);                    % integrate denominator
x_bar = double(simplify(numerator / denominator))   % solve x_bar

syms y                                              % define symbolic y
numerator = int(6*y-y^(3/2), y, 1, 36);             % integrate numerator
denominator = int(6-sqrt(y), y, 1, 36);             % integrate denominator
y_bar = double(simplify(numerator / denominator))   % solve y_bar