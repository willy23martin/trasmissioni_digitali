%Santiago de cali, 26 de mayo de 2017
%Universidad Icesi.
%--------------------------------------------------------------------------------------------------------------
%PROYECTO FINAL DE COMUNICACIONES DIGITALES.
%TEMA: Simulación de un SCD.
%Presenta: William Martín Chávez González, Código: A00242064
%Presenta: Juan Camilo Swan, Código:A00054620.
%Presenta: Tomás Lemus, Código: A00054616.
%--------------------------------------------------------------------------------------------------------------
%Requerimientos del proyecto:
%1)Formato de la información: archivo de audio.
%2)Codificador de fuente: Base64.
%3)Códificador de canal: Código convolucional (R=1/2; k=3; g1(x)=1+x;
%g2(x)=1+x^2).
%4)Codificador digital-Modulador digital: 8-PSK.
%5)Canal: Rayleigh.
%--------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------
%Instrucciones iniciales:
clear all;
close all;
%prompt = 'Ingrese la relación señal a ruido de bit (EbNo) en dB:';
%EbNo=input(prompt);%relación señal a ruido de bit requerido por el usuario.
gui=inputdlg({'Ingrese la relación señal a ruido de bit (EbNo) en dB:'}, 'SCD',[1 50]);
EbNo=str2double(gui{1});
disp(EbNo);
%%
%-------------------------------------------------------
%-------------------------------------------------------
%FUENTE DE LA INFORMACIÓN:
%Captura de la señal de audio con un micrófono:
Fs=44100;%corresponde a dos veces la máxima componente en frecuencia de una señal de audio.
numeroBits=8;%número de bits por muestra para la cuantización de las amplitudes de cada una de las muestras.
grabadora = audiorecorder(Fs,8,1);%8 bits por muestra y un solo canal.
msgbox('De click en OK. Tiene 6 segundos para hablar.')
recordblocking(grabadora, 6);%captura la señal de audio durante 3 segundos.
msgbox('Finalizó la grabación.');
play(grabadora);%reproduce la señal de audio grabada.
senalAudio = getaudiodata(grabadora, 'uint8');%almacena la señal en un arreglo de doble precisión. 
disp('Señal de audio grabada:');
disp(senalAudio(1:10));
figure('Name','Señal de audio grabada','NumberTitle','off');
plot(senalAudio, 'LineStyle','-.',...
     'MarkerFaceColor','blue',...
     'MarkerEdgeColor','green'); %muestra la señal de audio grabada.
title('Señal de audio grabada');
xlabel('t');
ylabel('x(t)'); 
%%
%-------------------------------------------------------
%-------------------------------------------------------
%CODIFICADOR DE FUENTE: 
codigoBase64=matlab.net.base64encode(senalAudio);%codifica en base64 la señal de audio binaria.
disp('Señal codificada en Base64 por el Codificador de fuente:');
disp(codigoBase64(1:20));
%%
%-------------------------------------------------------
%-------------------------------------------------------
%CODIFICADOR DE CANAL:
representacionNumericaBase64=double(codigoBase64);%representación numérica de caracteres ASCII Base64.
disp('Representación numérica de la señal codificada en Base64:');
disp(representacionNumericaBase64(1:5));
ristraBitsEntrada=convertirVectorBinario(representacionNumericaBase64);%decodifica el código Base64 a binario.
%recibido del audio para determinar la señalde audio binaria.
disp('Ristra de bits de entrada al codificador de canal:');
disp(ristraBitsEntrada(1:40));
%.......................
figure('Name','Señal de audio codificada Base64 en binario:','NumberTitle','off');
stem(ristraBitsEntrada(1:1:100), 'LineStyle','-.',...
     'MarkerFaceColor','blue',...
     'MarkerEdgeColor','green');
