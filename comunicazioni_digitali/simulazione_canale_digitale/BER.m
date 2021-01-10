%PROBABILIDAD DE ERROR DEL BLOQUE DE DECODIFICACIÓN DE CANAL

%Entra la salida del bloque de formateo
function[] = BER(entrada, errores, EbNo)

% n = 7;                                                                      % Longitud palabra de codigo  
% k = 4;                                                                      % Logitud mensaje 
% G = cyclpoly(n,k);                                                          % Polinomio generador
% afterChannelEncode = encode(entrada,n,k,'cyclic/binary',G);     % Codigo ciclico generado utilizando la función de MATLAB encode().

K = 3;        %K=3
pG1=6;        %Polinomio generador 1 1+x == 110 
pG2=5;        %Polinomio generador 2 1+x^2 == 101

trellis = poly2trellis(K,[pG1 pG2]);

afterChannelEncode = convenc(entrada,trellis); 



N = size(afterChannelEncode,2);                                          % tamaño del vector antes de QPSK          
EbNodB = EbNo;                                                    % relacion señal a ruido en decibeles
EbNo = 10.^(EbNodB/10);                                                  % relacion señal a ruido en unidades lineales

%Modulacion QPSK.
bits = transpose(afterChannelEncode);  
H = comm.QPSKModulator('BitInput',true);                 % objeto con la modulacion QPSK, la función comm.QPSKModulator() de Matlab utiliza codificación Gray por defecto
qpsk = step(H,bits);
%Fin modulación QPSK
errors = 0;
for i=1:length(EbNodB) 
    %Adición del ruido producido por el canal AWGN al objeto QPSK modulado.                             
    awgnVector = awgn(qpsk,EbNodB(i));

    %Demodulación QPSK
    dH = comm.QPSKDemodulator('BitOutput',true);   % Objeto con la demodulación QPSK utilizando la función comm.QPSKDemodulator de Matlab
    afterQPSK = step(dH,awgnVector);                                           
    %Fin de la demodulación QPSK

    %Decodificación de canal
%     n = 7;                                                         % Longitud de la palabra de codigo  
%     k = 4;                                                         % Logitud del mensaje 
     b = reshape(afterQPSK,1,length(afterQPSK));                            %Reorganizacion de la matriz de entrada dqpsk
%     G = cyclpoly(n,k);                                             % Polinomio generador
%     afterChannelDecode = decode(b,n,k,'cyclic/binary',G);
    %Fin de la decodificación de canal
    
    K=3;
    pG1=6;        %Polinomio generador 1 pasados a octal  1+x == 110 
    pG2=5;        %Polinomio generador 2 pasados a octal  1+x^2 == 101

    trellis = poly2trellis(K,[pG1 pG2]);  % Genera maquina de estados
    tblen = K*10;            % Profundidad de rastreo
    afterChannelDecode = vitdec(b,trellis,tblen,'trunc','hard'); % Decodificacion con viterbi


    

    %Comparación de las señales antes y después del ruido
    subs = afterChannelDecode - entrada;
    errors = errors + size(find(subs),1);
end

%Probabilidad de error de bloque simulada
errorDeBloqueS = 0;
simulatedErrorBit = errors/N;
for j=errores+1:N
	errorDeBloqueS = errorDeBloqueS + ((nchoosek(N,j)*(simulatedErrorBit.^(j)))*((1-simulatedErrorBit).^(N-j)));
end

%Probabilidadde error de bloque teórica
errorDeBloqueT = 0;
Pb = 0.5*erfc(sqrt(EbNo));
for j=errores+1:N
	errorDeBloqueT = errorDeBloqueT + (((nchoosek(N,j))*(Pb.^(j))*((1-Pb).^(N-j))));
end

%% GRAFICA DE LA PROBABILIDAD DE ERROR DE BLOQUE
figure;
 s%emilogy(EbNodB,errorDeBloqueS,'b>-');
hold on;
semilogy(EbNodB,errorDeBloqueT,'r>-');
legend('PEB simulado para el bloque de decodificación de canal','PEB Teórico para el bloque de decodificación de canal')
xlabel('EbNo (dB)','color','k'); 
ylabel('BEP','color','k');
title('Probabilidad de error del bloque de decodificación de canal');
axis([-10 20 10^-6 1]);
grid on;

FIN DEL BLOQUE DE PEB PARA DECODIFICACIÓN DE CANAL