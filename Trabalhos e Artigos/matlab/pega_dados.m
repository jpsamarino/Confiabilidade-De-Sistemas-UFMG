amplitude = 0.24;
z = 1
sim('trabalho_final'); % simulaçao, demora em media 10 minutos por teste

indice = round(v_c.time(90000:100000)*10000); % contor o problema do tamanho do passo ser variavel
indice = indice-min(round(v_c.time(90000:100000)*10000))+1;
buffer(indice) = v_carga.signals.values(90000:100000);

p_s_rms = rms(buffer)^2/4;
for(i = 1:6)
clear buffer;
buffer(indice) = p_r_1_6.signals(i).values(90000:100000);
p_r_rms(i) = rms(buffer);
clear buffer;
buffer(indice) = p_t.signals(i).values(90000:100000);
p_t_rms(i) = rms(buffer);
clear buffer;
buffer(indice) = v_t.signals(i).values(90000:100000);
v_t_rms(i) = rms(buffer);
end
for(j = 1:6)
clear buffer;
i=i+1;
buffer(indice) = p_r_1_6.signals(j).values(90000:100000);
p_r_rms(i) = rms(buffer);
end
for(i = 1:7)
clear buffer;
buffer(indice) = v_c.signals(i).values(90000:100000);
v_c_rms(i) = rms(buffer);
end


p_r_rms = [p_r_rms;p_r_rms+1];


for z = 1:20
z
amplitude = amplitude+0.011;
sim('trabalho_final');

indice = round(v_c.time(90000:100000)*10000); % contor o problema do tamanho do passo ser variavel
indice = indice-min(round(v_c.time(90000:100000)*10000))+1;
buffer(indice) = v_carga.signals.values(90000:100000);

b_p_s_rms = rms(buffer)^2/4;
for(i = 1:6)
clear buffer;
buffer(indice) = p_r_1_6.signals(i).values(90000:100000);
b_p_r_rms(i) = rms(buffer);
clear buffer;
buffer(indice) = p_t.signals(i).values(90000:100000);
b_p_t_rms(i) = rms(buffer);
clear buffer;
buffer(indice) = v_t.signals(i).values(90000:100000);
b_v_t_rms(i) = rms(buffer);
end
for(j = 1:6)
clear buffer;
i=i+1;
buffer(indice) = p_r_1_6.signals(j).values(90000:100000);
b_p_r_rms(i) = rms(buffer);
end
for(i = 1:7)
clear buffer;
buffer(indice) = v_c.signals(i).values(90000:100000);
b_v_c_rms(i) = rms(buffer);
end
p_r_rms = [p_r_rms;b_p_r_rms];
p_s_rms = [p_s_rms;b_p_s_rms];
p_t_rms = [p_t_rms;b_p_t_rms];
v_t_rms = [v_t_rms;b_v_t_rms];
v_c_rms = [v_c_rms;b_v_c_rms];
clear b_v_c_rms b_v_t_rms b_p_t_rms b_p_s_rms b_p_r_rms p_r_1_6 p_t v_t p_r_1_6 v_c
end
clear b_v_c_rms b_v_t_rms b_p_t_rms b_p_s_rms b_p_r_rms p_r_1_6 p_r_7_12 p_t v_t p_r_1_6 v_c indice  buffer amplitude v_carga tout
save('dados_n21');
