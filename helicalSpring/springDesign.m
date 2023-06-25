
%ANIL BHUSAL
%THA075BME004
%MACHINE DESIGN - II / LAB REPORT
%DESIGN OF MECHANICAL SPRING

% Assuming the required spring is As-wound
% This script prompts all the data required from data book.
% A vector of possible "d" will be given as input.
% Material used is Music wire.
% End squared and Ground.

clc;
clear all;

fprintf('ANIL BHUSAL - THA075BME004')
fprintf('\nMATERIAL USED : Music Wire A228\n\n')
A = 1122;       %From Table 10-4, enter "A"
m = 0.145;      %From Table 10-4, enter "m"
Fmax = 400;     %Enter maximum Load (N):
Ymax = input('Enter maximum extension (mm): ');
E = 196500;     %Enter E (MPa)(Assuming d > 1.61 mm)
G = 81000;      %Enter G (Mpa)

%Assumptions
Ns = 1.2;                % Factor of Safety.
Rl = 0.15;               % Robust Lineraity.

d = input('\nEnter 1st  Trial diameters: ');
count = 1;
maxits = 8;
oV = zeros(9, maxits);
dias = zeros(1,maxits);

%Calculating different parameters for different
%diameters.


while count ~= maxits + 1
    Sut = A /(d^m);
    Ssy = 0.45 * Sut;
    alpha = Ssy/1.2;
    beta = (8 *(1 + Rl)* Fmax)/(pi * d^2);
    C = ((2*alpha - beta)/(4*beta)) + sqrt(((2*alpha - beta)/(4*beta))^2 - ...
        ((3 * alpha)/(4 * beta)));
    D = C * d;
    Kb = (4*C + 2)/(4*C - 3);
    Taus = (8 *(1 + Rl)* Fmax)/(pi * d^3)* Kb * D;
    Ns = Ssy / Taus;
    OD = D + d;
    ID = D - d;
    Na = round((G * d^4 * Ymax)/(8 * D^3 * Fmax));
    Nt = Na + 2;
    Ls = d * Nt;
    Lo = Ls + (1 + Rl)* Ymax;
    Lcr = 2.63*(D/0.5);
    FOM = - 2.6 * (pi^2 * d^2 * Nt * D)/(4 * 25.4^3);
    
    oV(:, count) = [D, C, OD, Na, Ls, Lo, Lcr, Ns, FOM]'; 
    dias(1, count) = d;
     
    count = count + 1;
    d = input('Enter next Trial diameters: ');
end

fprintf('\n');
A = {'D' 'C' 'OD' 'Na' 'Ls' 'Lo' 'Lc' 'Ns' 'Fom'};
A = A';
fprintf('-----------------------------------------------------------------------------------------------------------------------------------\n');
fprintf('d:\t\t\t%.1f\t\t\t\t%.1f\t\t\t\t%.1f\t\t\t\t%.1f\t\t\t\t%.1f\t\t\t\t%.1f\t\t\t\t%.1f\t\t\t\t%.1f\n',...
    dias(1,1),dias(1,2),dias(1,3),dias(1,4),dias(1,5),dias(1,6),dias(1,7),dias(1,8));
fprintf('-----------------------------------------------------------------------------------------------------------------------------------\n');
[r, c] = size(oV);
oV(5,:) = oV(5,:) - 8;
for i = 1:r
        fprintf('%s\t\t\t%.2f\t\t\t%.2f\t\t\t%.2f\t\t\t%.2f\t\t\t%.2f\t\t\t%.2f\t\t\t%.2f\t\t\t%.2f\n',A{i,1},...
            oV(i,1),oV(i,2),oV(i,3),oV(i,4),oV(i,5),oV(i,6),oV(i,7),oV(i,8));
end

fprintf('-----------------------------------------------------------------------------------------------------------------------------------\n');
fprintf('\nWhere Lc = (Lo)cr = Critical free length to avoid buckling.\n');


