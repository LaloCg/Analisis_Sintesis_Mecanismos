clear; 
clc; 
a = 10*0.86; 
b = 10*1.85; 
c = 10*0.86; 
d = 10*2.22; 
%Puntos de bancada 
O2x = 0; 
O2y = 0; 
O4x = 0+d; 
O4y = 0; 
%Punto P 
pa = -1;%Condiciones para que se ejecute la instruccion en p 
pb =  -2; 
pc = -3; 
%longitud 
longitudP = 10*1.33; 
%eslabon 
p = pb; 
%Angulo 2% 
angulo2 = 33; %GRADOS 
dangulo2 = 1;%Diferencial de angulo 2 
%Valores de K% 
k1 = d/a; 
k2 = d/c; 
k3 = ((a^2)-(b^2)+(c^2)+(d^2))/(2*a*c); 
k4 = d/b; 
k5 = ((c^2)-(d^2)-(a^2)-(b^2))/(2*a*b); 
%Vectores para la condicion Grashof 
vectorGrashof = [a b c d]; 
vectorGrashof = sort(vectorGrashof); 
pause(3); 
contador = 1; 
[agarrotamientoSuperior, agarrotamientoInferior] = 
agarrotamiento(a,b,c,d); 
pause(3); 
    agarrotamientoSuperior 
    agarrotamientoInferior 
    contador = 1; 
  
    for j=agarrotamientoInferior:dangulo2:agarrotamientoSuperior 
    angulo2 = atan4(j); 
    angulo2 
    %%Ecuaciones para A,B,C,D,E,F%% 
    A = cosd(angulo2)-k1-k2*cosd(angulo2)+k3; 
    B = -2*sind(angulo2); 
    C = k1-(k2+1)*cosd(angulo2)+k3; 
    D = cosd(angulo2)-k1+k4*cosd(angulo2)+k5; 
    E = -2*sind(angulo2); 
    F = k1 + (k4-1)*cosd(angulo2)+k5; 
  
    %Condicion  
     
    if B^2-4*A*C>0 
          
        %Calculo de los angulos 3 y 4 
        angulo3 = 2*atand((-E+sqrt(E^2-4*D*F))/(2*D)); 
        angulo4 = 2*atand((-B+sqrt(B^2-4*A*C))/(2*A)); 
         
        %angulo32 = 2*atan((-E+sqrt(E^2-4*D*F))/(2*D));% 
        %angulo42 = 2*atan((-B+sqrt(B^2-4*A*C))/(2*A));% 
         
        
        angulo3 = atan4(angulo3); 
        angulo4 = atan4(angulo4); 
         
        %calculo de A 
         
        Ax = a*cosd(angulo2); 
        Ay = a*sind(angulo2); 
         
        %calculo de B      
        Bx = b*cosd(angulo3)+Ax; 
        By = b*sind(angulo3)+Ay; 
         
        %calculo de P 
        [Px,Py] = 
posicionP(longitudP,p,pa,pb,pc,Ax,Ay,Bx,By,angulo2,angulo3,angulo4); 
         
        %Trayectos 
         
        pathAx(contador) = Ax; 
        pathAy(contador) = Ay; 
         
        pathBx(contador) = Bx; 
        pathBy(contador) = By; 
         
        pathPx(contador) = Px; 
        pathPy(contador) = Py; 
         
        %Grafica 
        plot(0,20,'x'); 
         
        hold on; 
        title('M4L NO GRASHOF'); 
        %Eslabones 
        plot(O2x,O2y,'ob',Ax,Ay,'or',Bx,By,'or',O4x,O4y,'og'); 
        plot([O2x Ax],[O2y Ay],'-ok',[Ax Bx],[Ay By],'-or',... 
            [Bx O4x],[By O4y],'-og',[O4x O2x],[O4y O2y],'-
ok','lineWidth',2); 
         
        separacionFilas = 12; 
        separacionColumnas = 12; 
        columna1 = -6; 
        columna2 = columna1-separacionFilas; 
        columna3 = columna1 + separacionFilas; 
        columna4 = columna3 + separacionFilas; 
        columna5 = columna4 + separacionFilas; 
        %Agarrotamientos 
        text(columna1-12,24,['angulo limite superior 
=',num2str(agarrotamientoSuperior)]); 
        text(columna1-12,22,['angulo limite inferior 
=',num2str(agarrotamientoInferior)]); 
        %Imprimir longitud de eslabones 
        text(columna1,18,['a =',num2str(a)]); 
        text(columna1,16,['b =',num2str(b)]); 
        text(columna1,14,['c =',num2str(c)]); 
        text(columna1,12,['d =',num2str(d)]); 
         
        %Imprimir puntos% 
        text(O2x-1,O2y+1,'O2'); 
        text(Ax-1,Ay+1,'A'); 
        text(Bx-1,By+1,'B'); 
        text(O4x+1,O4y+1,'O4'); 
        text(Px-1,Py+1,'P'); 
         
        %Parametros 
        text(columna4,18,['Ax =',num2str(Ax)]); 
        text(columna4,16,['Ay =',num2str(Ay)]); 
             
        text(columna5,18,['By =',num2str(By)]); 
        text(columna5,16,['Bx =',num2str(Bx)]); 
         
         
        text(columna2,18, ['\theta2=',num2str(angulo2)]);     
        text(columna2,16,['\theta3 =',num2str(angulo3)]); 
        text(columna2,14,['\theta4 =',num2str(angulo4)]); 
         
        %punto P 
        plot(Px,Py,'xb'); 
        plot(pathPx,pathPy,'.m','lineWidth',2); 
        text(columna3,18,['px =',num2str(Px)]); 
        text(columna3,16,['py =',num2str(Py)]); 
         
        %TRAYECTO A Y B 
        plot(pathAx,pathAy,'.b','lineWidth',2); 
        plot(pathBx,pathBy,'.c','lineWidth',2); 
         
        hold off; 
         
        grid on 
        axis ([-20 30 -20 30]); 
        axis square; 
        axis equal; 
  
    else 
  
    end 
     
    pause(0.05); 
    contador = contador+1; 
    
 end 
     
  
  
%Funcion de agarrotamientos 
 function [agarrotamiento_s, agarrotamiento_i] = agarrotamiento(a,b,c,d) 
    argumento = (a^2+d^2-b^2-c^2)/(2*a*d)-((b*c)/(a*d)); 
    if argumento > 1 || argumento < -1 
        argumento = (a^2+d^2-b^2-c^2)/(2*a*d)+((b*c)/(a*d)); 
    end 
     
    agarrotamiento = acos(argumento); 
    agarrotamiento_s = rad2deg(agarrotamiento); 
    agarrotamiento_i = -1*agarrotamiento_s; 
 end 
  
    %Funcion para definir el angulo en los 4 cuadrantes 
function argumentOut = atan4(argumentIn) 
    argumentOut = argumentIn; 
    if argumentOut < 0 
       argumentOut = argumentOut + 360; 
    end 
end 
  
    %Punto de interes 
    function [Px,Py] = 
posicionP(longitudP,p,pa,pb,pc,Ax,Ay,Bx,By,angulo2,angulo3,angulo4) 
        if p == pa 
            Px = longitudP*cosd(angulo2); 
            Py = longitudP*sind(angulo2); 
        elseif p == pb 
            Px = longitudP*cosd(angulo3)+Ax; 
            Py = longitudP*sind(angulo3)+Ay; 
        elseif p == pc 
            Px = longitudP*cosd(angulo4); 
            Py = longitudP*sind(angulo4);        
        else 
            Px = Bx; 
            Py = By; 
        end 
    end 