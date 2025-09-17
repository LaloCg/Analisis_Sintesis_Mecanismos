% Programa: Análisis de Posición Mediante El Método de Lazos Vectoriales
% - Hernández Domínguez Angel Paul

%% Declaración de los valores conocidos 
a = 8; % L2
b = 7; % L3
c = 9; % L4
d = 4; % L5
f = 12; % L1

lamda = -2.5; 
phi = 60;
theta2d = 0:5:720;

% Coordenadas del punto Q
Qx = f;  
Qy = 0;

% Coordenadas del Origen
Ox = 0;  
Oy = 0;

theta_5 = lamda.*theta2d + phi;

A = (2.*c.*(d.*cosd(lamda.*theta2d+phi)-a.*cosd(theta2d)+f));
B = (2.*c.*(d.*sind(lamda.*theta2d+phi)-a.*sind(theta2d)));
C =  (a^2-b^2+c^2+d^2+f^2 - 2*a*f*cosd(theta2d)-...
    2.*d.*(a.*cosd(theta2d)-f).*cosd(lamda.*theta2d+phi)-2*a*d.*sind(theta2d).*sind(lamda.*theta2d+phi)); 
D = C- A;
E = 2.*B;
F = A+C;

indexR = E.^2 - 4.*D.*F > 0;
indexR2 = 2.*D ~= 0;
fprintf('   Index   |  E.^2 - 4.*D.*F   |   index2\n');
fprintf('-----------------------------------------\n');
for i = 1:length(indexR)
    fprintf('%10d | %16.6f  | %2d \n', indexR(i), E(i)^2 - 4 * D(i) * F(i), indexR2(i));
end

theta_4 = zeros(1, length(indexR));
contador = 1;

for k=1 : length(theta2d)
    if indexR(k) == 1 && indexR2(k) == 1
        theta_4(contador) = 2 .* atan2d(-E(k) - sqrt(E(k).^2 - 4.*D(k).*F(k)), 2.*D(k));
        contador = contador + 1;
    else

    end
end

Ax = zeros(1, length(indexR));
Ay = zeros(1, length(indexR));

Cx = zeros(1, length(indexR));
Cy = zeros(1, length(indexR));


contador = 1;
for k=1 : length(theta2d)
    if indexR(k) == 1 && indexR2(k) == 1
        Ax(contador) =  a.*cosd(theta2d(k));
        Ay(contador) =  a.*sind(theta2d(k));
        
        Cx(contador) = f + d.*cosd(lamda.*theta2d(k)+phi);
        Cy(contador) = d.*sind(lamda.*theta2d(k)+phi);
        contador = contador + 1;       
    else

    end
end

Bx = c.*cosd(theta_4) + Cx;
By = c.*sind(theta_4) + Cy;

%% Graficamos 
fig = figure; 
fig.Position(3:4) = [1000, 600]; 

contador = 1;
for k=1 : length(indexR)
    

    if indexR(k) == 1 && indexR2(k) == 1

        plot([Ox, Qx],[Oy, Qy], '-o',...   % L1
             [Ox, Ax(contador)],[Oy, Ay(contador)], '-or',...  % L2
             [Ax(contador), Bx(contador)],[Ay(contador), By(contador)],'-g', ...   % L3
             [Bx(contador), Cx(contador)], [By(contador),Cy(contador)],'-ob', ... % L4
             [Cx(contador), Qx], [Cy(contador),Qy],'-ob', ...
             [Ox, Ox],[Oy, Oy + 12], '-k',...
             [Ox, Ox + 12],[Oy, Oy], '-k',...
             'LineWidth',2);
        hold on

        plot(Bx(1:contador), By(1:contador), '.', 'MarkerFaceColor', [0.5, 0.5, 0.5],'MarkerSize', 5);

        axis([-20 10 -10 20])
        grid on
        axis equal
        title('MECANISMO')
        drawnow
        hold off
        pause(0.001)
        contador = contador +1;
    else
    end
end