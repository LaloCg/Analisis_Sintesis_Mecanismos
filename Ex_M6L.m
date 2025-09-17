% Programa para analizar la posición de un M6L
% Método Lazo Vectorial
% Eduardo Cano G.

%% Analisis del M4L
%% Declaracion de variables

% TAMAÑO DE ESLABONES
a = 12; %L2
b = 24; %L3
c = 18; %L04b
d = sqrt(28^2 + 19^2); %L1

% COORDENADAS DE Ox, Oy y Qx, Qy
Ox = 0; Oy = 0;
Qx = 19; Qy = 28;

%theta2d = 0:5:35;

%ANGULO DE TRASLACION
theta1 = atan2d(28,19);

%Calculamos el angulo de agarrotamiento 
angulo_libertad = acosd((-(b+c)^2 + a^2 + d^2) / (2*a*d));
   
%Angulo de movilidad seccionada
% - ARRIBA
theta2a = angulo_libertad : -5 : 0;
% - ABAJO
thetab = 360 : -5 : (360 - angulo_libertad);

%ANGULO DE MOVILIDAD 
theta2d = [theta2a, thetab];


% VELOCIDAD ANGULAR
w2 = 15.71;
w2 = rad2deg(w2);

% ACELERACION ANGULAR
alpha2 = 0;
alpha2 = rad2deg(alpha2);

% SACUDIMENTO ANGULAR
%phi2 = 5;

% VARIABLES AUXILIARES ---POCISION---

k1 = d/a;
k2 = d/c;
k3 = (a^2 - b^2 + c^2 + d^2)/(2*a*c);

k4 = d/b;
k5 = d/a;
k6 = (c^2 - a^2 - b^2 - d^2)/(2*a*b);

A = -k1 + cosd(theta2d) - k2.*cosd(theta2d) + k3;
B = -2.*sind(theta2d);
C = k1 - cosd(theta2d) - k2.*cosd(theta2d) + k3;

D = -k5 + cosd(theta2d) + k4.*cosd(theta2d) + k6;
E = -2.*sind(theta2d);
F = k5 - cosd(theta2d) + k4.*cosd(theta2d) + k6;



%% Analisis de Pocisiones

% THETA 3
indexR = E.^2 - 4.*D.*F > 0;
theta3da = zeros(1, length(indexR));
theta3dc = zeros(1, length(indexR));
contador = 1;
for k=1 : length(theta2d)

    if indexR(k) == 1 

        theta3da(contador) = 2*atan2d((-E(k) - sqrt(E(k).^2 - 4.*D(k).*F(k))) , (2.*D(k)));
        theta3dc(contador) = 2*atan2d((-E(k) + sqrt(E(k).^2 - 4.*D(k).*F(k))) , (2.*D(k)));

        contador = contador + 1;

    else

    end

end


% THETA 4
indexS = B.^2 - 4.*A.*C > 0;
theta4da = zeros(1, length(indexS));
theta4dc = zeros(1, length(indexS));
contador = 1;
for k=1 : length(theta2d)

    if indexS(k) == 1 

        theta4da(contador) = 2*atan2d((-B(k) + sqrt(B(k).^2 - 4.*A(k).*C(k))) , (2.*A(k)));
        theta4dc(contador) = 2*atan2d((-B(k) - sqrt(B(k).^2 - 4.*A(k).*C(k))) , (2.*A(k)));

        contador = contador + 1;

    else

    end

end


% POSICIONES DE Ax y Ay
Ax =  a.*cosd(theta2d + theta1);
Ay =  a.*sind(theta2d + theta1);


% POSICIONES DE Bx y By
Bxa = Ax + b.*cosd(theta3da + theta1);
Bya = Ay + b.*sind(theta3da + theta1);


%% Analisis de Velocidades

% VELOCIDAD ANGULAR w3
w3 = ((a.*w2)./(b)).*((sind(theta4da-theta2d))./(sind(theta3da-theta4da)));
w3deg = rad2deg(w3);

% VELOCIDAD ANGULAR w4
w4 = ((a.*w2)./(c)).*((sind(theta2d-theta3da))./(sind(theta4da-theta3da)));
w4deg = rad2deg(w4);

