% Programa para el Analisis Cinematico de un M4L
% Método Lazo Vectorial
% Eduardo Cano G.


%% Declaracion de variables

% TAMAÑO DE ESLABONES
a = 7; %L2
b = 11; %L3
c = 8; %L4
d = 11; %L1
ap = 18;
gamma = 42;


% COORDENADAS DE Ox, Oy y Qx, Qy
Ox = 0; Oy = 0;
Qx = d; Qy = 0;

theta2d = 0:5:65;

% VELOCIDAD ANGULAR
w2 = 30;
w2 = rad2deg(w2);

% ACELERACION ANGULAR
alpha2 = 10;
alpha2 = rad2deg(alpha2);

% SACUDIMENTO ANGULAR
phi2 = 5;

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
indexR2 = 2.*D ~= 0;
theta3da = zeros(1, length(indexR));
theta3dc = zeros(1, length(indexR));
contador = 1;
for k=1 : length(theta2d)

    if indexR(k) == 1 && indexR2(k) == 1

        theta3da(contador) = 2*atand((-E(k) + sqrt(E(k).^2 - 4.*D(k).*F(k))) ./ (2.*D(k)));
        theta3dc(contador) = 2*atand((-E(k) - sqrt(E(k).^2 - 4.*D(k).*F(k))) ./ (2.*D(k)));

        contador = contador + 1;

    else

    end

end



% THETA 4
indexS = B.^2 - 4.*A.*C > 0;
indexS2 = 2.*A ~= 0;
theta4da = zeros(1, length(indexS));
theta4dc = zeros(1, length(indexS));
contador = 1;
for k=1 : length(theta2d)

    if indexS(k) == 1 && indexS2(k) == 1

        theta4da(contador) = 2*atand((-B(k) + sqrt(B(k).^2 - 4.*A(k).*C(k))) ./ (2.*A(k)));
        theta4dc(contador) = 2*atand((-B(k) - sqrt(B(k).^2 - 4.*A(k).*C(k))) ./ (2.*A(k)));

        contador = contador + 1;

    else

    end

end



% POCISIONES DE Ax y Ay
Ax = zeros(1, length(indexR));
Ay = zeros(1, length(indexR));
contador = 1;
for k=1 : length(theta2d)

    if indexR(k) == 1 && indexR2(k) == 1

        Ax(contador) =  a.*cosd(theta2d(k));
        Ay(contador) =  a.*sind(theta2d(k));
        
        contador = contador + 1;   

    else

    end

end



% POSICIONES DE Bx y By
Bxa = c.*cosd(theta4da) + d;
Bya = c.*sind(theta4da);



% POSICIONES DE P
Pxa = Ax + ap.*cosd(theta3da + gamma);
Pya = Ay + ap.*sind(theta3da + gamma);

Pxc = Ax + ap.*cosd(theta3dc);
Pyc = Ay + ap.*sind(theta3dc);


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

% VELOCIDAD LINEAL DE vPA
vPAx = ap.*w3.*(-sind(theta3da+gamma));
vPAy = ap.*w3.*cosd(theta3da+gamma);
vPA = sqrt(vPAx.^2 + vPAy.^2);

% VELOCIDAD LINEAL DE vP
vP=vA+vPA;



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

% ACELERACION ANGULAR DE aPA
aPAx = ap.*alpha3.*(-sind(theta3da+gamma))-ap.*w3.^2.*(cosd(theta3da+gamma));
aPAy = ap.*alpha3.*(cosd(theta3da+gamma))-ap.*w3.^2.*(sind(theta3da+gamma));
aPA = sqrt((aPAx.^2)+(aPAy.^2));

% ACELERACION ANGULAR DE aP
aP = aA +aPA;


%% Analisis de Sacudimientos

% VARIABLES AUXILIARES ---SACUDIMIENTO---

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


%% Grafica de Vectores de Velocidad

figure(20)
%subplot(131)
contador = 1;
for k = 1 : length(indexR) 

    if indexR(k) == 1 && indexR2(k) == 1
        plot([Ox, Ax(contador)] , [Oy, Ay(contador)], '-or',...
            [Ax(contador) , Bxa(contador)] , [Ay(contador) , Bya(contador)], '-og',...
            [Bxa(contador) , Qx] , [Bya(contador) , Qy] , '-ob' , ...
            [Ax(contador) , Pxa(contador)] , [Ay(contador) , Pya(contador)], '-k',...
            [Pxa(contador) , Bxa(contador)] , [Pya(contador) , Bya(contador)], '-k',...
            'LineWidth',3);
    
        hold on;
        % POSICIONES
        plot(Ax(1:contador), Ay(1:contador), 'm.', 'LineWidth', 2); 
        plot(Bxa(1:contador), Bya(1:contador), 'g.', 'LineWidth', 2);
        plot(Pxa(1:contador), Pya(1:contador), 'b-', 'LineWidth', 2);
        %plot(Pxc(1:contador), Pyc(1:contador), 'k-', 'LineWidth', 2);

        % VELOCIDADES
        quiver(Ax(contador),Ay(contador),vAx(contador),vAy(contador),0.001,'color','#D95319','LineWidth',2);
        quiver(Bxa(contador),Bya(contador),vBAx(contador),vBAy(contador),0.001,'color','#7E2F8E','LineWidth',2);
        quiver(Bxa(contador),Bya(contador),vBx(contador),vBy(contador),0.001,'color','#7E2F8E','LineWidth',2);
        quiver(Pxa(contador),Pya(contador),vPAx(contador),vPAy(contador),0.0005,'color','#77AC30','LineWidth',2);
        quiver(Pxa(contador),Pya(contador),0,vP(contador),0.0005,'color','#4DBEEE','LineWidth',2);

    
       
        axis([-20 50 -30 40])
        grid on
        axis square
    
        drawnow
        pause(0.1)
        hold off

        contador = contador + 1;
    
        else
    end
