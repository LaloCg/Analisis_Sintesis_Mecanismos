% Programa para analizar la posición de un M4L
% Método Lazo Vectorial
% Eduardo Cano G.


% Tamño de eslabones
a = 8; %L2
b = 7; %L3
c = 9; %L4
d = 4; %L5
f = 12; %L1
ap = 6;


anguloBAP = 30;
lambda = -2.5;
phi = 60;

% Coordenadas de Ox, Oy y Qx, Qy
Ox = 0; Oy = 0;
Qx = f; Qy = 0;

theta2d = 0:5:55;

 
theta5d = (lambda.*theta2d) + phi; 
  
A = 2*c*((d*cosd(theta5d))-(a*cosd(theta2d))+f); 

B = 2*c*((d*sind(theta5d))-(a*sind(theta2d))); 

C = (a^2)-(b^2)+(c^2)+(d^2)+(f^2)-(2*a*f.*cosd(theta2d))... 
    -(2*d.*(a*cosd(theta2d)-f).*cosd(theta5d))... 
        -(2*a*d.*sind(theta2d).*sind(theta5d)); 

D = C - A; 
E = 2.*B; 
F = A + C; 


G = 2*b*(a.*cosd(theta2d)-d.*cosd(theta5d)-f); 

H = 2*b*(a.*sind(theta2d)-d.*sind(theta5d)); 

K = (a^2)+(b^2)-(c^2)+(d^2)+(f^2)-(2*a*f*cosd(theta2d))... 
    -(2*d.*(a.*cosd(theta2d)-f).*cosd(theta5d))... 
        -(2*a*d.*sind(theta2d).*sind(theta5d));

L = K - G; 
M = 2.*H; 
N = G + K; 

  
theta4d=2*atand((E+sqrt((E.^2)-4.*D.*F))./(2.*D)); 

theta3d=2*atand((-M+sqrt((M.^2)-4.*L.*N))./(2.*L));

%Posiciones de Ax, Ay
Ax = a*cosd(theta2d);      
Ay = a*sind(theta2d); 
% Posiciones de Bx, By
Bx = (b*cosd(theta3d))+Ax; 
By = (b*sind(theta3d))+Ay;
% Posiciones de Cx, Cy
Cx = (d*cosd(theta5d))+f;  
Cy = d*sind(theta5d); 



% Posiciones de P

Pxa = Ax + ap*cosd(theta3d + anguloBAP);
Pya = Ay + ap*sind(theta3d + anguloBAP);

Pxc = Ax + ap*cosd(theta3d + anguloBAP);
Pyc = Ay + ap*sind(theta3d + anguloBAP);


%Circulos 
thetaC = 0:1:360; 

diametro2 = 3;
diametro5 = 3;
         
Cd1x = diametro2*cosd(thetaC)+Ox; 
Cd1y = diametro2*sind(thetaC)+Oy; 

Cd2x = diametro5*cosd(thetaC)+Qx; 
Cd2y = diametro5*sind(thetaC)+Qy;



figure(20)
for k = 1 : length(theta2d)
    plot([Ox, Ax(k)] , [Oy, Ay(k)], '-or',...
        [Bx(k) , Cx(k)] , [By(k) , Cy(k)] , '-ob' , ...
        [Cx(k), Qx] , [Cy(k), Qy] , '-om' , ...
        [Ax(k) , Pxa(k)] , [Ay(k) , Pya(k)], '-oy',...
        [Pxa(k) , Bx(k)] , [Pya(k) , By(k)], '-oy',...
        'LineWidth',3);
    hold on;
    plot(Ax(1:k), Ay(1:k), 'm.', 'LineWidth', 2); 
    plot(Bx(1:k), By(1:k), 'g.', 'LineWidth', 2);
    plot(Pxa(1:k), Pya(1:k), 'k-', 'LineWidth', 2);
    
    fill(Cd1x,Cd1y,'y'); 
    fill(Cd2x,Cd2y,'y'); 


    axis([-10 20 -10 20])
    grid on
    axis square

    drawnow
    pause(0.1)
    hold off

end

figure(21)
%subplot(132)
pocisiones_matriz = [Ax; Ay; Bx; By; Pxa; Pya];
plot(theta2d, pocisiones_matriz);
grid on
legend('Ax', 'Ay', 'Bxa', 'Bya', 'Pxa', 'Pya')


figure(22)
%subplot(133)
angulos_matriz = [theta3d; theta4d, theta5d];
plot(theta2d, angulos_matriz);
grid on
legend('theta3A', 'theta4A', 'theta5A')