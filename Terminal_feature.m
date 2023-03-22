% plot de gráfico Tensão de terminal X Corrente de linha de 
% um gerador síncrono para um fator de potência de 0.8 atrasado.

clc; close all; 

% Inicialização das variáveis:
Ia = (0:1:20)*3;
v_phase = zeros(1,21);
Ea = 277.12;
theta = 36.86 * 2*pi/180;
Xs = 1.0;

% Cálculo do v_phase para cada Ia:
for i = 1:21
    V_phase = sqrt(Ea^2 -(Xs * Ia(i)*cos(theta))^2) - (Xs * Ia(i)*sin(theta));
end

Vt = V_phase * sqrt(3);

figure(1)
plot(Ia, Vt, 'k', 'LineWidth', 2.0), grid on;
xlabel('Corrente de Linha');
ylabel('Tensão de Terminal');
title('Característica de terminal para carga de FP 0.8 atr.');
axis([0 60 400 550])