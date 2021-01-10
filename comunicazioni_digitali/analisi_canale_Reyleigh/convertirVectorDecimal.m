function [ representacionDecimalBase64 ] = convertirVectorDecimal(ristraDeBits)
%Función que convierte los valores decimales muestreados de la señal de
%audio, en un vector binario correspondiente.
columnasRistaBits=length(ristraDeBits);
%disp(columnasRistaBits);
%Formar el vector decimal de la señal de audio:
representacionDecimalBase64=[];
j=1;
for i=1:8:columnasRistaBits
    %disp(i);
    segmentoBits= ristraDeBits(i:i+7);
    %disp(segmentoBits);
    representacionDecimalBase64(1,j)=bi2de(segmentoBits);
    %disp(representacionDecimalBase64);
    j=j+1;
end

