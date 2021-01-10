function secuenciaBits = SecBits( audio )
%SECBITS Summary of this function goes here
%   Detailed explanation goes here
load variables
Fs = fs; %Frecuencia de muestreo

L = length(audio); %Calculamos el número de muestras que contiene el audio
NFFT = 2^nextpow2(L); %La función fft() es más eficiente cuando calcula la transformada de Fourier de una función cuya longitud es una potencia de 2 (2, 4, 8, ?)
Y = fft(audio, NFFT)/L; %Calculamos la FFT con la función fft() Dividimos entre L el resultado para normalizar los valores
f = Fs/2*linspace(0,1,NFFT/2+1); %construir el eje de coordenadas Las frecuencia que devuelve la FFt van de la frecuencia 0 hasta la frecuencia mitad de la frecuencia de muestreo
                                 %El número de elementos que este vector debe de contener es NFFT/2+1 ya que debido a que la DFT genera una imagen espejo del espectro de frecuencia
plot(f,2*abs(Y(1:NFFT/2+1)));  %Graficamos

end

