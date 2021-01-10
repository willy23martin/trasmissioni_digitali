function [ senalAudioBinaria ] = convertirVectorBinario( representacionNumericaBase64 )
%Función que convierte los valores decimales muestreados de la señal de
%audio, en un vector binario correspondiente.
matrizAudioBinaria=de2bi(representacionNumericaBase64,8);%cada fila es el valor en binario del valor decimal de una muestra de señal.
tamanioMatrizAudioBinaria=size(matrizAudioBinaria);
filasMatrizAudioBinaria=tamanioMatrizAudioBinaria(1,1);
%disp(filasMatrizAudioBinaria);
%Formar el vector binario de la señal de audio:
senalAudioBinaria=[];
j=1;
for i=1:filasMatrizAudioBinaria
    %disp(i);
    filaBinaria= matrizAudioBinaria(i,:);
    %disp(filaBinaria);
    senalAudioBinaria(j:(7+j))=filaBinaria;
    %disp(senalAudioBinaria);
    j=8+j;
end

