%ANIL BHUSAL
%MACHINE DESIGN - III / LAB REPORT
%DESIGN OF DRUM BRAKE

clc;
clear all;


fprintf('ANIL BHUSAL\n')
fprintf('\nRequired Braking Torque: 400 N.m\n\n')

% Prior Decisions
T = 400;                  % Total Braking Torque.
f = [0.34 0.4];           % Coefficient of friction of Asbestos and Sintered Metallics.
r = 0.150;                % Radius of the drum.
a = [40:8:100]./1000;    % Distance of hinge from center of drum.
c = 0.220;                % Distance between hinge and actuating force.
b = 0.032;                % Face widths (b).
theta_a = 90;             % Maximum pressure angle.

%Angle subtended by brake fiction lining.
theta_1 = 0;
theta_2 = (120*pi)/180;

pa = zeros(length(a),1);
Mn = zeros(length(a),1);
Mf = zeros(length(a),1);
self_check = zeros(length(a),1);
F = zeros(length(a),1);

% Integration Part.
syms t
expr1 = (sin(t))^2;
int1 = int(expr1, theta_1, theta_2);
int2 = zeros(length(a),1);

for jj = 1:length(a)
    expr2 = sin(t)*(r - a(jj) * cos(t));
    int2(jj) = int(expr2, theta_1, theta_2);
end

% Different parameters with varying hinge to center length.
for ii = 1:length(a)
    pa(ii) = (T * sin(theta_a))/(f(1)* b * (r^2) * (cos(theta_1)-cos(theta_2)));
    Mn(ii) = ((pa(ii)* b * r * a(ii))/sin(theta_a))* int1;
    Mf(ii) = ((pa(ii)* b * r * f(1))/sin(theta_a))* int2(ii);
    if Mn(ii) > Mf(ii)
        self_check(ii) = 1;
    end
    
    F(ii) = (Mn(ii) - Mf(ii))/c;
    
end

%Printing data in tabular form
fprintf('Calculating different parameters by varying hinge to center distance (a).\n\n')
fprintf('------------------------------------------------------------------------------------\n');
fprintf(' H-C(a)\t\t\tPa\t\t\t\t\tMn\t\t\t\tMf\t\t\tSL\t\t\tF\n');
fprintf('------------------------------------------------------------------------------------\n');
for ii = 1:length(a)
    fprintf(' %.4f\t\t\t%-12.4f\t\t%.3f\t\t\t%.3f\t\t%d\t\t\t%.2f\n', a(ii), pa(ii),Mn(ii), Mf(ii)...
        , self_check(ii), F(ii))
end
fprintf('\nWhere N-C means center of drum to hinge distance.\n')
fprintf('And, 0 means self locking and 1 means self not locking.\n')


% Different parameters with varying face width (b)
a = 0.072;
b = [30:5:100]./1000;

pa = zeros(length(b),1);
Mn = zeros(length(b),1);
Mf = zeros(length(b),1);
self_check = zeros(length(b),1);
F = zeros(length(b),1);

expr2 = sin(t)*(r - a * cos(t));
int2 = int(expr2, theta_1, theta_2);

for ii = 1:length(b)
    pa(ii) = (T * sin(theta_a))/(f(1)* b(ii)* (r^2) * (cos(theta_1)-cos(theta_2)));
    Mn(ii) = ((pa(ii)* b(ii)* r * a)/sin(theta_a))* int1;
    Mf(ii) = ((pa(ii)* b(ii)* r * f(1))/sin(theta_a)* int2);
    if Mn(ii) > Mf(ii)
        self_check(ii) = 1;
    end
    
    F(ii) = (Mn(ii) - Mf(ii))/c;
    
end
fprintf('\nCalculating different parameters by varying facewidth (b).\n\n')
fprintf('Facewidth (b)\t\tPa\t\t\t\tMn\t\t\t\tMf\t\t\tSL\t\t\tF\n');
fprintf('------------------------------------------------------------------------------------\n');
for ii = 1:length(b)
    fprintf(' %.4f\t\t\t%-12.4f\t\t%.3f\t\t\t%.3f\t\t%d\t\t\t%.2f\n', b(ii),...
        pa(ii),Mn(ii), Mf(ii), self_check(ii), F(ii))
end
fprintf('\n')

