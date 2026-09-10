function plotPBSData(sysLoss,TE_wg,TE_in,TM_wg,TM_in, TEd, TEa, TMd, TMa, name, TE_W1, TM_W1)

    % Load PBS data files--------------------------------------------------
    lambda_nm = TEd(:,1);
    power_TE_dir = TEd(:,2); % mW
    powerdB_TE_dir = 10*log10(power_TE_dir) + sysLoss(:,2) - TE_wg - TE_in; % dBm

    lambda_nm = TEa(:,1);
    power_TE_adj = TEa(:,2); % mW
    powerdB_TE_adj = 10*log10(power_TE_adj) + sysLoss(:,2) - TE_wg - TE_in; % dBm

    lambda_nm = TMd(:,1);
    power_TM_dir = TMd(:,2); % mW
    powerdB_TM_dir = 10*log10(power_TM_dir) - (-1) - TM_wg - TM_in; % dBm

    lambda_nm = TMa(:,1);
    power_TM_adj = TMa(:,2); % mW
    powerdB_TM_adj = 10*log10(power_TM_adj) - (-1) - TM_wg - TM_in; % dBm

    % Curve fit for data---------------------------------------------------
    [fitTE_dir, fitTM_dir] = DataFit(powerdB_TE_dir, powerdB_TM_dir, lambda_nm, strcat(name, ' direct'));
    [fitTE_adj, fitTM_adj] = DataFit(powerdB_TE_adj, powerdB_TM_adj, lambda_nm, strcat(name, ' adjacent'));

    % Plot wavelength sweep in dBm-----------------------------------------
    % figure
    % plot(lambda_nm, powerdB_TE_dir)
    % hold on
    % plot(lambda_nm, powerdB_TE_adj)
    % plot(lambda_nm, powerdB_TM_dir)
    % plot(lambda_nm, powerdB_TM_adj)
    % hold off
    % xlabel('Wavelength (nm)')
    % ylabel('Measured Power (dBm)')
    % legend('TE DIR','TE ADJ','TM DIR','TM ADJ')
    % title(strcat('PBS Transmission (', name,')'))
    % xlim([lambda_nm(1) lambda_nm(end)])

    figure
    plot(lambda_nm, fitTE_dir, 'LineWidth', 2)
    hold on
    plot(lambda_nm, fitTE_adj, 'LineWidth', 2)
    plot(lambda_nm, fitTM_dir, 'LineWidth', 2)
    plot(lambda_nm, fitTM_adj, 'LineWidth', 2)
    hold off
    xlabel('Wavelength (nm)')
    ylabel('Power (dBm)')
    legend('TE DIR','TE ADJ','TM DIR','TM ADJ')
    title(strcat('PBS Transmission (', name,')'))
    xlim([lambda_nm(1) lambda_nm(end)])

    % W1 Compensation------------------------------------------------------
    
    pass_edge = 1540; %nm (edge of the W1 pass band)

    % locate index of the pass band edge wavelength
    [~, idx] = min(abs(lambda_nm - pass_edge));

    TE_dir_comp = powerdB_TE_dir(1:idx) - TE_W1(1:idx);
    TE_adj_comp = powerdB_TE_adj(1:idx) - TE_W1(1:idx);
    TM_dir_comp = powerdB_TM_dir(1:idx) - TM_W1(1:idx);
    TM_adj_comp = powerdB_TM_adj(1:idx) - TM_W1(1:idx);

    % Apply moving average
    [fitTE_dir_comp, fitTM_dir_comp] = DataFit(TE_dir_comp, TM_dir_comp, lambda_nm(1:idx), strcat(name, ' direct - W1 compensated'));
    [fitTE_adj_comp, fitTM_adj_comp] = DataFit(TE_adj_comp, TM_adj_comp, lambda_nm(1:idx), strcat(name, ' adjacent - W1 compensated'));

    % figure
    % plot(lambda_nm(1:idx), TE_dir_comp)
    % hold on
    % plot(lambda_nm(1:idx), TE_adj_comp)
    % plot(lambda_nm(1:idx), TM_dir_comp)
    % plot(lambda_nm(1:idx), TM_adj_comp)
    % hold off
    % xlabel('Wavelength (nm)')
    % ylabel('Measured Power (dBm)')
    % legend('TE DIR','TE ADJ','TM DIR','TM ADJ')
    % title(strcat('PBS Transmission (', name,') with W1 compensation'))
    % xlim([lambda_nm(1) lambda_nm(idx)])

    figure
    plot(lambda_nm(1:idx), fitTE_dir_comp, 'LineWidth', 2)
    hold on
    plot(lambda_nm(1:idx), fitTE_adj_comp, 'LineWidth', 2)
    plot(lambda_nm(1:idx), fitTM_dir_comp, 'LineWidth', 2)
    plot(lambda_nm(1:idx), fitTM_adj_comp, 'LineWidth', 2)
    hold off
    xlabel('Wavelength (nm)')
    ylabel('Power (dBm)')
    legend('TE DIR','TE ADJ','TM DIR','TM ADJ')
    title(strcat('PBS Transmission (', name,') with W1 compensation'))
    xlim([lambda_nm(1) lambda_nm(idx)])

    lambda0 = 1525; % nm
    [~, ind] = min(abs(lambda_nm - lambda0));   % index of closest match

    TE_dir_lambda0 = powerdB_TE_dir(ind);
    fprintf('TE insertion loss at 1525 nm is %d dB\n', TE_dir_lambda0);

    TM_adj_lambda0 = powerdB_TM_adj(ind);
    fprintf('TM insertion loss at 1525 nm is %d dB\n', TM_adj_lambda0);

    % ER Calculation and Plotting------------------------------------------

    calcER(powerdB_TE_dir, powerdB_TE_adj, powerdB_TM_dir, powerdB_TM_adj, lambda_nm, 'Splitting Ratio - Raw Data')

    calcER(fitTE_dir, fitTE_adj, fitTM_dir, fitTM_adj, lambda_nm, 'Splitting Ratio - Fitted Data')

    calcER(fitTE_dir_comp, fitTE_adj_comp, fitTM_dir_comp, fitTM_adj_comp, lambda_nm(1:idx), 'Splitting Ratio - Fitted Data with W1 Compensation')

    % Compare to Simulations-----------------------------------------------

    sim_TE_dir = readmatrix('W:\dilshaappuhennadi\Thesis\test-data-processing\Simulation_Data\a390_r90\TE_dir');
    sim_TE_adj = readmatrix("W:\dilshaappuhennadi\Thesis\test-data-processing\Simulation_Data\a390_r90\TE_adj");
    sim_TM_dir = readmatrix("W:\dilshaappuhennadi\Thesis\test-data-processing\Simulation_Data\a390_r90\TM_dir");
    sim_TM_adj = readmatrix("W:\dilshaappuhennadi\Thesis\test-data-processing\Simulation_Data\a390_r90\TM_adj");
    sim_lambda = readmatrix("Simulation_Data\sim_lambda_nm.txt");

    sim_TE_dir = 10*log10(sim_TE_dir(:,2));
    sim_TE_adj = 10*log10(sim_TE_adj(:,2));
    sim_TM_dir = 10*log10(sim_TM_dir(:,2));
    sim_TM_adj = 10*log10(sim_TM_adj(:,2));
    
    % figure
    % subplot(2,1,1)
    % hold on
    % plot(lambda_nm, powerdB_TE_dir)
    % plot(lambda_nm, powerdB_TE_adj)
    % plot(sim_lambda, sim_TE_dir, 'LineWidth', 2)
    % plot(sim_lambda, sim_TE_adj, 'LineWidth', 2)
    % hold off
    % xlabel('Wavelength (nm)')
    % ylabel('Measured Power (mdB)')
    % legend('TE DIR (meas.)','TE ADJ (meas.)','TE DIR (sim.)','TE ADJ (sim.)')
    % title('Comparison of TE Transmission')
    % xlim([lambda_nm(1) lambda_nm(end)])
    % 
    % subplot(2,1,2)
    % hold on
    % plot(lambda_nm, powerdB_TM_dir)
    % plot(lambda_nm, powerdB_TM_adj)
    % plot(sim_lambda, sim_TM_dir, 'LineWidth', 2)
    % plot(sim_lambda, sim_TM_adj, 'LineWidth', 2)    
    % hold off
    % xlabel('Wavelength (nm)')
    % ylabel('Measured Power (mdB)')
    % legend('TM DIR (meas.)','TM ADJ (meas.)','TM DIR (sim.)','TM ADJ (sim.)')
    % title('Comparison of TM Transmission')
    % xlim([lambda_nm(1) lambda_nm(end)])

    figure
    subplot(2,1,1)
    hold on
    plot(lambda_nm, fitTE_dir, 'LineWidth', 2,'Color',[0 0.4470 0.7410])
    plot(lambda_nm, fitTE_adj, 'LineWidth', 2,'Color',[0.8500 0.3250 0.0980])
    plot(sim_lambda, sim_TE_dir, '--', 'LineWidth', 2,'Color',[0 0.4470 0.7410])
    plot(sim_lambda, sim_TE_adj, '--', 'LineWidth', 2,'Color',[0.8500 0.3250 0.0980])
    hold off
    xlabel('Wavelength (nm)')
    ylabel('Measured Power (dBm)')
    legend('TE DIR (meas.)','TE ADJ (meas.)','TE DIR (sim.)','TE ADJ (sim.)')
    title('Comparison of TE Transmission')
    xlim([lambda_nm(1) lambda_nm(end)])

    subplot(2,1,2)
    hold on
    plot(lambda_nm, fitTM_dir, 'LineWidth', 2,'Color',[0 0.4470 0.7410])
    plot(lambda_nm, fitTM_adj, 'LineWidth', 2,'Color',[0.8500 0.3250 0.0980])
    plot(sim_lambda, sim_TM_dir, '--', 'LineWidth', 2,'Color',[0 0.4470 0.7410])
    plot(sim_lambda, sim_TM_adj, '--', 'LineWidth', 2,'Color',[0.8500 0.3250 0.0980])    
    hold off
    xlabel('Wavelength (nm)')
    ylabel('Measured Power (dBm)')
    legend('TM DIR (meas.)','TM ADJ (meas.)','TM DIR (sim.)','TM ADJ (sim.)')
    title('Comparison of TM Transmission')
    xlim([lambda_nm(1) lambda_nm(end)])

    plotERComp(fitTE_dir,fitTE_adj,fitTM_dir,fitTM_adj,sim_TE_dir,sim_TE_adj,sim_TM_dir,sim_TM_adj,TE_wg,TE_in,TM_wg,TM_in,lambda_nm, sim_lambda, strcat('ER Comparison (', name,')'))

