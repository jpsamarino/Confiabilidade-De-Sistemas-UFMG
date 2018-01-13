function [alfa_c] = diodo(temperatura_ambiente,tensao,tensao_nominal)
alfa_b = 0.0038;
temp_j = temperatura_ambiente;
pi_t = exp(-3091*(1/(temp_j+273)-1/298));
pi_c = 2.2;
pi_v = (((tensao/tensao_nominal))^2.43);
pi_e = 6; %GF Ambiente semi- controlado e no chao, nao movel.
pi_q = 5.5; %referente a qualidade comercial do item.
alfa_c = alfa_b*pi_t*pi_c*pi_v*pi_e*pi_q;
end