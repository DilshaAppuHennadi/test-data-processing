function plotData(PhCTE, PhCTM, W1TE, W1TM, name)

    if ~isfile(PhCTE)
        error('openMyFile:FileNotFound', ...
            'File does not exist: %s', PhCTE);
    end

    A = importdata(PhCTE);
    power_PhC_TE = A(:,2); % mW
    powerdB_PhC_TE = 10*log10(power_PhC_TE); % dBm

    if ~isfile(PhCTM)
        error('openMyFile:FileNotFound', ...
            'File does not exist: %s', PhCTM);
    end

    B = importdata(PhCTM);
    power_PhC_TM = B(:,2); % mW
    powerdB_PhC_TM = 10*log10(power_PhC_TM); % dBm
    
    if ~isfile(W1TE)
        error('openMyFile:FileNotFound', ...
            'File does not exist: %s', W1TE);
    end

    C = importdata(W1TE);
    power_W1_TE = C(:,2); % mW
    powerdB_W1_TE = 10*log10(power_W1_TE); % dBm
    
    if ~isfile(W1TM)
        error('openMyFile:FileNotFound', ...
            'File does not exist: %s', W1TM);
    end

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