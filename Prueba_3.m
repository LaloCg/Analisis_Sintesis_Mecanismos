% Tamño de eslabones
a = 1; %L2
b = 4; %L3
c = 3; %L4
d = 5; %L1

Eslb = [a, b, c, d];

[Lmax, indMx] = max(Eslb) 
[Lmin, indMn] = min(Eslb) 

if (indMx)