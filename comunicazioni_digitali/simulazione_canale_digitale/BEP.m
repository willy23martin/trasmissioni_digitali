function [ output_args ] = BEP( snr,decodificacion )
        % Program for generation and detection of 8PSK signal  
  
    % Number of bits or symbols
        

    N=decodificacion;   
   % Initializing the rand function 
    rand('state',100);  
   % Initializing the rand function 
    randn('state',200);  

   % transmitter
    ip = rand(1,N)>(snr/100);
     
    s=8*ip-1;  
    % White gaussian noise 0dB variance 
    n=1/sqrt(2)*[randn(1,N)+j*randn(1,N)]; 
    % Multiple Eb/No values 
    Eb_No_dB=[-3:snr];  
    for  ii=1:length(Eb_No_dB)
              % Noise addition(additive white noise)
               y=s+10^( -Eb_No_dB(ii)/20)*n;
              % receiver hard decision recording.
              ipHat=real(y)>0;
             % counting the errors
              nErr(ii)=size(find ([ip-ipHat]),2);
   end

   % Simulated BER
  simBER=nErr/N;
  % Theoretical BER 
  theoryBER=0.2*erfc((sqrt(2*3*(10.^( Eb_No_dB/10))))*sin(pi/8));  

  % plot
  figure(1)
  semilogy(Eb_No_dB,simBER, 'b.-');
  hold on
  semilogy(Eb_No_dB,theoryBER, 'mx-');
  axis([-3 snr 10^-8 0.5]);
  grid on
  legend('theory','simulation');
  xlabel('Eb/ No , dB');
  ylabel(' BER rate');
  title('Simbol error rate probability curve for 8PSK modulation');

  figure(2)
  semilogy(Eb_No_dB,simBER*(3), 'b.-');
  hold on
  semilogy(Eb_No_dB,theoryBER*(3), 'mx-');
  axis([-3 snr 10^-8 0.5]);
  grid on
  legend('theory','simulation');
  xlabel('Eb/ No , dB');
  ylabel(' BEP rate');
  title('Bit error probability  curve for 8PSK modulation');

end

