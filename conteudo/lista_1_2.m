simulacoes = 100000;
E  = normrnd(12,1.2,1,simulacoes);
R1 = normrnd(30,3,1,simulacoes);
R2 = normrnd(30,3,1,simulacoes);

saida = (E./R1).*((R1.*R2)/(R1+R2));
saida_erro_1 = saida(saida<5.7);
saida_erro_2 = saida(saida>6.3);
prob = (length(saida_erro_1)+length(saida_erro_2))/simulacoes;
figure;
hist(saida,120);
title(sprintf( 'Histograma da distribuição resultante com (%d) amostras gerando uma aceitação de (%d)%%',simulacoes, (1-prob*100) ));
legend('sin(x)');
