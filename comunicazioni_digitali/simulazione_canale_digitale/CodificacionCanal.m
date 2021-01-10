function  salida = CodificacionCanal( codi )
%CODIFICACIONCANAL Summary of this function goes here
%   Detailed explanation goes here

% trellis = struct('numInputSymbols',2,'numOutputSymbols',4,'numStates',4,...
%     'nextStates',[0 2;0 2;1 3;1 3],'outputs',[0 3;1 2;2 1;3 0]);

K = 3;        %K=3
pG1=6;        %Polinomio generador 1 1+x == 110 
pG2=5;        %Polinomio generador 2 1+x^2 == 101

trellis = poly2trellis(K,[pG1 pG2]);

salida = convenc(codi,trellis); 
%salida = convenc(codi,trellis);

dis1=['TAMAÑO DATOS DESPUES DE LA CODIFICACIÓN CONVOLUCIONAL ', num2str(length(salida))];
disp(dis1);

end


