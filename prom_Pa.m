% Programa: Analizis de Posicion Mediante El MEOTODO DE LAZOS VECTORIALES
% - Hernández Domínguez Angel Paul

%% Declaracion de los valores conocidos 
a = 12; % L2
b = 24; % L3
c = 18; % L4
d = ((28) / (sind(55.8))); % L1

p = 0.97;

Qx = 19;  Qy = 28; % Longitud del L1
Ox = 0;  Oy = 0; % Coordenadas del Origen

%% Variables auxiliares 
k1 = d / a; 
k2 = d / c; 
k3 = (a^2 - b^2 + c^2 + d^2)/(2*a*c); 

k4 = d / b;
k5 = d / a;
k6 = (c^2 - a^2 - b^2 - d^2)/(2*a*b);

%% ANALISIS DEL PRIMER MECANISMO

%ANGULO DE TRASLACION
theta_aux = floor(atan2d(28,19));
%Calculamos el angulo de agarrotamiento 
angulo_libertad = floor (acosd((-(b+c)^2 + a^2 + d^2) / (2*a*d)));
   
%Angulo de movilidad seccionada
% - ARRIBA
theta2dprima = angulo_libertad : -5 : 0;
% - ABAJO
theta2dbiprima = 360 : -5 : floor(360 - angulo_libertad);

%ANGULO DE MOVILIDAD 
theta2d = [theta2dprima, theta2dbiprima];

A = -k1 + cosd(theta2d) - k2.*(cosd(theta2d)) + k3; 
B = -2.*sind(theta2d);                              
C = k1 - cosd(theta2d) - k2.*cosd(theta2d) + k3;    
    
P = k4*cosd(theta2d) - k5 + cosd(theta2d) + k6;
Q = -2*sind(theta2d);
R = k5 - cosd(theta2d) + k4*cosd(theta2d) + k6;

Ay = a.*sind(theta2d + theta_aux); 
Ax = a.*cosd(theta2d + theta_aux);

theta4da = 2.*atan2d(-B + sqrt(B.^2 - 4.*A.*C), 2.*A);
theta4dc = 2.*atan2d(-B - sqrt(B.^2 - 4.*A.*C), 2.*A);

theta3dc = 2.*atan2d(-Q - sqrt(Q.^2 - 4.*P.*R), 2.*P);
theta3da = 2.*atan2d(-Q + sqrt(Q.^2 - 4.*P.*R), 2.*P);

Bxc = Ax + b*cosd(theta3dc + theta_aux);
Byc = Ay + b*sind(theta3dc + theta_aux);

Bxa = Ax + b*cosd(theta3da + theta_aux);
Bya = Ay + b*sind(theta3da + theta_aux);


%% ANALISIS DEL SEGUNDO MECANISMO

% longitudes
L2 = 18;
L3 = 24;
L4 = 46.5 - 19;
% L1 = calcular

%El ángulo de rotacion del balancin en el mecanismo dos, es thetaII que ya
%calculamos 
   
thetaII = floor(theta4dc - 180 + theta_aux);

% Calculamos 
theta_3 = floor(acosd((-L4 + L2.*cosd(thetaII)) ./ (L3)));
%theta_3 = floor(asind((-L4 + L2.*sind(thetaII)) ./ (L3)));
L1 = L2.*sind(thetaII) - L3.*sind(theta_3);
%L1 = L2.*cosd(thetaII) - L3.*cosd(theta_3);

theta_4 = 90;      

%A2x = Qx + L3.*cosd(theta4da + theta_aux - 180);
A2x = Qx + L2.*cosd(thetaII);
A2y = Qy + L2.*sind(thetaII);
A2 = sqrt(A2y.^2 + A2x.^2);

B2x = L4 + Qx;
B2y = L1 + Qy;
B2 = sqrt(B2y.^2 + B2x.^2);

   
%% Graficamos 

% Obtener la resolución de la pantalla
screenSize = get(0, 'ScreenSize');

% Calcular el tamaño de la figura para que ocupe el 90% de la pantalla
figWidth = screenSize(3) * 0.9;
figHeight = screenSize(4) * 0.9;

% Calcular la posición para centrar la figura
figX = (screenSize(3) - figWidth) / 2;
figY = (screenSize(4) - figHeight) / 2;

% Crear la figura y establecer su tamaño y posición
fig = figure;
set(fig, 'Position', [figX, figY, 1000, 800]);
for k=1:length(theta2d)

    plot([Ox, Qx],[Oy, Qy], '-o',...
         [Ox, Ax(k)],[Oy, Ay(k)], '-or',...
         [Ax(k), Bxc(k)],[Ay(k), Byc(k)],'-g', ...
         [Bxc(k), Qx], [Byc(k),Qy],'-ob', ...
         [Qx, A2x(k)], [Qy, A2y(k)],'-ob', ...
         [Ox, Ox],[Oy, Oy + 5], '-k',...
         [Ox, Ox + 5],[Oy, Oy], '-k',...
         'LineWidth',1);
    hold on

    plot([A2x(k), B2x],[A2y(k), B2y(k)],'-og', ...
         'LineWidth',1);
    hold on

    plot(Ax(1:k), Ay(1:k), 'Color', [0.5, 0.5, 0.5],'LineWidth',1); 
    plot(Bxa(1:k), Bya(1:k), 'Color', [0.5, 0.5, 0.5],'LineWidth',1);
    plot(A2x(1:k), A2y(1:k), 'Color', [0.5, 0.5, 0.5],'LineWidth',1);
    
    
    %B2x_vector = ones(1, length(B2y)) .* B2x;
    %plot(B2x_vector(1:k), B2y(1:k), 'Color', [0.5, 0.5, 0.5] ,'LineWidth',1);6
    axis([-10 40 -15 60])
    grid on
    axis equal
    
    title('MECANISMO')

    drawnow
    hold off
    
end

