%Santiago de cali, 02 de octubre de 2017
%Universidad Icesi.
%--------------------------------------------------------------------------------------------------------------
%EJERCICIO #1 DE COMUNICACIONES INALÁMBRICAS.
%TEMA: Simulación de un Sistema móvil inalámbrico.
%Presenta: William Martín Chávez González, Código: A00242064.
%--------------------------------------------------------------------------------------------------------------
%%
%-------------------------------------------------------
%-------------------------------------------------------
%CARACTERÍSTICAS DEL SCD MÓVIL INALÁMBRICO:
close all;
clear all;
d = 0:1:400000;   %Distancia entre el transmisior y el receptor en m.
dout = 100;          %Distancia de referencia de 100m en ambientes outdoor.
din = 1;             %Distancia de referencia de 1m en ambientes indoor.
c = 3*10^(8);        %Velocidad de propagación de las ondas en m/s.
Ts = 0.4*10^(-6);    %Periodo de Símbolo en segundos.
pt = 15000;          %Potencia del Tx en mW.
Pt = 10*log10(pt);   %Potencia del Tx en dBm.
fc = 2500000000;     %Frecuencia de la señal portadora carrier en Hz. 
No = 4.21*10^(-18);  %Densidad espectral del ruido en  mW/Hz.
Gt = 15;             %Ganancia de la antena en el transmisor en dB.
Gr = 2;              %Ganancia de la antena en el receptor en dB.
alpha2 = 0.95;       %Factor de atenuación alpha al cuadrado.
BW = 20000000;       %Ancho de Banda en Hz.
S = -102;            %Nivel de sensibilidad en el receptor en dBm.
nLOS = 2.2;          %Exponente de pérdidas básicas en espacio libre.
nSHADOW = 4.3;       %Exponente de pérdidas básicas con Shadowing.
nOBSTRU = 5.8;       %Exponente de pérdidas básicas con edificios y caminos obstruidos.

%CÁLCULOS PREVIOS:
%Pérdidas en dB en LOS.
Lf = (20*log10((4*pi*dout*fc)/c))+(10*nLOS).*(log10((d./dout)));
Pr = Pt + Gt + Gr - Lf;                %Potencia media en el receptor en dBm.
pr = 10.^(Pr/10);                      %Potencia en el receptor en mW.
C = BW.*log2(1+((pr/(No*BW))*alpha2)); %Capacidad de canal en bps.

%==================================================================================
% GRÁFICA DE PATH LOSS VS DISTANCIA.
figure('Name','SCD móvil inalábrico LOS','NumberTitle','off');
semilogy(d,Lf,'r-');
legend('Lfree dB');
xlabel('Distancia (m)'); ylabel('Path Loss (dB)');
title('Path Loss(dB) vs Distancia (m)');
xlim([0 400000]);
ylim([100 160]);
%====================================
% GRÁFICA DE POTENCIA RECIBIDA VS DISTANCIA.
figure('Name','SCD móvil inalábrico','NumberTitle','off');
semilogy(d,Pr,'b-');
legend('Potencia recibida dBm');
xlabel('Distancia (m)'); ylabel('Pr (dBm)');
title('Potencia Recibida(dBm) vs Distancia (m)');
xlim([0 400000]);
ylim([-100 -30]);
%====================================
% GRÁFICA DE CAPACIDAD DE CANAL VS DISTANCIA.
figure('Name','SCD móvil inalábrico','NumberTitle','off');
semilogy(d,C,'b-');
legend('Capacidad bps');
xlabel('Distancia (m)'); ylabel('C (bps)');
title('Capacidad de Canal (bps) vs Distancia (m)');
xlim([0 400000]);
%====================================
