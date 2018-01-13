%pre amp 
%T1,T2 ; R1 a R4 ; C1 a C3
load('dados');
mtbf_pre = zeros(1,length(p_r(:,1)));
ta = 40;
for i = 1:length(p_r(:,1)) 
   mtbf_pre(i) =  mtbf_pre(i)+resistor(ta,46,p_r(i,1),0.33)+resistor(ta,46,p_r(i,2),0.33)+resistor(ta,46,p_r(i,3),0.33)+resistor(ta,46,p_r(i,4),0.33); %padrao MELF 0204 para temperatura
   mtbf_pre(i) = mtbf_pre(i)+transistor(ta,83.3,p_t(i,1),v_t(i,1),45)+transistor(ta,320,p_t(i,2),v_t(i,2),45); %BC547C , BC807-40
   mtbf_pre(i) = mtbf_pre(i)+capacitor(ta,1,v_c(i,1),70)+capacitor(ta,2.2,v_c(i,2),70)+capacitor_c(ta,47e-3,v_c(i,3),100);
end
figure;
plot(p_s,10e6./mtbf_pre,'*r'); % tempo medio ate falhar pre amp
title('Tempo medio até falha (pre amp)')
xlabel('Potencia(W)'); 
ylabel('Tempo(H)');

%potencia
%R6; R8; R9; R11; R12; C5; Q3 a Q6
mtbf_pot = zeros(1,length(p_r(:,1)));
for i = 1:length(p_r(:,1)) 
   mtbf_pot(i) =  mtbf_pot(i)+resistor(ta,46,p_r(i,6),1)+resistor(ta,46,p_r(i,8),0.33)+resistor(ta,46,p_r(i,9),0.33)+resistor(ta,46,p_r(i,11),0.33)+resistor(ta,46,p_r(i,12),1); %padrao MELF 0204 para temperatura
   mtbf_pot(i) = mtbf_pot(i)+transistor(ta,100,p_t(i,3),v_t(i,3),60)+transistor(ta,100,p_t(i,5),v_t(i,5),60)+transistor(ta,2.5,p_t(i,4),v_t(i,4),55)+transistor(ta,2.5,p_t(i,6),v_t(i,6),60); %BC547/bd137 , BC807-40/bd138 ,D45H11/BD250,2n3055/BD207
   mtbf_pot(i) = mtbf_pot(i)+capacitor(ta,2200,v_c(5,1),60);
end
figure;
plot(p_s,10e6./mtbf_pre,'*b',p_s,10e6./mtbf_pot,'*r');
figure;
plot(p_s,10e6./mtbf_pot,'*r'); 
title('Tempo medio até falha (Potencia)')
xlabel('Potencia(W)'); 
ylabel('Tempo(H)');

%proteção
%D1,D2,D3
mtbf_prot = zeros(1,length(p_r(:,1)));
for i = 1:length(p_r(:,1)) 
mtbf_prot(i) = diodo(ta,0.455,70)+diodo(ta,0.455,70)+diodo(ta,0.455,70); %1n4002
end
figure;
plot(p_s,10e6./mtbf_prot,'*r'); %tempo medio ate falha prot
title('Tempo medio até falha (proteção)')
xlabel('Potencia(W)'); 
ylabel('Tempo(H)');
%outros
%R5 , R7 ,R10 ; C4, C6, c7

mtbf_out = zeros(1,length(p_r(:,1)));
for i = 1:length(p_r(:,1)) 
   mtbf_out(i) = mtbf_out(i)+resistor(ta,46,p_r(i,5),0.33)+resistor(ta,46,p_r(i,7),0.33)+resistor(ta,46,p_r(i,10),0.33); %padrao MELF 0204 para temperatura
   mtbf_out(i) = mtbf_out(i)+capacitor(ta,47,v_c(i,4),70)+capacitor_c(ta,100e-6,v_c(i,6),100)+capacitor_c(ta,100e-6,v_c(i,7),100);
end
figure;
plot(p_s,10e6./mtbf_out,'*b');%tempo medio ate falha outros
title('Tempo medio até falha (Outros)')
xlabel('Potencia(W)'); 
ylabel('Tempo(H)');

mtbf = mtbf_out+mtbf_prot+mtbf_pre+mtbf_pot;
figure;
plot(p_s,10e6./mtbf,'*r'); %tempo medio ate falha completo
title('Tempo medio até falha (AMP COMPLETO)')
xlabel('Potencia(W)'); 
ylabel('Tempo(H)');

padrao_uso = normrnd(10,8,100000,1);
padrao_uso = padrao_uso(padrao_uso>0);
padrao_uso = padrao_uso(padrao_uso<35);
figure;
hist(padrao_uso,100);%plota padrao de uso
title('Distribuição do uso do AMP')
xlabel('Potencia(W)'); 
ylabel('Média de uso');

