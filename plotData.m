function plotData(PhCTE, PhCTM, W1TE, W1TM, name)
    WgLength = 3; % mm

    % import loss data
    if ~isfile('Per_Chip_Losses/lossesTE_silica1.dat')
        error('openMyFile:FileNotFound', ...
            'File does not exist: %s', PhCTE);
    end
    TELoss = importdata('Per_Chip_Losses/lossesTE_silica1.dat');
    WgLoss_TE = TELoss(:,2); % dB/mm
    WgLoss_TE = WgLoss_TE*WgLength; % dB
    InLoss_TE = TELoss(:,3); % dB

    if ~isfile('Per_Chip_Losses/lossesTM_silica1.dat')
        error('openMyFile:FileNotFound', ...
            'File does not exist: %s', PhCTE);
    end
    TMLoss = importdata('Per_Chip_Losses/lossesTM_silica1.dat');
    lambda_nm = TMLoss(:,1); % nm
    WgLoss_TM = TMLoss(:,2); % dB/mm
    WgLoss_TM = WgLoss_TM*WgLength; % dB
    InLoss_TM = TMLoss(:,3); % dB

    figure
    subplot(2,1,1) % waveguide loss for TE and TM
    plot(lambda_nm, WgLoss_TE)
    hold on
    plot(lambda_nm, WgLoss_TM)
    hold off
    legend('TE','TM')
    xlabel('Wavelength (nm)')
    ylabel('Loss (dB)')
    title('Waveguide Loss (for 3mm)')
    
    subplot(2,1,2) % insertion loss for TE and TM
    plot(lambda_nm, InLoss_TE)
    hold on
    plot(lambda_nm, InLoss_TM)
    hold off
    legend('TE','TM')
    xlabel('Wavelength (nm)')
    ylabel('Loss (dB)')
    title('Insertion Loss')

    if ~isfile(PhCTE)
        error('openMyFile:FileNotFound', ...
            'File does not exist: %s', PhCTE);
    end

    A = importdata(PhCTE);
    power_PhC_TE = A(:,2); % mW
    powerdB_PhC_TE = 10*log10(power_PhC_TE) - (-1) - WgLoss_TE - InLoss_TE; % dBm

    if ~isfile(PhCTM)
        error('openMyFile:FileNotFound', ...
            'File does not exist: %s', PhCTM);
    end

    B = importdata(PhCTM);
    power_PhC_TM = B(:,2); % mW
    powerdB_PhC_TM = 10*log10(power_PhC_TM) - (-1) - WgLoss_TM - InLoss_TM; % dBm
    
    if ~isfile(W1TE)
        error('openMyFile:FileNotFound', ...
            'File does not exist: %s', W1TE);
    end

    C = importdata(W1TE);
    power_W1_TE = C(:,2); % mW
    powerdB_W1_TE = 10*log10(power_W1_TE) - (-1) - WgLoss_TE - InLoss_TE; % dBm
    
    if ~isfile(W1TM)
        error('openMyFile:FileNotFound', ...
            'File does not exist: %s', W1TM);
    end

    D = importdata(W1TM);
    power_W1_TM = D(:,2); % mW
    powerdB_W1_TM = 10*log10(power_W1_TM) - (-1) - WgLoss_TM - InLoss_TM; % dBm

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