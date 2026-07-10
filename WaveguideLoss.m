%% Waveguide Loss
%
% The purpose of this script is to plot the transmission of the waveguides
% on the chip. There are two copies of a set of three waveguides with
% lengths: 3mm, , . The ultimate goal of this is to determine the loss of the
% waveguides.

clear all
close all
clc

% Set loss variables for TE and TM. The first column contains the lengths
% of the three different wire waveguides (in mm). The second column is
% initialized to zero (0) and eventually overwritten with the transmission
% measured for each waveguide at 1550 nm (in dBm). The loss of the
% measurement system (everything external to the chip) was reported to be
% 1dB. The transmission values used to calculate waveguide loss will be
% compensated for system loss.

%loss_TE = [3 0;9 0;21 0];
%loss_TM = [3 0;9 0;21 0];

%% 3mm Waveguide (shortest)

% A = 'Jul_03_2026/WGs/short_1_890um/LOSS_SHORT_1_TE.dat';
% A = 'Jul_03_2026/SECOND_SILICA_CHIP/LOSS_SHORT_1_TE.dat';
A = 'Jul_03_2026/AIR/LOSS_SHORT_1_TE.dat';
name = 'SHORT TE';
compPow_short_TE = plotData(A, name);

% B = 'Jul_03_2026/WGs/short_1_890um/LOSS_SHORT_1_TM.dat';
% B = 'Jul_03_2026/SECOND_SILICA_CHIP/LOSS_SHORT_1_TM.dat';
B = 'Jul_03_2026/AIR/LOSS_SHORT_1_TM.dat';
name = 'SHORT TM';
compPow_short_TM = plotData(B, name);

%% 3mm Waveguide (medium)

% C = 'Jul_03_2026/WGs/med_1_2776um/LOSS_MED_1_TE.dat';
% C = 'Jul_03_2026/SECOND_SILICA_CHIP/LOSS_MED_1_TE.dat';
C = 'Jul_03_2026/AIR/LOSS_MED_1_TE.dat';
name = 'MED TE';
compPow_med_TE = plotData(C, name);

% D = 'Jul_03_2026/WGs/med_1_2776um/LOSS_MED_1_TM.dat';
% D = 'Jul_03_2026/SECOND_SILICA_CHIP/LOSS_MED_1_TM.dat';
D = 'Jul_03_2026/AIR/LOSS_MED_1_TM.dat';
name = 'MED TM';
compPow_med_TM = plotData(D, name);

%% 3mm Waveguide (longest)

% E = 'Jul_03_2026/WGs/long_1_6499um/LOSS_LONG_1_TE.dat';
% E = 'Jul_03_2026/SECOND_SILICA_CHIP/LOSS_LONG_1_TE.dat';
E = 'Jul_03_2026/AIR/LOSS_LONG_1_TE.dat';
name = 'LONG TE';
compPow_long_TE = plotData(E, name);

% F = 'Jul_03_2026/WGs/long_1_6499um/LOSS_LONG_1_TM.dat';
F = 'Jul_03_2026/SECOND_SILICA_CHIP/LOSS_LONG_1_TM.dat';
% F = 'Jul_03_2026/AIR/LOSS_LONG_1_TM.dat';
name = 'LONG TM';
[compPow_long_TM, lambda_nm] = plotData(F, name);

%% Plot Transmission by waveguide length
% We perform a polyfit() of the loss data for the three waveguides at
% 1550nm. The polyfit() function is set to n=1 to obtain a linear fit. In
% this case p_1 is the slope which will be in units of dBm/mm - this is
% considered to be the waveguide loss. The y-intercept is the theoretical
% loss at waveguide length = 0mm. This is used to represent the loss
% resulting from coupling in about out of the chips via the edge couplers -
% labelled as "insertion loss".

[lossesTE, lossesTM] = loss(lambda_nm, compPow_short_TE, compPow_short_TM, compPow_med_TE, compPow_med_TM, compPow_long_TE, compPow_long_TM);

figure
subplot(2,1,1) % waveguide loss for TE and TM
plot(lambda_nm, lossesTE(:,1))
hold on
plot(lambda_nm, lossesTM(:,1))
hold off
legend('TE','TM')
xlabel('Wavelength (nm)')
ylabel('Loss (dB/mm)')
title('Waveguide Loss')

subplot(2,1,2) % insertion loss for TE and TM
plot(lambda_nm, lossesTE(:,2))
hold on
plot(lambda_nm, lossesTM(:,2))
hold off
legend('TE','TM')
xlabel('Wavelength (nm)')
ylabel('Loss (dBm)')
title('Insertion Loss')