% VELOCIDAD LINEAL DE vA
vAx = -a.*w2.*sind(theta2d);
vAy = a.*w2.*cosd(theta2d);
vA = sqrt(vAx.^2 + vAy.^2);

% VELOCIDAD LINEAL DE vBA
vBAx = -b.*w3.*sind(theta3da);
vBAy = b.*w3.*cosd(theta3da);
vBA = sqrt(vBAx.^2 + vBAy.^2);

% VELOCIDAD LINEAL DE vB
vBx = -c.*w4.*sind(theta4da);
vBy = c.*w4.*cosd(theta4da);
vB = sqrt(vBx.^2 + vBy.^2);


%% Analisis de Aceleraciones

% VARIABLES AUXILIARES ---ACELERACION---

Aa = c.*sind(theta4da);
Ba = b.*sind(theta3da);
Ca = a.*alpha2.*sind(theta2d)+a.*w2.^2.*cosd(theta2d)+b.*w3.^2.*cosd(theta3da)-c.*w4.^2.*cosd(theta4da);
Da = c.*cosd(theta4da);
Ea = b.*cosd(theta3da);
Fa = a.*alpha2.*cosd(theta2d)-a.*w2.^2.*sind(theta2d)-b.*w3.^2.*sind(theta3da)+c.*w4.^2.*sind(theta4da);

% ACELERACION ANGULAR DE alpha3
alpha3 = (Ca.*Da-Aa.*Fa)./(Aa.*Ea-Ba.*Da);
alpha3deg = rad2deg(alpha3);

% ACELERACION ANGULAR DE alpha4
alpha4 = (Ca.*Ea-Ba.*Fa)./(Aa.*Ea-Ba.*Da);
alpha4deg = rad2deg(alpha4);

% ACELERACION ANGULAR DE aA
aAx = -a.*alpha2.*sind(theta2d)-a.*w2.^2.*cosd(theta2d);
aAy = a.*alpha2.*cosd(theta2d)-a.*w2.^2.*sind(theta2d);
aA = sqrt((aAx.^2)+(aAy.^2));

% ACELERACION ANGULAR DE aBA
aBAx = -b.*alpha3.*sind(theta3da)-b.*w3.^2.*cosd(theta3da);
aBAy = -b.*alpha3.*cosd(theta3da)-b.*w3.^2.*sind(theta3da);
aBA = sqrt((aBAx.^2)+(aBAy.^2));

% ACELERACION ANGULAR DE aB
aBx = -c.*alpha4.*sind(theta4da)-c.*w4.^2.*cosd(theta4da);
aBy = c.*alpha4.*cosd(theta4da)-c.*w4.^2.*sind(theta4da);
aB = sqrt((aBx.^2)+(aBy.^2));


%% Analisis de Sacudimientos

