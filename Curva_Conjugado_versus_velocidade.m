% M-file: torque_speed_curve.m
% M-file para criar um gráfico da curva de conjugado versus velocidade
% (torque-speed curve) do motor de indução do Exemplo 6-5.
% Primeiro, inicialize os valores necessários ao programa.
r1 = 0.641; % Resistência do estator
x1 = 1.106; % Reatância do estator
r2 = 0.332; % Resistência do rotor
x2 = 0.464; % Reatância do rotor
xm = 26.3; % Reatância do ramo de magnetização
v_phase = 460 / sqrt(3); % Tensão de fase
n_sync = 1800; % Velocidade síncrona (rpm)
w_sync = 188.5; % Velocidade síncrona (rad/s)
% Calcule a tensão e a impedância de Thévenin com as Equações
% 6-41a e 6-43.
v_th = v_phase * (xm / sqrt(r1^2 + (x1 + xm)^2)) ;
z_th = ((j*xm) * (r1 + j*x1)) / (r1 + j*(x1 + xm));
r_th = real(z_th);
x_th = imag(z_th);

% Agora, calcule a característica de conjugado X velocidade para diversos
% escorregamentos entre 0 e 1. Observe que o primeiro valor de escorregamento
% é ajustado para 0,001 em vez de exatamente 0 para evitar problemas de
% divisão por zero.
s = (0:1:50) / 50; % Escorregamento
s(1) = 0.001;
nm = (1 - s) * n_sync; % Velocidade mecânica

% Calcule o conjugado para a resistência de rotor original
for ii = 1:51
 t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) /...
 (w_sync * ((r_th + r2/s(ii))^2 + (x_th + x2)^2)) ;
end

% Calcule o conjugado para a resistência de rotor dobrada
for ii = 1:51
 t_ind2(ii) = (3 * v_th^2 * (2*r2) / s(ii)) /...
 (w_sync * ((r_th + (2*r2)/s(ii))^2 + (x_th + x2)^2)) ;
end

% Plote a curva de conjugado X velocidade
plot(nm,t_ind1,'Color','b','LineWidth',2.0);
hold on;
plot(nm,t_ind2,'Color','k','LineWidth',2.0,'LineStyle','-.');
xlabel('\bf\itn_{m}');
ylabel('\bf\tau_{ind}');
title ('\bfCaracterística de conjugado versus velocidade do motor de indução');
legend ('R_{2} Original','R_{2} Dobrada');
grid on;
hold off;