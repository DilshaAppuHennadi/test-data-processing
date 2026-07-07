%% PBS
%
% The purpose of this script is to study the behaviour of the PBS devices.
% This includes the transmission of the devices - do TE and TM get split?
% We check the transmission of the devices at 1550nm and determine the
% extinction ratio for TE and TM.

clear all
close all

TEdir = 'Khaled/PBS_A400NM_R98NM_N25/PBS_A400NM_R98NM_N25_0_TE_DIR.dat';
TEadj = 'Khaled/PBS_A400NM_R98NM_N25/PBS_A400NM_R98NM_N25_0_TE_ADJ.dat';
TMdir = 'Khaled/PBS_A400NM_R98NM_N25/PBS_A400NM_R98NM_N25_0_TM_DIR.dat';
TMadj = 'Khaled/PBS_A400NM_R98NM_N25/PBS_A400NM_R98NM_N25_0_TM_ADJ.dat';
name = 'PBS (a=400nm, r=98nm, n_x=25)';
plotData(TEdir, TEadj, TMdir, TMadj, name)

function plotData(TEd, TEa, TMd, TMa, name)
    A = importdata(TEd);
    lambda_nm = A(:,1);
    power_TE_dir = A(:,2); % mW
    powerdB_TE_dir = 10*log10(power_TE_dir); % dBm

    B = importdata(TEa);
    lambda_nm = B(:,1);
    power_TE_adj = B(:,2); % mW
    powerdB_TE_adj = 10*log10(power_TE_adj); % dBm

    C = importdata(TMd);
    lambda_nm = C(:,1);
    power_TM_dir = C(:,2); % mW
    powerdB_TM_dir = 10*log10(power_TM_dir); % dBm

    D = importdata(TMa);
    lambda_nm = D(:,1);
    power_TM_adj = D(:,2); % mW
    powerdB_TM_adj = 10*log10(power_TM_adj); % dBm

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
    % ER(TE) = 10*log10(TE_dir/TE_adj)
    % ER(TM) = 10*log10(TM_adj/TM_dir)

    ER_TE = 10*log10(power_TE_dir./power_TE_adj);
    ER_TM = 10*log10(power_TM_adj./power_TM_dir);

    figure
    plot(lambda_nm, ER_TE)
    hold on
    plot(lambda_nm, ER_TM)
    hold off
    xlabel('Wavelength (nm)')
    ylabel('Extinction Ratio (dB)')
    legend('TE', 'TM')
    title('Splitting Ratio')

end