% VARIABLES AUXILIARES ---SACUDIMIENTO---
%{
Aj = a.*w2.^3.*sind(theta2d);
Bj = 3.*a.*w2.*alpha2.*cosd(theta2d);
Cj = a.*phi2.*sind(theta2d);
Dj = b.*w3.^3.*sind(theta3da);
Ej = 3.*b.*w3.*alpha3.*cosd(theta3da);
Fj = c.* w4.^3.*sind(theta4da);
Gj = 3.*c.*w4.*alpha4.*cosd(theta4da);
Hj = c.*sind(theta4da);
Kj = b.*sind(theta3da);

Lj = a.*w2.^3.*cosd(theta2d);
Mj = 3.*a.*w2.*alpha2.*sind(theta2d);
Nj = a.*phi2.*cosd(theta2d);
Pj = b.*w3.^3.*cosd(theta3da);
Qj = 3.*b.*w3.*alpha3.*sind(theta3da);
Rj = b.*cosd(theta3da);
Sj = c.*w4.^3.*cosd(theta4da);
Tj = 3.*c.*w4.*alpha4.*sind(theta4da);
Uj = c.*cosd(theta4da);

% SACUDIMIENTO ANGULAR DE phi4
phi4 = (Kj.*Nj-Kj.*Lj-Kj.*Mj-Kj.*Pj-Kj.*Qj+Aj.*Rj-Bj.*Rj-Cj.*Rj+Dj.*Rj-Ej.*Rj-Fj.*Rj+Gj.*Rj+Kj.*Sj+Kj.*Tj)./(Kj.*Uj-Hj.*Rj);

% SACUDIMIENTO ANGULAR DE phi3
phi3 = (Aj-Bj-Cj+Dj-Ej-Fj+Gj+Hj.*phi4)./Kj;

% SACUDIMIENTO ANGULAR DE jA
jAx = a.*w2.^3.*sin(theta2d)-3.*a.*w2.*alpha2.*cos(theta2d)-a.*phi2.*sin(theta2d);
jAy = -a.*w2.^3.*cos(theta2d)-3.*a.*w2.*alpha2.*sin(theta2d)+a.*phi2.*cos(theta2d);
jA = sqrt((jAx.^2)+(jAy.^2));

% SACUDIMIENTO ANGULAR DE jBA
jBAx = b.*w3.^3.*sin(theta3da)-3.*b.*w3.*alpha3.*cos(theta3da)-b.*phi3.*sin(theta3da);
jBAy = -b.*w3.^3.*cos(theta3da)-3.*b.*w3.*alpha3.*sin(theta3da)+b.*phi3.*cos(theta3da);
jBA = sqrt((jBAx.^2)+(jBAy.^2));

% SACUDIMIENTO ANGULAR DE jB
jBx = c.*w4.^3.*sin(theta4da)-3.*c.*w4.*alpha4.*cos(theta4da)-c.*phi4.*sin(theta4da);
jBy = -c.*w4.^3.*cos(theta4da)-3.*c.*w4.*alpha4.*sin(theta4da)+c.*phi4.*cos(theta4da);
jB = sqrt((jBx.^2)+(jBy.^2));

%}


%% Analisis del M4L M-C
%% Declaracion de variables

% TAMAÑO DE ESLABONES
f = 18; %L04C
g = 24; %L5
h = 46.5 - 19; %L6
% L7  calcular

%El ángulo de rotacion del balancin theta5
   
theta5 = theta4dc - 180 + theta1;


%% Analisis de Posicion

% THETA 6 
theta6 = acosd((-h + f.*cosd(theta5)) ./ (g));

% LONGITUD DEL ESLABON L7
m = f.*sind(theta5) - g.*sind(theta6); % L7

% THETA 7
theta7 = 0;      

% POSICIONES DE Cx y Cy
Cx = Qx + f.*cosd(theta5);
Cy = Qy + f.*sind(theta5);

% POSICIONES DE Dx y Dy
Dx = h + Qx;
Dy = m + Qy;


%% Analisis de Velocidades

% VELOCIDAD ANGULAR w3
w5 = (f./g).*((cosd(theta5))./(cosd(theta6))).*w4;
w3deg_mc = rad2deg(w5);

% VELOCIDAD LINEAL DE vC
vCx = -a.*w4.*sind(theta5);
vCy = a.*w4.*cosd(theta5);
vC = sqrt(vCx.^2 + vCy.^2);

% VELOCIDAD LINEAL DE vCD
vCDx = -b.*w5.*sind(theta6);
vCDy = b.*w5.*cosd(theta6);
vCD = sqrt(vCDx.^2 + vCDy.^2);

% VELOCIDAD LINEAL DE vDC
vDC = -vCD;

% VELOCIDAD LINEAL DE vD
vD = vC + vDC;


%% Analisis de Aceleraciones

% ACELERACION ANGULAR DE alpha3
alpha5 = ((f.*alpha4.*cosd(theta5))-(f.*(w4.^2).*sind(theta5))+(g.*(w5.^2).*sind(theta6)))./(g.*cosd(theta6));
alpha5deg = rad2deg(alpha5);

% ACELERACION DE ad
ad = -(f.*alpha4.*sind(theta5))-(f.*(w4.^2).*cosd(theta5))+(g.*alpha5.*sind(theta6))+(g.*(w5.^2).*cosd(theta6));

