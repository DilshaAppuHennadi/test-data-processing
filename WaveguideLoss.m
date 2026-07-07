%% Waveguide Loss
%
% The purpose of this script is to plot the transmission of the waveguides
% on the chip. There are two copies of a set of three waveguides with
% lengths: 3mm, , . The ultimate goal of this is to determine the loss of the
% waveguides.

clear all
close all

%% 3mm Waveguide (shortest)

A = 'Khaled/bar1_loss_898um_TE.dat';
name = '3mm TE v1';
plotData(A, name)

B = 'Khaled/bar1_loss_898um_TM.dat';
name = '3mm TM v1';
plotData(B, name)

C = 'Khaled/bar1_2nd_loss_898um_TE.dat';
name = '3mm TE v2';
plotData(C, name)

D = 'Khaled/bar1_2nd_loss_898um_TM.dat';
name = '3mm TM v2';
plotData(D, name)


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