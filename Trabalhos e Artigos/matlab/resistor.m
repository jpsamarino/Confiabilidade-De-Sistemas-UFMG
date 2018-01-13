%modelo resistor RC - HDBK - 217
function [alfa_r] = resistor(temperatura_ambiente,RtetaJC,potencia,potencia_nominal)
alfa_b = 0.0017;
temperatura = potencia*RtetaJC+temperatura_ambiente;
pi_t = exp(-0.2/8.617e-5*(1/(temperatura+273)-1/298));
pi_p = potencia^0.39;
pi_s = 0.54*exp(2.04*(potencia/potencia_nominal));
pi_e = 4; %GF Ambiente semi- controlado e no chao, nao movel.
pi_q = 10; %referente a qualidade comercial do item.
alfa_r = alfa_b*pi_t*pi_p*pi_s*pi_e*pi_q;
end