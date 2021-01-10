function salida = Decodificacion( canal,codLine )
%DECODIFICACION Summary of this function goes here
%   Detailed explanation goes here

% Demodulacion                                                            (Deco 8-PSK)
dataDemod=Demodulador(canal);
dataDemod=dataDemod(1:length(codLine));
display('Deco 8-PSK');
% Decodificacion Banda Base                                               (Deco Manchester)
decBanBas=DecodManchester(dataDemod);
display('Deco Manchester');
% Decodigicacion de Canal                                                 (Deco Convolucional)                                              
decCan=DecDCanal(decBanBas);
display('Deco Convolucional');
% Salida
DecoBase64('audio.wav',decCan);
%BER_8PSK_Rayleigh;
display('transmitido el archivo');
end

