%Santiago de cali, 26 de mayo de 2017
%Universidad Icesi.
%--------------------------------------------------------------------------------------------------------------
%PROYECTO FINAL DE COMUNICACIONES DIGITALES.
%TEMA: Simulación de un SCD.
%Presenta: William Martín Chávez González, Código: A00242064
%Presenta: Juan Camilo Swan, Código:A00054620.
%Presenta: Tomás Lemus, Código: A00054616.
%--------------------------------------------------------------------------------------------------------------
%%
%-------------------------------------------------------
%-------------------------------------------------------
%PROBABILIDAD DE ERROR DE BIT Y DE SÍMBOLO VS SNR:
tx = codigoConvolucional;        %código convolucional (ristra de bits) que entra al modulador 8-PSK.
pskSig = step(modulador8PSK, tx');       % modular la señal con 8PSK.
fadedSig = filter(canalRayleigh,pskSig);    % aplicar el efecto Rayleigh a la señal modulada.
% Estimar la Probabilidad de error de bit (BER) para diferentes valores de
% SNR (EbNo).
SNR = 0:1:50; % valores de SNR en dB.0:2:20
numSNR = length(SNR);%cantidad de calores de SRN en dB.
berVec = zeros(3, numSNR);
% Crear el canal AWGN y calcular la tasa de error.
hChan = comm.AWGNChannel('NoiseMethod', 'Signal to noise ratio (SNR)');
hErrorCalc = comm.ErrorRate;
for n = 1:numSNR
    hChan.SNR = SNR(n);
   rxSig = step(hChan,fadedSig);   % Add Gaussian noise
   rx = step(demodulador8PSK, rxSig);  % Demodulate
   reset(hErrorCalc)
   % Compute error rate.
   berVec(:,n) = hErrorCalc(tx',rx);
end
BER = berVec(1,:);
% Compute theoretical performance results, for comparison.
BERtheory = berfading(SNR,'psk',M,1);
% Plot BER results.
figure('Name','Probabilidad de error de bit para canal Rayleigh','NumberTitle','off');
semilogy(SNR,BERtheory,'b-',SNR,BER,'r*');
legend('BER Teórico','BER Experimental');
xlabel('SNR (dB)'); ylabel('BER');
title('8-PSK sobre un canal Rayleigh');
