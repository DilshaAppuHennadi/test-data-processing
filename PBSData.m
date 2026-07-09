%% PBS
%
% The purpose of this script is to study the behaviour of the PBS devices.
% This includes the transmission of the devices - do TE and TM get split?
% We check the transmission of the devices at 1550nm and determine the
% extinction ratio for TE and TM.

clear all
close all

TEdir = 'Jul_03_2026/PBS/PBS_a390_r108_nx25_0/PBS_A390NM_R108NM_N25_TE_DIR_0.dat';
TEadj = 'Jul_03_2026/PBS/PBS_a390_r108_nx25_0/PBS_A390NM_R108NM_N25_TE_ADJ_0.dat';
TMdir = 'Jul_03_2026/PBS/PBS_a390_r108_nx25_0/PBS_A390NM_R108NM_N25_TM_DIR_0.dat';
TMadj = 'Jul_03_2026/PBS/PBS_a390_r108_nx25_0/PBS_A390NM_R108NM_N25_TM_ADJ_0.dat';
name = 'PBS (a=390nm, r=108nm, n_x=25)';
plotPBSData(TEdir, TEadj, TMdir, TMadj, name)

function plotPBSData(TEd, TEa, TMd, TMa, name)
    A = importdata(TEd);
    lambda_nm = A(:,1);
    power_TE_dir = A(:,2); % mW
    powerdB_TE_dir = 10*log10(power_TE_dir) - (-1); % dBm

    B = importdata(TEa);
    lambda_nm = B(:,1);
    power_TE_adj = B(:,2); % mW
    powerdB_TE_adj = 10*log10(power_TE_adj) - (-1); % dBm

    C = importdata(TMd);
    lambda_nm = C(:,1);
    power_TM_dir = C(:,2); % mW
    powerdB_TM_dir = 10*log10(power_TM_dir) - (-1); % dBm

    D = importdata(TMa);
    lambda_nm = D(:,1);
    power_TM_adj = D(:,2); % mW
    powerdB_TM_adj = 10*log10(power_TM_adj) - (-1); % dBm

    % Plot wavelength sweep in dBm
    figure
    plot(lambda_nm, powerdB_TE_dir)
    hold on
    plot(lambda_nm, powerdB_TE_adj)
    plot(lambda_nm, powerdB_TM_dir)
    plot(lambda_nm, powerdB_TM_adj)
    hold off
    xlabel('Wavelength (nm)')
    ylabel('Measured Power (dBm)')
    legend('TE DIR','TE ADJ','TM DIR','TM ADJ')
    title(name)

    % Pull transmission at 1550nm
    % later version of script: return this transmission value
    %T_1550 = powerdB(find(lambda_nm == 1550));
    %fprintf('The power for %s at 1550nm is: %f.\n', name, T_1550);

    % Calculate ER
    % ER_TE = 10*log10(power_TE_dir./power_TE_adj);
    % ER_TM = 10*log10(power_TM_adj./power_TM_dir);

    ER_TE = powerdB_TE_dir-powerdB_TE_adj;
    ER_TM = powerdB_TM_adj-powerdB_TM_dir;

    figure
    plot(lambda_nm, ER_TE)
    hold on
    plot(lambda_nm, ER_TM)
    hold off
    yline(0,'LineWidth',2)
    xlabel('Wavelength (nm)')
    ylabel('Extinction Ratio (dB)')
    legend('TE', 'TM')
    title('Splitting Ratio')

end