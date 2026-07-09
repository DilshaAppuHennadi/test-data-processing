%% Photonic Crystals
%
% The purpose of this script is to check the transmission of the pure
% photonic crystals. The PhCs should display a stop band of reflected TE
% light with in the spectrum. This can be compared to the W1 PhC's stop
% bands to determine if and how much the band edges move when a line defect
% is introduced to the system.

clear all
close all

A = 'Jul_03_2026/PhC/a390_r118_nx25_0/PHC_A390NM_R118NM_N25_TE_0.dat';
name = 'PhC a=390nm, r=118nm TE v1';
plotData(A, name)

B = 'Jul_03_2026/PhC/a390_r118_nx25_0/PHC_A390NM_R118NM_N25_TM_0.dat';
name = 'PhC a=390nm, r=118nm TM v1';
plotData(B, name)

function plotData(filename, name)
    A = importdata(filename);
    lambda_nm = A(:,1);
    power = A(:,2); % mW
    powerdB = 10*log10(power); % dBm

    % Plot wavelength sweep in dBm
    figure
    plot(lambda_nm, powerdB)
    xlabel('Wavelength (nm)')
    ylabel('Measured Power (dBm)')
    title(name)

    % Pull transmission at 1550nm
    % later version of script: return this transmission value
    T_1550 = powerdB(find(lambda_nm == 1550));
    fprintf('The power for %s at 1550nm is: %f.\n', name, T_1550);
end