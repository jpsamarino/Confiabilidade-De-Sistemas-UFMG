%modelo Transistor LOW FREQUENCY(<100Mhz), BIPOLAR - HDBK - 217
function [alfa_t] = transistor(temperatura_ambiente,RtetaJC,potencia,vce,vceo)

temp_j = potencia*RtetaJC+temperatura_ambiente;
alfa_b = 0.00074;
pi_t = exp(-2114*(1/(temp_j+273)-1/298));
if(potencia <0.1)
 pi_p = 0.43;
else
  pi_p = potencia^0.37;  
end
pi_s = 0.045*exp(3.1*(vce/vceo)); % tensão rms coletor emisor e coletor emisor aberto
pi_e = 10; %GF Ambiente semi- controlado e no chao, nao movel.
pi_q = 5.5; %referente a qualidade comercial do item.
alfa_t = alfa_b*pi_t*pi_p*pi_s*pi_e*pi_q;
end