function salida = CodLineaManch2( entrada )
%CODLINEAMANCH2 Summary of this function goes here
%   Detailed explanation goes here


nBits=length(entrada);

for i=nBits:-1:1
    if entrada(i)==1;
        salida(2*i)=1;
        salida(2*i-1)=-1;
    else
        salida(2*i)=-1;
        salida(2*i-1)=1;
    end   

end