% ACELERACION ANGULAR DE aC
aCx = -f.*alpha4.*sind(theta5)-f.*w4.^2.*cosd(theta5);
aCy = f.*alpha4.*cosd(theta5)-f.*w4.^2.*sind(theta5);
aC = sqrt((aCx.^2)+(aCy.^2));

% ACELERACION ANGULAR DE aDC
aDCx = -g.*alpha5.*sind(theta6)-g.*w3.^2.*cosd(theta6);
aDCy = -b.*alpha5.*cosd(theta6)-b.*w3.^2.*sind(theta6);
aDC = sqrt((aDCx.^2)+(aDCy.^2));

% ACELERACION ANGULAR DE aD
aD = ad;


%% Analisis de Sacudimientos

% VARIABLES AUXILIARES ---SACUDIMIENTO---

%{
phi5 = 0;

Aj_mc = f.*w4.^3.*sind(theta5);
Bj_mc = 3.*f.*w4.*alpha4.*cosd(theta5);
Cj_mc = f.*phi4.*sind(theta5);
Dj_mc = g.*w5.^3.*sind(theta6);
Ej_mc = 3.*g.*w5.*alpha5.*cosd(theta6);
Fj_mc = g.*phi5.*sind(theta6);

Gj = f.*w4.^3.*cosd(theta5);
Hj = 3.*f.*w4.*alpha4.*sind(theta5);
Kj = f.*phi2.*cosd(theta5);
Lj = g.*w5.^3.*cosd(theta6);
Mj = 3.*g.*w5.*alpha5.*sind(theta6);
Nj = g.*cosd(theta6);


% SACUDIMIENTO ANGULAR DE phi3
phi5 = (-Gj-Hj+Kj+Lj+Mj)./Nj;

% SACUDIMIENTO ANGULAR DE sd
sd = Aj_mc-Bj_mc-Cj_mc-Dj_mc+Ej_mc+Fj_mc;

% SACUDIMIENTO ANGULAR DE jC
jAx = f.*w4.^3.*sin(theta5)-3.*f.*w4.*alpha2.*cos(theta5)-f.*phi4.*sin(theta5);
jAy = -f.*w4.^3.*cos(theta5)-3.*f.*w4.*alpha2.*sin(theta5)+f.*phi4.*cos(theta5);
jA = sqrt((jAx.^2)+(jAy.^2));

% SACUDIMIENTO ANGULAR DE jDC
jBAx = -f.*w5.^3.*sin(theta5)+3.*f.*w5.*alpha3.*cos(theta5)+f.*phi5.*sin(theta5);
jBAy = f.*w5.^3.*cos(theta5)+3.*f.*w5.*alpha3.*sin(theta5)-f.*phi5.*cos(theta5);
jBA = sqrt((jBAx.^2)+(jBAy.^2));

% SACUDIMIENTO ANGULAR DE jD
jB = sd;

%}

%% GRAFICA DE VELOCIDADES
figure(20)
for k = 1 : length(theta2d)

        plot( [Ox, Ax(k)] , [Oy, Ay(k)], '-r',...
            [Ax(k), Bxa(k)] , [Ay(k) , Bya(k)] , '-g' , ...
            [Bxa(k) , Qx] , [Bya(k) , Qy] , '-b' , ...
            [Qx, Cx(k)], [Qy, Cy(k)],'-ob', ...
            [Cx(k), Dx],[Cy(k), Dy(k)],'-og', ...
            'LineWidth',2);
        hold on;
        plot(Ax(1:k), Ay(1:k), 'm.', 'LineWidth', 2); 
        plot(Bxa(1:k), Bya(1:k), 'k.', 'LineWidth', 2);

        % VELOCIDADES M4L
        quiver(Ax(k),Ay(k),vAx(k),vAy(k),0.001,'color','#D95319','LineWidth',2); % vA
        quiver(Bxa(k),Bya(k),vBAx(k),vBAy(k),0.001,'color','#7E2F8E','LineWidth',2); % vBA
        quiver(Bxa(k),Bya(k),vBx(k),vBy(k),0.001,'color','#7E2F8E','LineWidth',2); % vB

        % VELOCIDADES M4L M-C
        quiver(Cx(k),Cy(k),vCx(k),vCy(k),0.001,'color','#D95319','LineWidth',2); % vC
        %quiver(Dx,Dy(k),vDC(k),0,0.001,'color','#7E2F8E','LineWidth',2); % vDC
        quiver(Dx,Dy(k),vD(k),0,0.001,'color','#0072BD','LineWidth',2); % vD

    
        axis([-25 55 -20 60])
        grid on
        axis square
    
        drawnow
        pause(0.01)
        hold off
        
