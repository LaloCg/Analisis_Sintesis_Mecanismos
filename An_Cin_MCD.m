% Programa para el Analisis Cinematico de un Manivela Corredera
% Método Lazo Vectorial
% Eduardo Cano G.

%% Declaracion de Variables

% Tamño de eslabones
a = 63; %L2
b = 130; %L3
c = 52; %Offset

% Coordenadas de Ox, Oy
Ox = 0; Oy = 0;

% theta 2
theta2d = 0:5:60;

% VELOCIDAD ANGULAR
w2 = 250;

% ACELERACION ANGULAR
alpha2 = 30;

% SACUDIMENTO ANGULAR
phi2 = 15;


%% Analisis de Pocisiones

% Posiciones de Ax , Ay
Ax = a*cosd(theta2d);
Ay = a*sind(theta2d);


% Angulo 3
argumento = -(a*sind(theta2d)-c)/b;
theta3da = asind(argumento)+360;


% Angulo 4
theta4da = 90;


d = a*cosd(theta2d) - b*cosd(theta3da);

% Posiciones de B

Bxa = d;
Bya = c;


% Corredera

B1x = Bxa - 2;
B1y = Bya + 0.5;

B2x = Bxa + 2;
B2y = Bya + 0.5;

B3x = Bxa + 2;
B3y = Bya - 0.5;

B4x = Bxa - 2;
B4y = Bya - 0.5;


%% Analisis de Velocidades

% VELOCIDAD ANGULAR w3
w3 = ((a.*w2)./(b)).*((sind(theta4da-theta2d))./(sind(theta3da-theta4da)));
w3deg = rad2deg(w3);

% VELOCIDAD LINEAL DE vA
vAx = -a.*w2.*sind(theta2d);
vAy = a.*w2.*cosd(theta2d);
vA = sqrt(vAx.^2 + vAy.^2);

% VELOCIDAD LINEAL DE vAB
vABx = -b.*w3.*sind(theta3da);
vABy = b.*w3.*cosd(theta3da);
vAB = sqrt(vABx.^2 + vABy.^2);

% VELOCIDAD LINEAL DE vBA
vBA = -vAB;

% VELOCIDAD LINEAL DE vB
vB = vA + vBA;




%% Analisis de Aceleraciones

% ACELERACION ANGULAR DE alpha3
alpha3 = ((a.*alpha2.*cosd(theta2d))-(a.*(w2.^2).*sind(theta2d))+(b.*(w3.^2).*sind(theta3da)))./(b.*cosd(theta3da));
alpha3deg = rad2deg(alpha3);

% ACELERACION DE ad
ad = -(a.*alpha2.*sind(theta2d))-(a.*(w2.^2).*cosd(theta2d))+(b.*alpha3.*sind(theta3da))+(b.*(w3.^2).*cosd(theta3da));

% ACELERACION ANGULAR DE aA
aAx = -a.*alpha2.*sind(theta2d)-a.*w2.^2.*cosd(theta2d);
aAy = a.*alpha2.*cosd(theta2d)-a.*w2.^2.*sind(theta2d);
aA = sqrt((aAx.^2)+(aAy.^2));

% ACELERACION ANGULAR DE aBA
aBAx = -b.*alpha3.*sind(theta3da)-b.*w3.^2.*cosd(theta3da);
aBAy = -b.*alpha3.*cosd(theta3da)-b.*w3.^2.*sind(theta3da);
aBA = sqrt((aBAx.^2)+(aBAy.^2));

% ACELERACION ANGULAR DE aB
aB = ad;


%% Analisis de Sacudimientos

% VARIABLES AUXILIARES ---SACUDIMIENTO---

phi3 = 0;

Aj = a.*w2.^3.*sind(theta2d);
Bj = 3.*a.*w2.*alpha2.*cosd(theta2d);
Cj = a.*phi2.*sind(theta2d);
Dj = b.*w3.^3.*sind(theta3da);
Ej = 3.*b.*w3.*alpha3.*cosd(theta3da);
Fj = b.*phi3.*sind(theta3da);

Gj = a.*w2.^3.*cosd(theta2d);
Hj = 3.*a.*w2.*alpha2.*sind(theta2d);
Kj = a.*phi2.*cosd(theta2d);
Lj = b.*w3.^3.*cosd(theta3da);
Mj = 3.*b.*w3.*alpha3.*sind(theta3da);
Nj = b.*cosd(theta3da);


% SACUDIMIENTO ANGULAR DE phi3
phi3 = (-Gj-Hj+Kj+Lj+Mj)./Nj;

% SACUDIMIENTO ANGULAR DE sd
sd = Aj-Bj-Cj-Dj+Ej+Fj;

% SACUDIMIENTO ANGULAR DE jA
jAx = a.*w2.^3.*sin(theta2d)-3.*a.*w2.*alpha2.*cos(theta2d)-a.*phi2.*sin(theta2d);
jAy = -a.*w2.^3.*cos(theta2d)-3.*a.*w2.*alpha2.*sin(theta2d)+a.*phi2.*cos(theta2d);
jA = sqrt((jAx.^2)+(jAy.^2));

