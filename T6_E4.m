% Programa para analizar la posición de un M4L
% Método Lazo Vectorial
% Eduardo Cano G.


% Tamño de eslabones
a = 5; %L2
b = 20; %L3
c = -5; %Offset


% Coordenadas de Ox, Oy
Ox = 0; Oy = 0;


theta2d = 0:5:125;


% Posiciones de Ax , Ay
Ax = a*cosd(theta2d);
Ay = a*sind(theta2d);


% Angulo 3
argumento = -(a*sind(theta2d)-c)/b;
theta3da = asind(argumento)+180;


% Angulo 4
theta4da = 90;


d = a*cosd(theta2d) - b*cosd(theta3da);

% Posiciones de B

Bxa = d;
Bya = c;


% Corredera

B1x = Bxa - 2;
B1y = Bya + 0.5;

B2x = Bxa + 2;
B2y = Bya + 0.5;

B3x = Bxa + 2;
B3y = Bya - 0.5;

B4x = Bxa - 2;
B4y = Bya - 0.5;


figure(20)
for k = 1 : length(theta2d)
    plot([Ox, Ax(k)] , [Oy, Ay(k)], '-or',...
        [Ax(k) , Bxa(k)] , [Ay(k) , Bya], '-og',...
        [B1x(k), B2x(k)] , [B1y, B2y], '-ob',...
        [B2x(k), B3x(k)] , [B2y, B3y], '-ob',...
        [B3x(k), B4x(k)] , [B3y, B4y], '-ob',...
        [B4x(k), B1x(k)] , [B4y, B1y], '-ob',...    
        'LineWidth',3);
    hold on;
    plot(Ax(1:k), Ay(1:k), 'm.', 'LineWidth', 2); 
    plot(Bxa(1:k), Bya, 'k.', 'LineWidth', 2);

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
         
    %}


    axis([-6 30 -6 6])
    grid on
    axis square

    drawnow
    pause(0.01)
    hold off

end

figure(21)
%subplot(132)
pocisiones_matriz = [Ax; Ay; Bxa];
plot(theta2d, pocisiones_matriz);
grid on
legend('Ax', 'Ay', 'Bxa')


figure(22)
%subplot(133)
angulos_matriz = [theta3da ];
plot(theta2d, angulos_matriz);
grid on
legend('theta3A')