disp('Agora vai demorar um pouco 2 a 5 minutos');

figure;
for(i=1:4000)
padrao_uso = normrnd(10,8,3000,1);
padrao_uso = padrao_uso(padrao_uso>0);
padrao_uso = padrao_uso(padrao_uso<35);
buffer=histogram(padrao_uso,41); % padrao de uso
b = buffer.Values;
indice(i)=sum(b(1:41).*10e6./mtbf(1:41))/sum(b);%media ponderada
end
figure;
histogram(indice,30); % estima confibilidade do parametro
title('Distribuição 1/MTBF AMP');
xlabel('Tempo medio até falha'); 
ylabel('Valor normalizado');
%5
figure;
conf=normrnd(mean(indice),mean(indice)*0.10,10000,1);
conf = (exp((-1./conf.*438000)));%conf 50 anos
histogram(conf,100);
mx=mean(conf);
sx=std(conf);
upper_limit=mx+1.96*sx;
lower_limit=mx-1.96*sx;
i=0.9350:0.0001:0.9750;
p = zeros(size(i,2),1);
p(round(10000*(lower_limit-i(1)))) = 500;
p(round(10000*(upper_limit-i(1)))) = 500;
hold on
plot(i,p,'--R');
title('Confibilidade para 50 anos');
xlabel('confiança'); 
ylabel('Valor normalizado');
legend('histograma','intervalo de confiança 95%');

%medida de melhoria
%utilizando transistores com uma melhor discipação

mtbf_pre = zeros(1,length(p_r(:,1)));
ta = 30;
for i = 1:length(p_r(:,1)) 
   mtbf_pre(i) =  mtbf_pre(i)+resistor(ta,46,p_r(i,1),0.33)+resistor(ta,46,p_r(i,2),0.33)+resistor(ta,46,p_r(i,3),0.33)+resistor(ta,46,p_r(i,4),0.33); %padrao MELF 0204 para temperatura
   mtbf_pre(i) = mtbf_pre(i)+transistor(ta,100,p_t(i,1),v_t(i,1),45)+transistor(ta,100,p_t(i,2),v_t(i,2),45); %BC547C , BC807-40
   mtbf_pre(i) = mtbf_pre(i)+capacitor(ta,1,v_c(i,1),70)+capacitor(ta,2.2,v_c(i,2),70)+capacitor_c(ta,47e-3,v_c(i,3),100);
end

%potencia
%R6; R8; R9; R11; R12; C5; Q3 a Q6
mtbf_pot = zeros(1,length(p_r(:,1)));
for i = 1:length(p_r(:,1)) 
   mtbf_pot(i) =  mtbf_pot(i)+resistor(ta,46,p_r(i,6),1)+resistor(ta,46,p_r(i,8),0.33)+resistor(ta,46,p_r(i,9),0.33)+resistor(ta,46,p_r(i,11),0.33)+resistor(ta,46,p_r(i,12),1); %padrao MELF 0204 para temperatura
   mtbf_pot(i) = mtbf_pot(i)+transistor(ta,100,p_t(i,3),v_t(i,3),60)+transistor(ta,100,p_t(i,5),v_t(i,5),60)+transistor(ta,0.8,p_t(i,4),v_t(i,4),120)+transistor(ta,0.8,p_t(i,6),v_t(i,6),120); %BC547/bd137 , BC807-40/bd138 ,Mudou os trasistores 
   mtbf_pot(i) = mtbf_pot(i)+capacitor(ta,2200,v_c(5,1),60);
end

%proteção
%D1,D2,D3
mtbf_prot = zeros(1,length(p_r(:,1)));
for i = 1:length(p_r(:,1)) 
mtbf_prot(i) = diodo(ta,0.455,70)+diodo(ta,0.455,70)+diodo(ta,0.455,70); %1n4002
end

%outros
%R5 , R7 ,R10 ; C4, C6, c7

mtbf_out = zeros(1,length(p_r(:,1)));
for i = 1:length(p_r(:,1)) 
   mtbf_out(i) = mtbf_out(i)+resistor(ta,46,p_r(i,5),0.33)+resistor(ta,46,p_r(i,7),0.33)+resistor(ta,46,p_r(i,10),0.33); %padrao MELF 0204 para temperatura
   mtbf_out(i) = mtbf_out(i)+capacitor(ta,47,v_c(i,4),70)+capacitor_c(ta,100e-6,v_c(i,6),100)+capacitor_c(ta,100e-6,v_c(i,7),100);
end

mtbf = mtbf_out+mtbf_prot+mtbf_pre+mtbf_pot;
figure;
plot(p_s,10e6./mtbf,'*r'); %tempo medio ate falha completo
title('Tempo medio até falha (AMP COMPLETO) Melhorado')
xlabel('Potencia(W)'); 
ylabel('Tempo(H)');



