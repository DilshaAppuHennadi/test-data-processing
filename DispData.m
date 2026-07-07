A = importdata('Khaled/bar1_2nd_loss_898um_TE.dat');
lambda_nm = A(:,1);
power = A(:,2);

figure
plot(lambda_nm, power)
xlabel('Wavelength (nm)')
ylabel('Measured Power (mW)')