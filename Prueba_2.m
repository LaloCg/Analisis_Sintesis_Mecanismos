% Programa para analizar la posición de un M4L
% Método Algebraico
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

% Pre-alocar memoria para los arrays de trayectoria (eficiencia)
Ax_traj = zeros(length(theta2d), 1);
Ay_traj = zeros(length(theta2d), 1);
Bx_traj = zeros(2 * length(theta2d), 1); % Pre-asignar con un tamaño más grande
By_traj = zeros(length(theta2d), 1);
B1x_traj = zeros(2 * length(theta2d), 1); % Pre-asignar con un tamaño más grande
B1y_traj = zeros(length(theta2d), 1);

Ax(k) = a*cosd(theta2d(k));
Ay(k) = a*sind(theta2d(k));
% **Coordenadas de B (B1 y B2):**
  Bya = (-Q + sqrt(Q.^2 -4.*P.*R) ./ (2*P));
  Byc = (-Q - sqrt(Q.^2 -4.*P.*R) ./ (2*P));
  Bxa = S - (Ay.*Bya) ./ (Ax-d);
  Bxc = S - (Ay.*Byc) ./ (Ax-d);
  theta3da = atan2d(Bya-Ay, Bxa-Ax);
  theta3dc = atan2d(Byc-Ay, Bxc-Ax);
  theta4da = atan2d(Bya, d-Bxa);
  theta4dc = atan2d(Byc, d-Bxc);

% Posiciones de Ax , Ay
for k = 1:length(theta2d)
  
  % Almacenamiento en arrays de trayectoria
  Ax_traj(k) = Ax(k);
  Ay_traj(k) = Ay(k);
    
  Bx_traj(k) = Bxa(k);
  By_traj(k) = Bya(k);
  

end

% Variables Auxiliares 
S = (a^2 - b^2 + c^2 - d^2) ./ (2*(Ax - d));
P = (Ay.^2 ./ (Ax - d).^2) + 1;
Q = (2.*Ay.*(d-S)) ./ (Ax - d);
R = (d - S).^2 - c^2;

% Posiciones de B
% ... (Las posiciones de B ya se calculan dentro del ciclo 'for')

% Gráfico
figure(20)
for k = 1 : length(theta2d)
    plot([Ox, Ax(k)] , [Oy, Ay(k)], '-r',...
        [Ax(k) , Bx_traj(k)] , [Ay(k) , By_traj(k)], '-g',...
        [Bx_traj(k) , Qx] , [By_traj(k) , Qy] , '-b' , ...
        [Ax(k), B1x_traj(k)] , [Ay(k) , B1y_traj(k)], '-.g' , ...
        [B1x_traj(k) , Qx] , [B1y_traj(k) , Qy] , '-.b' , ...
        'LineWidth',2);
    hold on
    plot(Ax_traj, Ay_traj, 'b-', 'LineWidth', 2); % Trazar la trayectoria de A (línea azul)
    %plot(Bx_traj, By_traj, 'b-', 'LineWidth', 2); % Trazar la trayectoria de A (línea azul)

    axis([-2 6 -4 4])
    grid on
    axis square

    drawnow
    pause(0.1)
    hold off
end