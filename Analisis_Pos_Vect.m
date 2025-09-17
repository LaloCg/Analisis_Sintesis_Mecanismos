% Programa para analizar la posición de un M4L
% Método Lazo Vectorial
% Eduardo Cano G.


% Tamño de eslabones
a = 4; %L2
b = 6; %L3
c = 8; %L4
d = 10; %L1


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
Bxc = c*cosd(theta4dc) + d;

Bya = c*sind(theta4da);
Byc = c*sind(theta4dc);




figure(20)
subplot(131)
for k = 1 : length(theta2d)
    plot([Ox, Ax(k)] , [Oy, Ay(k)], '-r',...
        [Ax(k) , Bxa(k)] , [Ay(k) , Bya(k)], '-.g',...
        [Bxa(k) , Qx] , [Bya(k) , Qy] , '-.b' , ...
        [Ax(k), Bxc(k)] , [Ay(k) , Byc(k)] , '-g' , ...
        [Bxc(k) , Qx] , [Byc(k) , Qy] , '-b' , ...
        'LineWidth',2);
    hold on;
    plot(Ax(1:k), Ay(1:k), 'm.', 'LineWidth', 2); 
    plot(Bxa(1:k), Bya(1:k), 'y-', 'LineWidth', 2);

    axis([-6 6 -4 4])
    grid on
    axis square

    drawnow
    pause(0.01)
    hold off

end

subplot(132)
pocisiones_matriz = [Ax; Ay; Bxa; Bya; Bxc; Byc];
plot(theta2d, pocisiones_matriz);
grid on
legend('Ax', 'Ay', 'Bxa', 'Bya', 'Bxc', 'Byc')



subplot(133)
angulos_matriz = [theta3da; theta3dc; theta4da; theta4dc ];
plot(theta2d, angulos_matriz);
grid on
legend('theta3A', 'theta3C', 'theta4A', 'theta4C')