end

function plotERComp(TE_dir_m, TE_adj_m, TM_dir_m, TM_adj_m, TE_dir_s, ...
    TE_adj_s, TM_dir_s, TM_adj_s, TE_wg, TE_in, TM_wg, TM_in, lambda_nm, ...
    lambda_sim, name)

    ER_TE_m = TE_dir_m-TE_adj_m;
    ER_TM_m = TM_adj_m-TM_dir_m;

    ER_TE_s = TE_dir_s-TE_adj_s;
    ER_TM_s = TM_adj_s-TM_dir_s;

    lambda0 = 1525; % nm
    [~, idx] = min(abs(lambda_nm - lambda0));   % index of closest match

    ER_TE_lambda0 = ER_TE_m(idx);
    fprintf('TE ER at 1525 nm is %d dB\n', ER_TE_lambda0);

    ER_TM_lambda0 = ER_TM_m(idx);
    fprintf('TM ER at 1525 nm is %d dB\n', ER_TM_lambda0);

    figure
    hold on
    plot(lambda_nm, ER_TE_m, 'LineWidth', 2,'Color',[0 0.4470 0.7410])
    plot(lambda_nm, ER_TM_m, 'LineWidth', 2,'Color',[0.8500 0.3250 0.0980])
    plot(lambda_sim, ER_TE_s, '--', 'LineWidth', 2,'Color',[0 0.4470 0.7410])
    plot(lambda_sim, ER_TM_s, '--', 'LineWidth', 2,'Color',[0.8500 0.3250 0.0980])
    hold off
    yline(0,'LineWidth',2)
    xlabel('Wavelength (nm)')
    ylabel('Extinction Ratio (dB)')
    legend('TE (meas.)', 'TM (meas.)', 'TE (sim.)', 'TM (sim.)')
    title(name)
    xlim([lambda_nm(1) lambda_nm(end)])

    figure
    hold on
    plot(lambda_nm, ER_TE_m,  'LineWidth', 2)
    % plot(lambda_nm, TE_wg, 'LineWidth', 2)
    plot(lambda_nm, TE_in, 'LineWidth', 2)
    hold off
    yline(0,'LineWidth',2)
    xlabel('Wavelength (nm)')
    ylabel('dB')
    legend('ER', 'IL')
    title("TE Performance")
    xlim([lambda_nm(1) lambda_nm(end)])

    figure
    hold on
    plot(lambda_nm, ER_TM_m, 'LineWidth', 2)
    % plot(lambda_nm, TM_wg, 'LineWidth', 2)
    plot(lambda_nm, TM_in, 'LineWidth', 2)
    hold off
    yline(0,'LineWidth',2)
    xlabel('Wavelength (nm)')
    ylabel('dB')
    legend('ER', 'IL')
    title("TM Performance")
    xlim([lambda_nm(1) lambda_nm(end)])

    fab = readtable("fab_sim.xlsx");

    figure
    hold on
    plot(lambda_nm, ER_TE_m, 'LineWidth', 2,'Color',[0 0.4470 0.7410])
    plot(lambda_nm, ER_TM_m, 'LineWidth', 2,'Color',[0.8500 0.3250 0.0980])
    plot(fab.nm, fab.ER_TE, '--', 'LineWidth', 2,'Color',[0 0.4470 0.7410])
    plot(fab.nm, fab.ER_TM, '--', 'LineWidth', 2,'Color',[0.8500 0.3250 0.0980])
    hold off
    yline(0,'LineWidth',2)
    xlabel('Wavelength (nm)')
    ylabel('Extinction Ratio (dB)')
    legend('TE (meas.)', 'TM (meas.)', 'TE (sim.)', 'TM (sim.)')
    title("Measurement comparison to updated simulation (a = 385 nm, r = 93 nm)")
    xlim([lambda_nm(1) lambda_nm(end)])
end