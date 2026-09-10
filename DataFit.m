function [outTE, outTM] = DataFit(TE_dBm, TM_dBm, lambda_nm, name)
%DataFit Take a moving average of the measured data
%   The data set of measured power is very noisy to work with. As an
%   alternative, we take a moving average of the entire data set to smooth
%   it out. To do this we use the movmean() function which takes a centered
%   average for each wavelength. In doing so, the smoothed data set will
%   contain the same number of points as the original data set.

    windowSize = 250; % number of points in the moving window
    TE_smoothed = movmean(TE_dBm, windowSize);
    % figure
    % plot(lambda_nm, TE_dBm)
    % hold on
    % plot(lambda_nm, TE_smoothed, 'r-', 'LineWidth', 2)
    % hold off
    % xlabel('Wavelength (nm)')
    % ylabel('Power (dBm)')
    % legend('Raw Data', 'Moving Average')
    % title(strcat(name, ' TE'))

    TM_smoothed = movmean(TM_dBm, windowSize);
    % figure
    % plot(lambda_nm, TM_dBm)
    % hold on
    % plot(lambda_nm, TM_smoothed, 'r-', 'LineWidth', 2)
    % hold off
    % xlabel('Wavelength (nm)')
    % ylabel('Power (dBm)')
    % legend('Raw Data', 'Moving Average')
    % title(strcat(name, ' TM'))

    outTE = TE_smoothed;
    outTM = TM_smoothed;
end