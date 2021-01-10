function [] = SalidaYBase64(ruta,datos)
%Funcion recibe el nombre del arhivo , punto, el formato. Y una rista de
%bits codificada en 8 bits que convierte en matriz y guarda como archivo
%con el nombre y formato dado
nbits = 8;
Abin2 = vec2mat(datos,nbits);  %Se convierte rista de bits en matriz de 8 bits.
C = bi2de(Abin2);              %Se convierte matriz a decimales

D = typecast(org.apache.commons.codec.binary.Base64.decodeBase64(C), 'uint8');
%Utilizando el api de java, se usa la funcion de decodificacion base64, la
%cual recibe una matriz codificada en base y devuelve una matriz de
%enteros de 8 bits.

fileID2 = fopen(ruta,'w');  %fopen, crea un id o puntor para que matlab referencie 
                            %la memoria sobre el archivo a abrir o crear.
fwrite(fileID2,D);          %fwrite escribe el contenido de la matriz D en el archivo con id fileID2
fclose(fileID2);