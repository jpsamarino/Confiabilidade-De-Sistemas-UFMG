%modelo capacitor CP - HDBK - 217
function [alfa_c] = capacitor(temperatura_ambiente,capacitancia,tensao,tensao_nominal)
alfa_b = 0.00037;
temperatura = temperatura_ambiente;
pi_t = exp(-0.15/8.617e-5*(1/(temperatura+273)-1/298));
pi_c = capacitancia^0.09;
pi_v = (((tensao/tensao_nominal)/0.6)^5)+1;
pi_e = 10; %GF Ambiente semi- controlado e no chao, nao movel.
pi_q = 10; %referente a qualidade comercial do item.
alfa_c = alfa_b*pi_t*pi_c*pi_v*pi_e*pi_q;
end