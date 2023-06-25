%ANIL BHUSAL
%THA075BME004
%MACHINE DESIGN - II / LAB REPORT
%DESIGN OF POWER SCREW

%Trails for self lock checking of Power Screw

%For first iteration assuming 'd' as variable
%and 'p' as constant.

clc;
clear all;
close all;

% Assuming single start thread.

d = 60:2:80;        %Nomial diameter
p = 9;              %Pitch of the thread.
mu = 0.18;          %Coefficient of friction.
sl = zeros(length(d));


for ii = 1:length(d)
    dc = d(ii) - p;
    dm = d(ii) - 0.5*p;     %For single starting.
    alpha = atand(p/(pi*dm));
    phi = atand(mu);
    if phi > alpha
        sl(ii) = 1;
    end
end

fprintf('Checking whether the given ''d'' is\n');
fprintf('self locking or not.\n\n ');
fprintf('d\t\t\t\tSelfLock/ Not SelfLock\n');
    
for jj = 1:length(d)
    fprintf('%4.2f\t\t\t\t%d\n', d(jj), sl(jj));
end

    
    