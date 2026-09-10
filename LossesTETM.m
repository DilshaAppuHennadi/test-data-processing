function [TE_wg,TE_in,TM_wg,TM_in,cutOff] = LossesTETM(Lwg, TElosses, TMlosses)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    WgLength = Lwg; % mm
    
    % import loss data
    TELoss = OpenDAT(TElosses);
    WgLoss_TE = TELoss(:,2); % dB/mm
    WgLoss_TE = WgLoss_TE*WgLength; % dB
    InLoss_TE = TELoss(:,3); % dB
    
    TMLoss = OpenDAT(TMlosses);
    lambda_nm = TMLoss(:,1); % nm
    WgLoss_TM = TMLoss(:,2); % dB/mm
    WgLoss_TM = WgLoss_TM*WgLength; % dB
    InLoss_TM = TMLoss(:,3); % dB

    % TMLoss = importdata('Per_Chip_Losses/lossesTM_silica1.dat');
    % lambda_nm = TMLoss(:,1); % nm
    % WgLoss_TM = TMLoss(:,2); % dB/mm
    % WgLoss_TM = WgLoss_TM*WgLength; % dB
    % InLoss_TM = TMLoss(:,3); % dB

    [TE_WG, TM_WG] = DataFit(WgLoss_TE, WgLoss_TM, lambda_nm, "Waveguide Loss");
    [TE_IN, TM_IN] = DataFit(InLoss_TE, InLoss_TM, lambda_nm, "Waveguide Loss");

    % Calculate W1 loss at 1550 nm-----------------------------------------
    lambda0 = 1525; % nm
    [~, idx] = min(abs(lambda_nm - lambda0));   % index of closest match

    TE_WG_lambda0 = TE_WG(idx);
    fprintf('TE waveguide loss at 1525 nm is %d dB\n', TE_WG_lambda0);

    TM_WG_lambda0 = TM_WG(idx);
    fprintf('TM waveguide loss at 1525 nm is %d dB\n', TM_WG_lambda0);

    TE_IN_lambda0 = TE_IN(idx);
    fprintf('TE insertion loss at 1525 nm is %d dB\n', TE_IN_lambda0);

    TM_IN_lambda0 = TM_IN(idx);
    fprintf('TM insertion loss at 1525 nm is %d dB\n', TM_IN_lambda0);

    % TM insertion loss going above 0dB, mark where this happens
    [~, ind] = min(abs(TM_IN - 0)); % locate index closest to 0dB

    figure
    subplot(2,1,1) % waveguide loss for TE and TM
    plot(lambda_nm, TE_WG, 'LineWidth', 2)
    hold on
    plot(lambda_nm, TM_WG, 'LineWidth', 2)
    hold off
    legend('TE','TM')
    xlabel('Wavelength (nm)')
    ylabel('Loss (dB)')
    title('Waveguide Loss')
    
    subplot(2,1,2) % insertion loss for TE and TM
    plot(lambda_nm, TE_IN, 'LineWidth', 2)
    hold on
    plot(lambda_nm, TM_IN, 'LineWidth', 2)
    hold off
    yline(0,'--','0dB','LineWidth',2, 'FontSize', 14)
    xline(lambda_nm(ind),'-',sprintf('Cut-off = %.0f nm', lambda_nm(ind)),'LineWidth',2, 'FontSize', 12)
    legend('TE','TM')
    xlabel('Wavelength (nm)')
    ylabel('Loss (dB)')
    title('Coupling Loss')

    TE_wg = TE_WG;
    TE_in = TE_IN;
    TM_wg = TM_WG;
    TM_in = TM_IN;
    cutOff = ind;
end