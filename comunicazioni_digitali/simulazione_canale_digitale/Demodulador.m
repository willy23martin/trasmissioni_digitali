function [salida]=Demodulador(entrada)
%Recibe un arreglo vertical de numero complejos provenientes del canal, los
%decodifica en una rista de bits .La salida es un vector horizontal de bits
fase=8;
demo=comm.PSKDemodulator(8,'PhaseOffset', (2*pi)/fase,'BitOutput',true);
%Crea modelo de decodificador, este modelo se utiliza para mapear los simbolos y poder decodificar
salida = step(demo,entrada);                
salida = transpose(de2bi(salida));    
save demodulador salida