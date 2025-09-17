% Programa para analizar la posición de un M4L
% Método Algebraico
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
S = (a^2 - b^2 + c^2 - d^2) ./ (2*(Ax - d));
P = (Ay.^2 ./ (Ax - d).^2) + 1;
Q = (2.*Ay.*(d-S)) ./ (Ax - d);
R = (d - S).^2 - c^2;


% Posiciones de B
Bya = (-Q + sqrt(Q.^2 -4.*P.*R) ./ (2*P));
Byc = (-Q - sqrt(Q.^2 -4.*P.*R) ./ (2*P));

Bxa = S - (Ay.*Bya) ./ (Ax-d);
Bxc = S - (Ay.*Byc) ./ (Ax-d);


theta3da = atan2d(Bya-Ay, Bxa-Ax);
theta3dc = atan2d(Byc-Ay, Bxc-Ax);

theta4da = atan2d(Bya, d-Bxa);
theta4dc = atan2d(Byc, d-Bxc);

Ax_traj = zeros(length(theta2d), 1);
Ay_traj = zeros(length(theta2d), 1);

Bx_traj = zeros(length(theta2d), 1); 
By_traj = zeros(length(theta2d), 1);

theta3da_traj = zeros(length(theta3da), 1);

for k = 1:length(theta2d)
  % Almacenamiento en arrays de trayectoria
  Ax_traj(k) = Ax(k);
  Ay_traj(k) = Ay(k);

  Bx_traj(k) = Bxa(k);
  By_traj(k) = Bya(k);

  
end

figure(20)
for k = 1 : length(theta2d)
    plot([Ox, Ax(k)] , [Oy, Ay(k)], '-r',...
        [Ax(k) , Bxa(k)] , [Ay(k) , Bya(k)], '-g',...
        [Bxa(k) , Qx] , [Bya(k) , Qy] , '-b' , ...
        [Ax(k), Bxc(k)] , [Ay(k) , Byc(k)] , '-.g' , ...
        [Bxc(k) , Qx] , [Byc(k) , Qy] , '-.b' , ...
        'LineWidth',2);
    hold on;
    plot(Ax_traj, Ay_traj, 'm-', 'LineWidth', 2); % Trazar la trayectoria de A (línea azul)
    plot(Bx_traj, By_traj, 'y-', 'LineWidth', 2);
  

    
    axis([-5 12 -8 13])
    grid on
    axis square

    drawnow
    pause(0.1)
    hold off

    

end