% Programa para analizar la posición de un M4L
% Método Lazo Vectorial
% Eduardo Cano G.


% Tamño de eslabones
a = 0.86; %L2
b = 1.85; %L3
c = 0.86; %L4
d = 2.22; %L1
ap = 1.33;


% Coordenadas de Ox, Oy y Qx, Qy
Ox = 0; Oy = 0;
Qx = d; Qy = 0;

theta2d = 0:5:360;


% Posiciones de Ax , Ay
Ax = a*cosd(theta2d);
Ay = a*sind(theta2d);


% Variables Auxiliares 

k1 = d/a;
k2 = d/c;
k3 = (a^2 - b^2 + c^2 + d^2)/(2*a*c);

k4 = d/b;
k5 = d/a;
k6 = (c^2 - a^2 - b^2 - d^2)/(2*a*b);

A = -k1 + cosd(theta2d) - k2*cosd(theta2d) + k3;
B = -2*sind(theta2d);
C = k1 - cosd(theta2d) - k2*cosd(theta2d) + k3;

D = -k5 + cosd(theta2d) + k4*cosd(theta2d) + k6;
E = -2*sind(theta2d);
F = k5 - cosd(theta2d) + k4*cosd(theta2d) + k6;




theta3da = 2*atand((-E + sqrt(E.^2 - 4.*D.*F)) ./ (2.*D));
theta3dc = 2*atand((-E - sqrt(E.^2 - 4.*D.*F)) ./ (2.*D));

theta4da = 2*atand((-B + sqrt(B.^2 - 4.*A.*C)) ./ (2.*A));
theta4dc = 2*atand((-B - sqrt(B.^2 - 4.*A.*C)) ./ (2.*A));



% Posiciones de B

Bxa = c*cosd(theta4da) + d;
Bya = c*sind(theta4da);


Bxc = c*cosd(theta4dc) + d;
Byc = c*sind(theta4dc);

% Posiciones de P

Pxa = Ax + ap*cosd(theta3da);
Pya = Ay + ap*sind(theta3da);

Pxc = Ax + ap*cosd(theta3dc);
Pyc = Ay + ap*sind(theta3dc);



figure(20)
for k = 1 : length(theta2d)
    plot([Ox, Ax(k)] , [Oy, Ay(k)], '-or',...
        [Ax(k) , Bxa(k)] , [Ay(k) , Bya(k)], '-og',...
        [Bxa(k) , Qx] , [Bya(k) , Qy] , '-ob' , ...
        'LineWidth',3);
    hold on;
    %plot(Ax(1:k), Ay(1:k), 'm.', 'LineWidth', 2); 
    %plot(Bxa(1:k), Bya(1:k), 'k.', 'LineWidth', 2);
    plot(Pxa(1:k), Pya(1:k), 'c.', 'LineWidth', 2);
    plot(Pxc(1:k), Pyc(1:k), 'c.', 'LineWidth', 2);

    axis([-2 4 -1.5 1.5])
    grid on
    axis square

    drawnow
    pause(0.1)
    hold off

end

