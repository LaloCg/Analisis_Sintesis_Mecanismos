% Programa para analizar la posición de un M4L
% Método Lazo Vectorial
% Eduardo Cano G.


% Tamño de eslabones
a = 0.86*10; %L2
b = 1.85*10; %L3
c = 0.86*10; %L4
d = 2.22*10; %L1
ap = 1.33*10;


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

% Posiciones de P

Pxa = Ax + ap*cosd(theta3da);
Pya = Ay + ap*sind(theta3da);

Pxc = Ax + ap*cosd(theta3dc);
Pyc = Ay + ap*sind(theta3dc);


[agarrotamientoSuperior, agarrotamientoInferior] =  agarrotamiento(a,b,c,d);

dangulo2 = 5;

figure(23)
%subplot(131)
for k = 1 : length(theta2d) 
    plot([Ox, Ax(k)] , [Oy, Ay(k)], '-or',...
        [Ax(k) , Bxa(k)] , [Ay(k) , Bya(k)], '-og',...
        [Bxa(k) , Qx] , [Bya(k) , Qy] , '-ob' , ...
        'LineWidth',3);

    hold on;
    plot(Ax(1:k), Ay(1:k), 'm.', 'LineWidth', 2); 
    plot(Bxa(1:k), Bya(1:k), 'g.', 'LineWidth', 2);
    plot(Pxa(1:k), Pya(1:k), 'k-', 'LineWidth', 2);
    plot(Pxc(1:k), Pyc(1:k), 'k-', 'LineWidth', 2);

    %{
        separacionFilas = 12; 
        separacionColumnas = 12; 
        columna1 = -6; 
        columna2 = columna1-separacionFilas; 
        columna3 = columna1 + separacionFilas; 
        columna4 = columna3 + separacionFilas; 
        columna5 = columna4 + separacionFilas; 
        %Agarrotamientos 
        text(columna1-12,24,['angulo limite superior =', num2str(agarrotamientoSuperior)]); 
        text(columna1-12,22,['angulo limite inferior =',num2str(agarrotamientoInferior)]); 
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
        text(columna3,18,['px =',num2str(Pxa)]); 
        text(columna3,16,['py =',num2str(Pya)]); 
    %}

    axis([-20 30 -20 30])
    grid on
    axis square

    drawnow
    pause(0.01)
    hold off

end


figure(21)
%subplot(132)
pocisiones_matriz = [Ax; Ay; Bxa; Bya; Bxc; Byc; Pxa; Pya];
plot(theta2d, pocisiones_matriz);
grid on
legend('Ax', 'Ay', 'Bxa', 'Bya', 'Bxc', 'Byc', 'Pxa', 'Pya')


figure(22)
%subplot(133)
angulos_matriz = [theta3da; theta3dc; theta4da; theta4dc ];
plot(theta2d, angulos_matriz);
grid on
legend('theta3A', 'theta3C', 'theta4A', 'theta4C')


function [agarrotamiento_s, agarrotamiento_i] = agarrotamiento(a,b,c,d) 
    argumento = (a^2+d^2-b^2-c^2)/(2*a*d)-((b*c)/(a*d)); 
    if argumento > 1 || argumento < -1 
        argumento = (a^2+d^2-b^2-c^2)/(2*a*d)+((b*c)/(a*d)); 
    end 
     
    agarrotamiento = acosd(argumento); 
    agarrotamiento_s = rad2deg(agarrotamiento); 
    agarrotamiento_i = -1*agarrotamiento_s; 
 end 