title('Muestras de la señal de audio:');
xlabel('n');
ylabel('x[n]'); 
%.......................
%definición del algoritmo Trellis:
%Posibles símbolos de entrada=2, porque puede entrar un 1 o un 0.
%Posibles símbolos de salida=4, porque puede salir un 1 (01), un 2 (10), un
%3(11) o un 0 (00).
%Posibles estados=4, porque son 00, 01, 11 y 10.
%Siguientes estados: cuatro filas porque son cuatro estados, dos columnas
%porque puede entrar un uno o un cero; la primera columna es si entra un cero y la
%segunda columna es si entra un uno. El contenido por fila vs columna es el
%estado al que pasa con relación a la entrada: ejemplo, si está  en 00 que
%es la primera fila y entra un 0, entonces para a estado 00; si entra un 1,
%entonces pasa a estado 2(10).
%Salidas: son las salidas requeridas por la codificación ante una entrada,
%dependiendo en el estado en que se encuentre. Por ejemplo, si está en
%estado 00(primera fila) y entra un 0, entonces sale 00(0); si entra un 1,
%entonces sale 11 (3).
trellisAlgorithm=struct('numInputSymbols',2,'numOutputSymbols',4,'numStates',4,...
    'nextStates',[0 2;0 2;1 3;1 3],'outputs',[0 3;1 2;2 1;3 0]);
%.......................
codigoConvolucional=convenc(ristraBitsEntrada,trellisAlgorithm);%código convolucional aplicado a la ristra de bits.
disp('Señal codificada en código convolucional por el Codificador de Canal:');
disp(codigoConvolucional(1:20));
%-------------------------------------------------------
%-------------------------------------------------------
%MODULADOR DIGITAL:
M=8;%número de símbolos correspondientes a la modulación 8-PSK.
k=log2(M);%número de bits por símbolo.
separacionAngular=(2*pi/M);
%.......................
%Definir el modelo de modulación 8-PSK:
%Orden de la modulación: M = 8 símbolos.
%Fase del punto cero de la constelación.
%Entrada de bits habilitada.
%Codificación gray habilitada.
modulador8PSK = comm.PSKModulator('ModulationOrder',M,'PhaseOffset',separacionAngular,'BitInput', ...
    true,'SymbolMapping','gray');
%.......................
senalModulada=step(modulador8PSK,codigoConvolucional');%modula el código convolucional con 
%el modulador 8-PSK definido.
disp('Señal modulada por un modulador 8-PSK:');
disp(senalModulada(1:10));
%.......................
h1=scatterplot(senalModulada);
hold on
scatterplot(senalModulada,[],[],'r*',h1)
title('Constelación 8-PSK de los símbolos digitales antes de salir del canal:');
xlabel('I - en fase');
ylabel('Q - en cuadratura'); 
%.......................
constellation(modulador8PSK);
title('Codificación Gray para cada símbolo digital 8-PSK:');
xlabel('I - en fase');
ylabel('Q - en cuadratura'); 
%.......................
%-------------------------------------------------------
%-------------------------------------------------------
%CANAL DE COMUNICACIÓN:
%Tipo: canal Rayleigh-usada en comunicaciones inalámbricas.
canalRayleigh=rayleighchan;%canal con una sola ruta sin efecto Doppler.
efectoCanalRayleigh=filter(canalRayleigh,senalModulada);%efecto del canal Rayleigh sobre los
%símbolos digitales.
disp('Efecto del canal Rayleigh sobre la señal modulada:');
disp(efectoCanalRayleigh(1:10));
%.......................
senalEfectoCanalRayleighRuidoGaussiano = awgn(efectoCanalRayleigh,EbNo);%efectoCanalRayleigh
h=scatterplot(senalEfectoCanalRayleighRuidoGaussiano);%senalEfectoCanalRayleighRuidoGaussiano
hold on
scatterplot(senalModulada,[],[],'r*',h)
grid
title('Constelación de los símbolos digitales después de salir del Canal Rayleigh:');
xlabel('I - en fase');
ylabel('Q - en cuadratura'); 
%.......................

