% Generate random sequence of QPSK symbols
N = 100000;
x = sign(randn(1, N)) + 1j*sign(randn(1, N));

% Transmit symbols over one antenna
y = x;

% Initialize SNR range and BER vector
SNR_dB = -10:2:20;
BER = zeros(size(SNR_dB));

% Loop over SNR range
for i = 1:length(SNR_dB)
    % Compute noise variance from SNR
    SNR = 10^(SNR_dB(i)/10);
    noise_var = 0.5/SNR;
    
    % Add noise to received signal
    noise = sqrt(noise_var)*(randn(size(y)) + 1j*randn(size(y)));
    y_noisy = y + noise;
    
    % Decode received signal using maximum likelihood decoding
    x_decoded = sign(real(y_noisy)) + 1j*sign(imag(y_noisy));
    
    % Compute bit errors and BER
    errors = sum(x ~= x_decoded);
    BER(i) = errors/length(x);
end

% Plot BER vs SNR for both systems
semilogy(SNR_dB, BER, '-o');
hold on;
semilogy(SNR_dB, ber_alamouti(SNR_dB), '-o');
xlabel('SNR (dB)');
ylabel('BER');
title('BER vs SNR for MIMO systems');
legend('Single antenna', 'MIMO with Alamouti scheme');







function ber = ber_alamouti(SNR_dB)
% Generate random sequence of QPSK symbols
N = 100000;
x = sign(randn(1, 2*N)) + 1j*sign(randn(1, 2*N));

% Group symbols into pairs
x_pairs = reshape(x, 2, []);

% Apply Alamouti code to each pair of symbols
G = [1 1; -1j 1j];
x_encoded = G*x_pairs;

% Transmit encoded symbols over two antennas
y = x_encoded(:);

% Initialize BER vector
ber = zeros(size(SNR_dB));

% Loop over SNR range
for i = 1:length(SNR_dB)
    % Compute noise variance from SNR
    SNR = 10^(SNR_dB(i)/10);
    noise_var = 0.5/SNR;
    
    % Add noise to received signal
    noise = sqrt(noise_var)*(randn(size(y)) + 1j*randn(size(y)));
    y_noisy = y + noise;
    
    % Decode received signal using Alamouti decoding algorithm
    y_pairs = reshape(y_noisy, 2, []);
    H = [1 -1j; 1j 1];
    y_decoded = H*y_pairs;
    
    % Compute bit errors and BER
    x_decoded = y_decoded(:);
    errors = sum(x ~= x_decoded);
    ber(i) = errors/length(x);
end
snr=[0:10];
semilogy(snr,ber,'--*');
end