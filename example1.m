N = 34 ; %M  = (N-2)/4;
M = 8 ; % Oscillators
fD_max = 50 ; % 50hz calculated from previously
fD_maxTs = 0.0017 ; % fd_max * Ts = 0.0017 
k = 200; % sampling numbers
term = 2 * pi * fD_maxTs; 

eBn_real = zeros(k,1);
eBn_img = zeros(k,1);
t = 0:(k-1); % here t is written as k * Ts for sampling

for n = 1:M
thetan = 2 * pi * n/2;
Bn = n * pi /(M+1);  %M+1 ;  M boundary point

Bn_real = 2*cos(Bn);
Bn_imag = 2*sin(Bn);

alphan = term*cos(thetan);

eBn_real = eBn_real + Bn_real.* cos(alphan*t);
eBn_img = eBn_img + Bn_imag.* cos(alphan*t) ;
end

ht = eBn_real + 1i.*eBn_img ; 

% Normalization 

for kn = 1 : k
hn = ht(kn)*ht(kn); % calculation of average power
end
hn = hn / k;
for kn =1 : k
ht(kn) = ht(kn) / sqrt(hn); %normalizing each term
end

% figure;

ht_db = 10*log10(abs(ht)) ; % for db

plot(t,ht_db);
grid on;
ylabel('h|t| channel Amplitude (dB)');
xlabel('Samples');
legend('fdTmax = 0.1')

N=1000000;

%Random uniform variables 
U=rand(N,1);

%Rayleight random variable using an inverse transform sampling
sigma=1;
x1=sigma*sqrt(-2*log(1-U));

histogram(x1,'Normalization','pdf');



% Theoretical equation
x=linspace(0,1,50);
pdf=2*x.*exp((-x.^2));
% Plot
hold on
plot(x,pdf)
legend('Stochastic','Theoretical')