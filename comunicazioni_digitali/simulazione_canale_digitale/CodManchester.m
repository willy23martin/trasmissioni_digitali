function salida = CodManchester(entrada)
%Esta funcion recibe un vector horizontal de bits convolucionados, y
%devuelve un vector horizontal de bits codificados en manchester. El vector
%de salida es del doble que el de entrada , dado que este codigo por cada
%bit genera 2.
nBits = length(entrada); 
%Segun manchester, el area bajo la curva  de la señal a transmitir debe ser
%0, para esto divide un bit en 2. Si el bit es 1, lo representa como un
%01,si el bit es 0 lo representa como 01.

for i = nBits:-1:1
    if entrada(i) == 1
        salida(2*i) = 1; 
        salida(2*i-1) = 0;
    else
        salida(2*i) = 0;
        salida(2*i-1) = 1;
    end
end

