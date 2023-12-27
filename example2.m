Mt = 2; % Number of transmit antennas
Mr = 1; % Number of receive antennas

C0 = [1 1; -1 1]; % ST signal C0
C1 = [-1 -1; 1 -1]; % ST signal C1

H = (randn(Mr,Mt) + 1i*randn(Mr,Mt))/sqrt(2);


Y = H*X;


N0 = norm(Y)^2/(Mr*Mt*10^(SNR_dB/10));


d_C0 = sum(abs(Y-(C0.*H)).^2)./N0;
d_C1 = sum(abs(Y-(C1.*H)).^2)./N0;
PEP = 0.5*erfc(sqrt(d_C0/2)) + 0.5*erfc(sqrt(d_C1/2));

for i = 1:length(SNR)
PEP_theory = qfunc(sqrt(10.^(SNR/10)));
end


semilogy(SNR, PEP_theory, 'r')
hold
semilogy(SNR, PEP, 'b');

xlabel('SNR (dB)');
ylabel('Error Probability');
legend('Theoretical PEP ', 'Simulation ');