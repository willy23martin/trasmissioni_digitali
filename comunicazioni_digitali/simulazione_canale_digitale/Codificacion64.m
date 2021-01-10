function [Abin] = Codificacion64(ruta)
%Funcion recibe la ruta de cualquier archivo y lo convierte en un vector
%binario donde cada posicion es un bit del archivo

% Se codifica el archivo usando 8 bits se usa la funcion 
nbits = 8;
fileID = fopen(ruta); %fopen, crea un id o puntor para que matlab referencie 
                      %la memoria sobre el archivo a abrir o crear.
A = uint8(fread(fileID)); %Se usa fread, la cual lee el archivo en el puntero fileID 
                          %y arroja una matriz de doubles,posteriormente se castea a int8 
fclose(fileID);

B = org.apache.commons.codec.binary.Base64.encodeBase64Chunked(A); 
%Se usa la funcion encodeBase64 del api de java que recibe una matriz de
%ints8 y la convierte a caracteres codificados en base64
                                                                  
Abin = de2bi(B,nbits);                       %Se convierte la matriz base64 a binario
rows = size(Abin,1); columns = size(Abin,2); %Se convierte la matriz binaria en una rista de bits lista para los otros bloques.
Abin = reshape(Abin',1,rows*columns);



