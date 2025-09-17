% Programa para analizar la posición de un M4L de Manivela-Corredera
% Eduardo Cano G.


% Tamño de eslabones
a = 1; %L2
b = 4; %L3
c = 3; %L4
d = 5; %L1

% Coordenadas de Ox, Oy y Qx, Qy
Ox = 0; Oy = 0;
Qx = d; Qy = 0;

theta2d = 0:5:360;

% Posiciones de Ax , Ay
Ax = a*cosd(theta2d);
Ay = a*sind(theta2d);

%Coordenadas de Bca, Bya
% fill
Bxa =
Bya =