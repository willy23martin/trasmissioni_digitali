function [salida]=Modular(entrada)
%Este bloque recibe una rista de bits, vector horizontal, y devuelve las
%formas de onda moduladas que pasaran por el canal, vector horizontal.

% Se invierte vector para adecuar a la funcion de modulacion 
cod = transpose(entrada); 
% PSKModulator crea un modelo que representa el modulador bandabase M-ario
hModulator = comm.PSKModulator('ModulationOrder',8,'SymbolMapping','gray','BitInput',true);   %
fase = 8;    
hModulator.PhaseOffset = (2*pi)/fase;

var=(int32((length(cod)/3)+1)*3)-length(cod); 
for i=1:1:var
    cod(length(cod)+1)=0;
end
for i=1:1:600000                                   %Rellenar con 1 para completar a multiplo de 3
    if i<400000
    cod(length(cod)+1)=0;
    else
    cod(length(cod)+1)=1;  
    end
end


salida = step(hModulator, cod);                            
scatterplot(salida);title('Antes de entrar al canal');                                
constellation(hModulator);