end


%% GRAFICA DE ACELERACIONES
figure(21)
for k = 1 : length(theta2d)

        plot( [Ox, Ax(k)] , [Oy, Ay(k)], '-r',...
            [Ax(k), Bxa(k)] , [Ay(k) , Bya(k)] , '-g' , ...
            [Bxa(k) , Qx] , [Bya(k) , Qy] , '-b' , ...
            [Qx, Cx(k)], [Qy, Cy(k)],'-ob', ...
            [Cx(k), Dx],[Cy(k), Dy(k)],'-og', ...
            'LineWidth',2);
        hold on;
        plot(Ax(1:k), Ay(1:k), 'm.', 'LineWidth', 2); 
        plot(Bxa(1:k), Bya(1:k), 'k.', 'LineWidth', 2);

        % ACELERACIONES M4L
        quiver(Ax(k),Ay(k),aCx(k),aCy(k),0.00000001,'color','#D95319','LineWidth',2); % aA
        quiver(Bxa(k),Bya(k),aBAx(k),aBAy(k),0.0000005,'color','#7E2F8E','LineWidth',2); %aBA
        quiver(Bxa(k),Bya(k),aBx(k),aBy(k),0.00000001,'color','#7E2F8E','LineWidth',2); % aB
        

         % ACELERACIONES M4L M-C
        quiver(Cx(k),Cy(k),aCx(k),aCy(k),0.0000005,'color','#D95319','LineWidth',2); %aC
        %quiver(Dx,Dy(k),aDC(k),0,0.00008,'color','#7E2F8E','LineWidth',2); %aDC
        quiver(Dx,Dy(k),aD(k),0,0.0000008,'color','#0072BD','LineWidth',2); %aD
    
        axis([-25 55 -20 60])
        grid on
        axis square
    
        drawnow
        pause(0.01)
        hold off
        
end


%% Grafica de thetha2 vs Velocidad

% thetha2 vs w3,w4,w5
figure(22)
subplot(2,1,1)
vel_ang_matriz = [w3; w4; w5];
plot(theta2d, vel_ang_matriz);
grid on
legend('w3', 'w4', 'w5')
title('Velocidades Angulares (rad s^-1)')
xlabel('Ángulo del eslabon motriz (\theta_2)')
ylabel('Vel Ang w_3, w_4 y w_5 (rad s^-1)')

% thetha2 vs vA, vBA, vB, vC, vD
subplot(2,1,2)
vel_lin_matriz = [vA; vBA; vB; vC; vD];
plot(theta2d, vel_lin_matriz);
grid on
legend('vA', 'vBA', 'vB', 'vC', 'vD')
title('Velocidades Lineales (cm s^-1)')
xlabel('Ángulo del eslabon motriz (\theta_2)')
ylabel('Vel Lineales (cm s^-1)')


%% Grafica de thetha2 vs Aceleracion
figure(23)
subplot(2,1,1)
a_ang_matriz = [alpha3; alpha4; alpha5];
plot(theta2d, a_ang_matriz);
grid on
legend('alpha3', 'alpha4', 'alpha5')
title('Aceleraciones Angulares')
xlabel('Ángulo del eslabon motriz (\theta_2)')
ylabel('Ace Ang w_3, w_4 y w_5 (rad s^-1)')

subplot(2,1,2)
a_lin_matriz = [aA; aBA; aB; aC; aD];
plot(theta2d, a_lin_matriz);
grid on
legend('aA', 'aBA', 'aB', 'aC', 'aD')
title('Aceleraciones Lineales')
xlabel('Ángulo del eslabon motriz (\theta_2)')
ylabel('Aceleraciones Lineales')

