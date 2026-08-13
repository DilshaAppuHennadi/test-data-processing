function [TE_wg,TE_in,TM_wg,TM_in] = LossesTETM(Lwg)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    WgLength = Lwg; % mm
    
    % import loss data
    if ~isfile('Per_Chip_Losses/lossesTE_silica1.dat')
        error('openMyFile:FileNotFound', ...
            'File does not exist: %s', 'Per_Chip_Losses/lossesTE_silica1.dat');
    end
    TELoss = importdata('Per_Chip_Losses/lossesTE_silica1.dat');
    WgLoss_TE = TELoss(:,2); % dB/mm
    WgLoss_TE = WgLoss_TE*WgLength; % dB
    InLoss_TE = TELoss(:,3); % dB
    
    if ~isfile('Per_Chip_Losses/lossesTM_silica1.dat')
        error('openMyFile:FileNotFound', ...
            'File does not exist: %s', 'Per_Chip_Losses/lossesTM_silica1.dat');
    end
    TMLoss = importdata('Per_Chip_Losses/lossesTM_silica1.dat');
    lambda_nm = TMLoss(:,1); % nm
    WgLoss_TM = TMLoss(:,2); % dB/mm
    WgLoss_TM = WgLoss_TM*WgLength; % dB
    InLoss_TM = TMLoss(:,3); % dB

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
    title('Waveguide Loss')
    
    subplot(2,1,2) % insertion loss for TE and TM
    plot(lambda_nm, InLoss_TE)
    hold on
    plot(lambda_nm, InLoss_TM)
    hold off
    legend('TE','TM')
    xlabel('Wavelength (nm)')
    ylabel('Loss (dB)')
    title('Insertion Loss')

    TE_wg = WgLoss_TE;
    TE_in = InLoss_TE;
    TM_wg = WgLoss_TM;
    TM_in = InLoss_TM;
end