function calcER(TE_dir, TE_adj, TM_dir, TM_adj, lambda_nm, name)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    ER_TE = TE_dir-TE_adj;
    ER_TM = TM_adj-TM_dir;

    figure
    plot(lambda_nm, ER_TE, 'LineWidth', 2)
    hold on
    plot(lambda_nm, ER_TM, 'LineWidth', 2)
    hold off
    yline(0,'LineWidth',2)
    xlabel('Wavelength (nm)')
    ylabel('Extinction Ratio (dB)')
    legend('TE', 'TM')
    title(name)
    xlim([lambda_nm(1) lambda_nm(end)])
end