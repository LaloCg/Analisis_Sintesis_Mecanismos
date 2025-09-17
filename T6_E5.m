% Programa para analizar la posición de un M4L
% Método Lazo Vectorial
% Eduardo Cano G.


% Tamño de eslabones
a = 4; %L2
%b = 2.06; %L3
c = 2; %L4
d = 8; %L1
ap = 12;


% Coordenadas de Ox, Oy y Qx, Qy
Ox = 0; Oy = 0;
Qx = d; Qy = 0;

theta2d = 0:5:115;
gamma = 90;


% Variables Auxiliares 

P = a*sind(theta2d)*sind(gamma)+(a*cosd(theta2d)-d)*cosd(gamma);
Q = -a*sind(theta2d)*cosd(gamma) + (a*cosd(theta2d)-d)*sind(gamma);
R = -c*sind(gamma);

S = R - Q;
T = 2.*P;
U = Q + R;

% theta4
theta4da = 2.*atand((-T+sqrt(T.^2-4.*S.*U))./(2.*S));


% theta3
theta3da = theta4da + gamma;

b = (a*sind(theta2d)-c*sind(theta4da))./(sind(theta3da));


% Posiciones de Ax , Ay
Ax = a*cosd(theta2d);
Ay = a*sind(theta2d);

% Posiciones de B

Bxa = c*cosd(theta4da) + d;
Bya = c*sind(theta4da);


% Corredera

B1x = Bxa - 0.5;
B1y = Bya + 0.25;

B2x = Bxa + 0.5;
B2y = Bya + 0.25;

B3x = Bxa + 0.5;
B3y = Bya - 0.25;

B4x = Bxa - 0.5;
B4y = Bya - 0.25;


        
beta=atan((Bya-Ay)./(Bxa-Ax)); 

Px=ap*cos(beta)+Ax;     
Py=ap*sin(beta)+Ay;



figure(20)
for k = 1 : length(theta2d)
    plot([Ox, Ax(k)] , [Oy, Ay(k)], '-or',...
        [Ax(k) , Bxa(k)] , [Ay(k) , Bya(k)], '-og',...
        [Bxa , Px(k)] , [Bya , Py(k)], '-om' , ...
        [Bxa(k) , Qx] , [Bya(k) , Qy] , '-b' , ...
        [B1x(k), B2x(k)] , [B1y(k), B2y(k)], '-b',...
        [B2x(k), B3x(k)] , [B2y(k), B3y(k)], '-b',...
        [B3x(k), B4x(k)] , [B3y(k), B4y(k)], '-b',...
        [B4x(k), B1x(k)] , [B4y(k), B1y(k)], '-b',...
        'LineWidth',2);
    hold on;
    plot(Ax(1:k), Ay(1:k), 'm.', 'LineWidth', 2); 
    plot(Bxa(1:k), Bya(1:k), 'g.', 'LineWidth', 2);
    plot(Px(1:k), Py(1:k), 'k-', 'LineWidth', 2);

    %{
        separacionFilas = 12; 
        separacionColumnas = 12; 
        columna1 = -6; 
        columna2 = columna1-separacionFilas; 
        columna3 = columna1 + separacionFilas; 
        columna4 = columna3 + separacionFilas; 
        columna5 = columna4 + separacionFilas; 
        %Imprimir longitud de eslabones 
        text(columna1,18,['a =',num2str(a)]); 
        text(columna1,16,['b =',num2str(b)]); 
        text(columna1,14,['c =',num2str(c)]); 
        text(columna1,12,['d =',num2str(d)]); 
         

        %Parametros 
        text(columna4,18,['Ax =',num2str(Ax)]); 
        text(columna4,16,['Ay =',num2str(Ay)]); 
             
        text(columna5,18,['By =',num2str(Bya)]); 
        text(columna5,16,['Bx =',num2str(Bxa)]); 
         
         
        text(columna2,18, ['\theta2=',num2str(theta2d)]);     
        text(columna2,16,['\theta3 =',num2str(theta3da)]); 
        text(columna2,14,['\theta4 =',num2str(theta4da)]); 
         
        %punto P  
        text(columna3,18,['px =',num2str(Px)]); 
        text(columna3,16,['py =',num2str(Py)]); 
    %}


    axis([-5 20 -6 10])
    grid on
    axis square

    drawnow
    pause(0.1)
    hold off

end

figure(21)
%subplot(132)
pocisiones_matriz = [Ax; Ay; Bxa; Bya; Px; Py];
plot(theta2d, pocisiones_matriz);
grid on
legend('Ax', 'Ay', 'Bxa', 'Bya', 'Pxa', 'Pya')


figure(22)
%subplot(133)
angulos_matriz = [theta3da; theta4da];
plot(theta2d, angulos_matriz);
grid on
legend('theta3A', 'theta4A')