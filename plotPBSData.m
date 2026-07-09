function plotPBSData(TEd, TEa, TMd, TMa, name)

    if ~isfile(TEd)
        error('openMyFile:FileNotFound', ...
            'File does not exist: %s', TEd);
    end

    A = importdata(TEd);
    lambda_nm = A(:,1);
    power_TE_dir = A(:,2); % mW
    powerdB_TE_dir = 10*log10(power_TE_dir) - (-1); % dBm

    if ~isfile(TEa)
        error('openMyFile:FileNotFound', ...
            'File does not exist: %s', TEa);
    end

    B = importdata(TEa);
    lambda_nm = B(:,1);
    power_TE_adj = B(:,2); % mW
    powerdB_TE_adj = 10*log10(power_TE_adj) - (-1); % dBm

    if ~isfile(TMd)
        error('openMyFile:FileNotFound', ...
            'File does not exist: %s', TMd);
    end

    C = importdata(TMd);
    lambda_nm = C(:,1);
    power_TM_dir = C(:,2); % mW
    powerdB_TM_dir = 10*log10(power_TM_dir) - (-1); % dBm

    if ~isfile(TMa)
        error('openMyFile:FileNotFound', ...
            'File does not exist: %s', TMa);
    end

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
    title(strcat('PBS Transmission (', name,')'))

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