function [datosDecoCanal]=DecDCanal(datosDemodulacion)

K=3;
pG1=6;        %Polinomio generador 1 pasados a octal  1+x == 110 
pG2=5;        %Polinomio generador 2 pasados a octal  1+x^2 == 101

trellis = poly2trellis(K,[pG1 pG2]);  % Genera maquina de estados
tblen = K*10;            % Profundidad de rastreo
datosDecoCanal = vitdec(datosDemodulacion,trellis,tblen,'trunc','hard'); % Decodificacion con viterbi


save decoCanal datosDecoCanal