%Santiago de cali, 02 de octubre de 2017
%Universidad Icesi.
%--------------------------------------------------------------------------------------------------------------
%TALLER #1 DE COMUNICACIONES INALÁMBRICAS.
%TEMA: Simulación de un Sistema móvil inalámbrico.
%Presenta: William Martín Chávez González, Código: A00242064.
%--------------------------------------------------------------------------------------------------------------
%%
%-------------------------------------------------------
%-------------------------------------------------------
%CARACTERÍSTICAS DEL SCD MÓVIL INALÁMBRICO:
close all;
clear all;
d = 0:0.1:7;         %Distancia entre el transmisior y el receptor en Km.
Rb = 0:1000:10000000;    %Tasa de transmisión binaria del SCD en bps.
pt = 30000;          %Potencia del Tx en mW.
Pt = 10*log10(pt);   %Potencia del Tx en dBm.
fc = 1700;           %Frecuencia de la señal portadora carrier en MHz. 
No = 4.21*10^(-18);  %Densidad espectral del ruido en  mW/Hz.
ht = 25;             %Altura de la torre para la antena base en m.
hm = 0.01;           %Altura de la antena para el receptor móvil en m.
Gt = 22.86;          %Ganancia de la antena en el transmisor en dB.
Gr = 2.86;           %Ganancia de la antena en el receptor en dB.
Lcable = 6.6/100;    %Pérdidas del cable desde el radio de la antena FlexLine 7/8" en dB/m.
Lconector = 0.5;     %Pérdidas debido a conectores del fabricante en dB/conector.
Lprotector = 0.1;    %Pérdidas por protector contra descargas eléctricas en dB/protector.
FN = 10;             %Figura de ruido en el receptor en dB.
EbNo = 8;            %Relación señal a ruido de bit en dB.
BW = 20000000;       %Ancho de Banda en Hz.

%CÁLCULOS PREVIOS:
S = -174 + 10.*log10(Rb)+EbNo+FN;    %Nivel de sensibilidad en el receptor en dBm.
aHm = 3.2*((log10(11.75*hm))^2)-4.97;%Factor de corrección del modelo Okumura-Hata en dB.
%Pérdidas de trayecto considerando shadowing - Modelo de Propagación
%Okumura-Hata en dB.
Lnlos = 69.55+26.16*log10(fc)-13.82*log10(ht)-aHm+(44.9-6.55*log10(ht)).*log10(d);
Lm = (ht*Lcable)+(4*Lconector)+(1*Lprotector); %Pérdidas misceláneas en dB.
Pr = Pt + Gt + Gr - Lm - Lnlos;                %Potencia media en el receptor en dBm.
FM = Pt - S;                                   %Margen de protección en dB.
pr = 10.^(Pr/10);                              %Potencia en el receptor en mW.
C = BW.*log2(1+(pr/(No*BW)));                  %Capacidad de canal en bps.

%==================================================================================
% GRÁFICA DE PATH LOSS VS DISTANCIA.
figure('Name','SCD móvil inalábrico','NumberTitle','off');
semilogy(d,Lnlos,'r-');
legend('Lnlos Okumura-Hata dB');
xlabel('Distancia (Km)'); ylabel('Path Loss (dB)');
title('Path Loss(dB) vs Distancia (Km)');
ylim([0 170]);
%====================================
% GRÁFICA DE POTENCIA RECIBIDA VS DISTANCIA.
figure('Name','SCD móvil inalábrico','NumberTitle','off');
semilogy(d,Pr,'b-');
legend('Potencia recibida dBm');
xlabel('Distancia (Km)'); ylabel('Pr (dBm)');
title('Potencia Recibida(dBm) vs Distancia (Km)');
ylim([-100 -30]);
%====================================
% GRÁFICA DE CAPACIDAD DE CANAL VS DISTANCIA.
figure('Name','SCD móvil inalábrico','NumberTitle','off');
semilogy(d,C,'b-');
legend('Capacidad bps');
xlabel('Distancia (Km)'); ylabel('C (bps)');
title('Capacidad de Canal (bps) vs Distancia (Km)');
%ylim([-100 -30]);
%====================================
%====================================
% GRÁFICA DE SENSIBILIDAD VS TASA BINARIA.
figure('Name','SCD móvil inalábrico','NumberTitle','off');
semilogy(Rb,S,'b-');
legend('Sensibilidad dBm');
xlabel('Rb (bps)'); ylabel('S (dBm)');
title('Sensibilidad (dBm) vs Tasa Binaria (bps)');
ylim([-110 -80]);
%====================================
%====================================
% GRÁFICA DE CAPACIDAD DE CANAL VS POTENCIA RECIBIDA.
figure('Name','SCD móvil inalábrico','NumberTitle','off');
semilogy(Pr,C,'b-');
legend('Capacidad bps');
xlabel('Pr (dBm)'); ylabel('C (bps)');
title('Capacidad de Canal (bps) vs Potencia Recibida (dBm)');
xlim([-100 -30]);
%====================================