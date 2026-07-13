%% Combined PhCs and W1s
%
% We plot the data gathered for both the pure photonic crystals and the W1
% waveguides to more precisely see what happens when the line defect is
% introduced to the system. Specifically, what frequencies are passed
% because they lie outside of the band gap and what frequencies are passed
% because they are confined in the W1 waveguide.

clear all
close all

% Import pure PhC data
PhC_TE = 'Jul_03_2026/PhC/a390_r98_nx25_0/PHC_A390NM_R98NM_N25_TE_0.dat';

PhC_TM = 'Jul_03_2026/PhC/a390_r98_nx25_0/PHC_A390NM_R98NM_N25_TM_0.dat';

% Import W1 data
W1_TE = 'Jul_03_2026/PBG/a390_r98_nx25_0/W1_A390NM_R98NM_N25_TE_0.dat';

W1_TM = 'Jul_03_2026/PBG/a390_r98_nx25_0/W1_A390NM_R98NM_N25_TM_0.dat';

name = 'a=390nm, r=98nm v1';

plotData(PhC_TE, PhC_TM, W1_TE, W1_TM, name)

function plotData(PhCTE, PhCTM, W1TE, W1TM, name)

    A = importdata(PhCTE);
    power_PhC_TE = A(:,2); % mW
    powerdB_PhC_TE = 10*log10(power_PhC_TE); % dBm

    B = importdata(PhCTM);
    power_PhC_TM = B(:,2); % mW
    powerdB_PhC_TM = 10*log10(power_PhC_TM); % dBm

    C = importdata(W1TE);
    power_W1_TE = C(:,2); % mW
    powerdB_W1_TE = 10*log10(power_W1_TE); % dBm

    D = importdata(W1TM);
    lambda_nm = D(:,1); % nm
    power_W1_TM = D(:,2); % mW
    powerdB_W1_TM = 10*log10(power_W1_TM); % dBm

    % Plot wavelength sweep in dBm
    figure
    plot(lambda_nm, powerdB_PhC_TE)
    hold on
    plot(lambda_nm, powerdB_W1_TE)
    hold off
    xlabel('Wavelength (nm)')
    ylabel('Measured Power (dBm)')
    legend('pure crystal', 'line defect')
    title(strcat(name, ' TE'))

    figure
    plot(lambda_nm, powerdB_PhC_TM)
    hold on
    plot(lambda_nm, powerdB_W1_TM)
    hold off
    xlabel('Wavelength (nm)')
    ylabel('Measured Power (dBm)')
    legend('pure crystal', 'line defect')
    title(strcat(name, ' TM'))

    % Pull transmission at 1550nm
    % later version of script: return this transmission value
    % T_1550 = powerdB(find(lambda_nm == 1550));
    % fprintf('The power for %s at 1550nm is: %f.\n', name, T_1550);
end