function SEP = SEP1( SNR )
%BEPSEP Summary of this function goes here
%   Detailed explanation goes here
k=3;
SNR_DB=-5:0.01:SNR;
snr= 10.^(SNR_DB/10); %lineaización
argum=sqrt(snr)*sin(pi/8);
Pes= erfc(argum);
Peb=Pes/k;

semilogy(SNR_DB,Peb,'-r');
xlabel('Ys');
ylabel('Probabilidad de Error de Simbolo');
legend('Probabilidad de Error de Simbolo'); %,'Probabilidad de Error de Bit')
grid on;

end