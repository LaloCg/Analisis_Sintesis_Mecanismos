clc;
clear all;
hold on;
axis equal;
grid on

xlim([-100 250]);
ylim([-150 200]);
title(' MECANISMO 4 BARRAS LAZO VECTORIAL ');

a=80; %Medida de la barra a
b=130;%Medida de la barra b
c=130;%Medida de la barra c
d=100;%Medida de la barra d

k=1;
k1=(d/a);
k2=(d/c);
k3=((a^2-b^2+c^2+d^2)/(2*a*c));
k4=(d/b);
k5=((c^2-d^2-a^2-b^2)/(2*a*b));

theta2=0;%Inicio de la barra

while theta2<=2*pi;
    cla

A=cos(theta2) - k1 - k2*cos(theta2) + k3;
B=-2*sin(theta2);
C=k1-((k2+1)*cos(theta2))+k3;
theta41=2*atan((-B+sqrt(B^2-4*A*C))/(2*A));
theta42=2*atan((-B-sqrt(B^2-4*A*C))/(2*A));

D=(cos(theta2)-k1+k4*cos(theta2)+k5);
E=(-2*sin(theta2));
F=(k1+(k4-1)*cos(theta2)+k5);
theta31=(2*atan((-E+sqrt(E^2-4*D*F))/(2*D)));
theta32=(2*atan((-E-sqrt(E^2-4*D*F))/(2*D)));

Ax=a*cos(theta2);
Ay=a*sin(theta2);

Bx=c*cos(theta41)+d;
By=c*sin(theta41);

Bx2=c*cos(theta42)+d;
By2=c*sin(theta42);

x1=[0 Ax];
y1=[0 Ay];

x2=[Bx2 d];
y2=[By2 0];

x3=[Ax+theta31 Bx];
y3=[Ay+theta32 By];

x4=[Bx d];
y4=[By 0];

x5=[Ax+theta31 Bx2];
y5=[Ay+theta32 By2];

if theta31 > 0
    J(1,k)=(theta31);
else
    J(1,k)=(theta31)+pi;
end

if theta41>0
    J(2,k)=(theta41);
else
    J(2,k)=(theta41)+pi;
end


G(1,k)=Bx;
G(2,k)=By;
G(3,k)=Bx2;
G(4,k)=By2;
G(5,k)=theta2;

J(8,k)=Ax;
J(9,k)=Ay;

plot(x1,y1,'-o')
plot(x2,y2,'-o')
plot(x3,y3,'-o')
plot(x4,y4,'-o')
plot(x5,y5,'-o')

plot(G(1,:),G(2,:));
plot(G(3,:),G(4,:));
plot(J(8,:),J(9,:));
legend('A','B','C','D','E')

theta2=theta2+pi/60;%incremento
k=k+1;
drawnow;
    
end

figure(2)
title('ÁNGULOS DEL MECANISMO');
axis equal
hold on
grid on

plot(G(5,:),J(1,:));
plot(G(5,:),J(2,:));
legend('theta3','theta4')

figure(3)
title('MOVIMIENTO DE BARRAS');
axis square
hold on
grid on
plot(G(5,:),J(8,:));
plot(G(5,:),J(9,:));

plot(G(5,:),G(1,:));
plot(G(5,:),G(2,:));
plot(G(5,:),G(3,:));
plot(G(5,:),G(4,:));
legend('Ax','Ay','By','By','By2','By2')