end



%% Grafica de Vectores de Aceleracion

figure(21)
%subplot(131)
contador = 1;
for k = 1 : length(indexR) 

    if indexR(k) == 1 && indexR2(k) == 1
        plot([Ox, Ax(contador)] , [Oy, Ay(contador)], '-or',...
            [Ax(contador) , Bxa(contador)] , [Ay(contador) , Bya(contador)], '-og',...
            [Bxa(contador) , Qx] , [Bya(contador) , Qy] , '-ob' , ...
            [Ax(contador) , Pxa(contador)] , [Ay(contador) , Pya(contador)], '-k',...
            [Pxa(contador) , Bxa(contador)] , [Pya(contador) , Bya(contador)], '-k',...
            'LineWidth',3);
    
        hold on;
        % POSICIONES
        plot(Ax(1:contador), Ay(1:contador), 'm.', 'LineWidth', 2); 
        plot(Bxa(1:contador), Bya(1:contador), 'g.', 'LineWidth', 2);
        plot(Pxa(1:contador), Pya(1:contador), 'b-', 'LineWidth', 2);
        %plot(Pxc(1:contador), Pyc(1:contador), 'k-', 'LineWidth', 2);

        % ACELERACIONES
        quiver(Ax(contador),Ay(contador),aAx(contador),aAy(contador),0.0000005,'color','#D95319','LineWidth',2);
        quiver(Bxa(contador),Bya(contador),aBAx(contador),aBAy(contador),0.0000005,'color','#7E2F8E','LineWidth',2);
        quiver(Bxa(contador),Bya(contador),aBx(contador),aBy(contador),0.0000005,'color','#7E2F8E','LineWidth',2);
        quiver(Pxa(contador),Pya(contador),aPAx(contador),aPAy(contador),0.0000005,'color','#77AC30','LineWidth',2);
        quiver(Pxa(contador),Pya(contador),0,aP(contador),0.0000005,'color','#77AC30','LineWidth',2);

    
       
        axis([-15 30 -20 20])
        grid on
        axis square
    
        drawnow
        pause(0.1)
        hold off

        contador = contador + 1;
    
        else
    end
end


%% Grafica de thetha2 vs Velocidad

% thetha2 vs w3,w4
figure(22)
subplot(2,1,1)
vel_ang_matriz = [w3; w4];
plot(theta2d, vel_ang_matriz);
grid on
legend('w3', 'w4')
title('Velocidades Angulares (rad s^-1)')
xlabel('Ángulo del eslabon motriz (\theta_2)')
ylabel('Vel Ang w_3 y w_4 (rad s^-1)')

% thetha2 vs vA, vBA, vB, vPA, vP
subplot(2,1,2)
vel_lin_matriz = [vA; vBA; vB; vPA; vP];
plot(theta2d, vel_lin_matriz);
grid on
legend('vA', 'vBA', 'vB', 'vPA', 'vP')
title('Velocidades Lineales (m s^-1)')
xlabel('Ángulo del eslabon motriz (\theta_2)')
ylabel('Vel Lineales (m s^-1)')


%% Grafica de thetha2 vs Aceleracion
figure(23)
subplot(2,1,1)
a_ang_matriz = [alpha3; alpha4];
plot(theta2d, a_ang_matriz);
grid on
legend('alpha3', 'alpha4')
title('Aceleraciones Angulares')
xlabel('Ángulo del eslabon motriz (\theta_2)')
ylabel('Ace Ang w_3 y w_4 (rad s^-1)')

subplot(2,1,2)
a_lin_matriz = [aA; aBA; aB; aPA; aP];
plot(theta2d, a_lin_matriz);
grid on
legend('aA', 'aBA', 'aB', 'aPA', 'aP')
title('Aceleraciones Lineales')
xlabel('Ángulo del eslabon motriz (\theta_2)')
ylabel('Aceleraciones Lineales')


%% Grafica de thetha2 vs Sacudimiento
figure(24)
subplot(2,1,1);
j_ang_matriz = [phi3; phi4];
plot(theta2d, j_ang_matriz);
grid on
legend('phi3', 'phi4')
title('Sacudimientos Angulares');
xlabel('Ángulo del eslabon motriz (\theta_2)');
ylabel('Sacudimientos Angulares');

subplot(2,1,2)
j_lin_matriz = [jA; jBA; jB]; %  jPA; aP
plot(theta2d, j_lin_matriz);
grid on
legend('jA', 'jBA', 'aB')
title('Sacudimientos Lineales')
xlabel('Ángulo del eslabon motriz (\theta_2)')
ylabel('Sacudimientos Lineales')