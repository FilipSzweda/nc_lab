clc
clear all


%------------------------------------------
load dane_jezioro   % dane XX, YY, FF sa potrzebne jedynie do wizualizacji problemu. 
surf(XX,YY,FF)
shading interp
axis equal
%------------------------------------------


%------------------------------------------
% Implementacja Monte Carlo dla f(x,y) w celu obliczenia objetosci wody w zbiorniku wodnym. 
% Calka = ?
% Nalezy skorzystac z nastepujacej funkcji:
% z = glebokosc(x,y); % wyznaczanie glebokosci jeziora w punkcie (x,y),
% gdzie x i y sa losowane
%------------------------------------------

N = 1e5

fmin = -44
fmax = 0
a = 0
b = 100
c = -55
d = 0
x_diff = b - a;
y_diff = b - a;
z_diff = d - c;

N_1 = 0;

for i = 1:N
    x = rand() * x_diff + a;
    y = rand() * y_diff + a;
    z = rand() * z_diff + c;
    fx = glebokosc(x, y);
    if z <= fmax && z >= fx
        N_1 = N_1 + 1;
    end
end

Vm = (N_1 / N) * abs(a-b) * abs(a-b) * abs(c - d)