% SACUDIMIENTO ANGULAR DE jBA
jBAx = -b.*w3.^3.*sin(theta3da)+3.*b.*w3.*alpha3.*cos(theta3da)+b.*phi3.*sin(theta3da);
jBAy = b.*w3.^3.*cos(theta3da)+3.*b.*w3.*alpha3.*sin(theta3da)-b.*phi3.*cos(theta3da);
jBA = sqrt((jBAx.^2)+(jBAy.^2));

% SACUDIMIENTO ANGULAR DE jB
jB = sd;

%% Grafica de Vectores de Velocidad
figure(20)
for k = 1 : length(theta2d)
    plot([Ox, Ax(k)] , [Oy, Ay(k)], '-or',...
        [Ax(k) , Bxa(k)] , [Ay(k) , Bya], '-og',...
        [B1x(k), B2x(k)] , [B1y, B2y], '-ob',...
        [B2x(k), B3x(k)] , [B2y, B3y], '-ob',...
        [B3x(k), B4x(k)] , [B3y, B4y], '-ob',...
        [B4x(k), B1x(k)] , [B4y, B1y], '-ob',...    
        'LineWidth',3);
    hold on;

    % POSICIONES
    plot(Ax(1:k), Ay(1:k), 'm.', 'LineWidth', 2); 
    plot(Bxa(1:k), Bya, 'k.', 'LineWidth', 2);

    % VELOCIDADES
    quiver(Ax(k),Ay(k),vAx(k),vAy(k),0.005,'color','#D95319','LineWidth',2);
    quiver(Bxa(k),Bya,vBA(k),0,0.005,'color','#7E2F8E','LineWidth',2);
    quiver(Bxa(k),Bya,vB(k),0,0.005,'color','#0072BD','LineWidth',2);
    

    axis([-250 100 -100 100])
    grid on
    axis square

    drawnow
    pause(0.01)
    hold off

end


%% Grafica de Vectores de Aceleracion
figure(21)
for k = 1 : length(theta2d)
    plot([Ox, Ax(k)] , [Oy, Ay(k)], '-or',...
        [Ax(k) , Bxa(k)] , [Ay(k) , Bya], '-og',...
        [B1x(k), B2x(k)] , [B1y, B2y], '-ob',...
        [B2x(k), B3x(k)] , [B2y, B3y], '-ob',...
        [B3x(k), B4x(k)] , [B3y, B4y], '-ob',...
        [B4x(k), B1x(k)] , [B4y, B1y], '-ob',...    
        'LineWidth',3);
    hold on;

    % POSICIONES
    plot(Ax(1:k), Ay(1:k), 'm.', 'LineWidth', 2); 
    plot(Bxa(1:k), Bya, 'k.', 'LineWidth', 2);

    % ACELERACIONES
    quiver(Ax(k),Ay(k),aAx(k),aAy(k),0.00005,'color','#D95319','LineWidth',2);
    quiver(Bxa(k),Bya,aBA(k),0,0.00008,'color','#7E2F8E','LineWidth',2);
    quiver(Bxa(k),Bya,aB(k),0,0.00008,'color','#0072BD','LineWidth',2);
    

    axis([-200 150 -100 100])
    grid on
    axis square

    drawnow
    pause(0.01)
    hold off

end


%% Grafica de thetha2 vs Velocidad

% thetha2 vs w3,w4
figure(22)
subplot(2,1,1)
vel_ang_matriz = w3;
plot(theta2d, vel_ang_matriz);
grid on
legend('w3')
title('Velocidades Angulares (rad s^-1)')
xlabel('Ángulo del eslabon motriz (\theta_2)')
ylabel('Vel Ang w_3 (rad s^-1)')

% thetha2 vs vA, vBA, vB, vPA, vP
subplot(2,1,2)
vel_lin_matriz = [vA; vBA; vB];
plot(theta2d, vel_lin_matriz);
grid on
legend('vA', 'vBA', 'vB')
title('Velocidades Lineales (m s^-1)')
xlabel('Ángulo del eslabon motriz (\theta_2)')
ylabel('Vel Lineales (m s^-1)')


%% Grafica de thetha2 vs Aceleracion
figure(23)
subplot(2,1,1)
a_ang_matriz = alpha3;
plot(theta2d, a_ang_matriz);
grid on
legend('alpha3')
title('Aceleraciones Angulares')
xlabel('Ángulo del eslabon motriz (\theta_2)')
ylabel('Ace Ang w_3 (rad s^-1)')

subplot(2,1,2)
a_lin_matriz = [aA; aBA; aB];
plot(theta2d, a_lin_matriz);
grid on
legend('aA', 'aBA', 'aB')
title('Aceleraciones Lineales')
xlabel('Ángulo del eslabon motriz (\theta_2)')
ylabel('Aceleraciones Lineales')


%% Grafica de thetha2 vs Sacudimiento
figure(24)
subplot(2,1,1)
j_ang_matriz = phi3;
plot(theta2d, j_ang_matriz);
grid on
legend('phi3')
title('Sacudimientos Angulares');
xlabel('Ángulo del eslabon motriz (\theta_2)');
ylabel('Sacudimientos Angulares');

subplot(2,1,2)
j_lin_matriz = [jA; jBA; jB];
plot(theta2d, j_lin_matriz);
grid on
legend('jA', 'jBA', 'jB')
title('Sacudimientos Lineales')
xlabel('Ángulo del eslabon motriz (\theta_2)')
ylabel('Sacudimientos Lineales')

