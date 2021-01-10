function dat = DecodManchester(entrada)
nBits = length(entrada); 
dat = ones(1,nBits/2); 

for i = nBits:-2:2
    if entrada(i) ~= entrada(i-1)
        dat(i/2) = entrada(i);
    end
end



