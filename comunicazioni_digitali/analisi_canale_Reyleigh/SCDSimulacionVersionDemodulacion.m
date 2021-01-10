%Santiago de cali, 26 de mayo de 2017
%Universidad Icesi.
%--------------------------------------------------------------------------------------------------------------
%PROYECTO FINAL DE COMUNICACIONES DIGITALES.
%TEMA: Simulación de un SCD.
%Presenta: William Martín Chávez González, Código: A00242064.
%Presenta: Juan Camilo Swan, Código:A00054620.
%Presenta: Tomás Lemus, Código:A00054616. 
%--------------------------------------------------------------------------------------------------------------
%Requerimientos del proyecto:
%1)Formato de la información: archivo de audio.
%2)Decodificador de fuente: Base64.
%3)Decodificador de canal: Código convolucional (R=1/2; k=3; g1(x)=1+x;
%g2(x)=1+x^2).
%4)Decodificador digital-Demodulador digital: 8-PSK.
%5)Canal: Rayleigh.
%--------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------
%Instrucciones iniciales:
%clear all;
%close all;
%-------------------------------------------------------
%-------------------------------------------------------
%DEMODULADOR DIGITAL:
senalADemodular=vec2mat(senalEfectoCanalRayleighRuidoGaussiano,1);
demodulador8PSK = comm.PSKDemodulator('ModulationOrder',M,'PhaseOffset',separacionAngular,'BitOutput',true,'SymbolMapping','gray');
senalSalidaCanal=step(demodulador8PSK,senalEfectoCanalRayleighRuidoGaussiano);
disp('Señal demodulada por el Demodulador Digital:');
disp(senalSalidaCanal(1:10)');
senalDemoduladaBinaria=senalSalidaCanal';
%-------------------------------------------------------
%-------------------------------------------------------
%DECODIFICADOR DE CANAL:
unidadesMemoriaCodigoConvolucional=3; %k=3 para el código convolucional.
%.......................
%decodificación del código convolucional con el Algoritmo de Viterbi:
ristraBitsDecodificada=vitdec(senalDemoduladaBinaria,trellisAlgorithm,unidadesMemoriaCodigoConvolucional,'trunc','hard');
%.......................
disp('Señal decodificada por el Decodificador de Canal:');
disp(ristraBitsDecodificada(1:20));
%-------------------------------------------------------
%-------------------------------------------------------
%DECODIFICADOR DE FUENTE:
codigoDecodificadoBase64=convertirVectorDecimal(ristraBitsDecodificada);
senalDecodificadaCaracteresBase64=char(codigoDecodificadoBase64);
senalAudioDecodificada=matlab.net.base64decode(senalDecodificadaCaracteresBase64);
disp('Señal audio decodificada por el decodificador de fuente:');
disp(ristraBitsDecodificada(1:10));
%-------------------------------------------------------
%-------------------------------------------------------
player=audioplayer(senalAudioDecodificada,Fs);
play(player)