outputTE = [lambda_nm, lossesTE];
outputTM = [lambda_nm, lossesTM];

writematrix(outputTE, 'lossesTE_air.dat');
writematrix(outputTM, 'lossesTM_air.dat');

% p_TE = polyfit(loss_TE(:,1), loss_TE(:,2),1);
% p_TM = polyfit(loss_TM(:,1), loss_TM(:,2),1);
% 
% dummy_lengths = linspace(0,25,25); %mm
% lin_fit_TE = polyval(p_TE, dummy_lengths);
% lin_fit_TM = polyval(p_TM, dummy_lengths);

% subplot(2,1,1);
% plot(loss_TE(:,1), loss_TE(:,2),'o')
% hold on
% plot(dummy_lengths,lin_fit_TE)
% hold off
% legend('Measured','Fitted')
% xlabel('Waveguide length (mm)')
% ylabel('Power (dBm)')
% title('TE')
% 
% subplot(2,1,2);
% plot(loss_TM(:,1), loss_TM(:,2),'o')
% hold on
% plot(dummy_lengths,lin_fit_TM)
% hold off
% legend('Measured','Fitted')
% xlabel('Waveguide length (mm)')
% ylabel('Power (dBm)')
% title('TM')
% 
% sgtitle('Transmission (1550nm) variation with waveguide length')
% 
% fprintf('Waveguide loss for TE is: %f dBm/mm.\n', p_TE(1));
% fprintf('Waveguide loss for TM is: %f dBm/mm.\n', p_TM(1));
% fprintf('Insertion loss of both edge couplers for TE is: %f dBm.\n', p_TE(2));
% fprintf('Insertion loss of both edge couplers for TM is: %f dBm.\n', p_TM(2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [compPowdBm, wavelengths] = plotData(filename, name)
    A = importdata(filename);
    lambda_nm = A(:,1);
    power = A(:,2); % mW
    powerdB = 10*log10(power); % dBm
    powerdB_comp = powerdB - (-1); % dBm - dB = dBm

    % Plot wavelength sweep in dBm
    figure
    subplot(2,1,1);
    plot(lambda_nm, powerdB)
    xlabel('Wavelength (nm)')
    ylabel('Measured Power (dBm)')
    title(name)

    subplot(2,1,2);
    plot(lambda_nm, powerdB_comp)
    xlabel('Wavelength (nm)')
    ylabel('Measured Power (dBm)')
    title(strcat(name, ' with system loss compensation'))

    % Pull transmission at 1550nm
    % later version of script: return this transmission value
    T_1550 = powerdB(find(lambda_nm == 1550));
    fprintf('The power for %s at 1550nm is: %f.\n', name, T_1550);
    T_1550_comp = powerdB_comp(find(lambda_nm == 1550));
    fprintf('Compensating system loss, the power for %s at 1550nm is: %f.\n', name, T_1550_comp);

    % return power (dBm) with system loss compensation
    compPowdBm = powerdB_comp;
    % only return wavelength vector if called by user
    if nargout > 1
        wavelengths = lambda_nm;
    end
end

function [lossTE, lossTM] = loss(wavelengths, sTE, sTM, mTE, mTM, lTE, lTM)

    dummyLossTE = zeros(length(wavelengths),2);
    dummyLossTM = zeros(length(wavelengths),2);

    x = [3;9;21]; % short, med, long waveguide lengths (mm)

    for ind = 1:length(wavelengths)
        yTE = [sTE(ind);mTE(ind);lTE(ind)];
        yTM = [sTM(ind);mTM(ind);lTM(ind)];

        pTE = polyfit(x, yTE, 1);
        pTM = polyfit(x, yTM, 1);

        dummyLossTE(ind,:) = pTE;
        dummyLossTM(ind,:) = pTM;

        if ind == 10990 % check lin fit at wavelength specified by index
            dummy_lengths = linspace(0,25,25); %mm
            lin_fit_TE = polyval(pTE, dummy_lengths);
            lin_fit_TM = polyval(pTM, dummy_lengths);

            figure
            subplot(2,1,1);
            plot(x, yTE,'o')
            hold on
            plot(dummy_lengths,lin_fit_TE)
            hold off
            legend('Measured','Fitted')
            xlabel('Waveguide length (mm)')
            ylabel('Power (dBm)')
            title('TE')
            
            subplot(2,1,2);
            plot(x, yTM,'o')
            hold on
            plot(dummy_lengths,lin_fit_TM)
            hold off
            legend('Measured','Fitted')
            xlabel('Waveguide length (mm)')
            ylabel('Power (dBm)')
            title('TM')
        end
    end

    lossTE = dummyLossTE;
    lossTM = dummyLossTM;

end