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

f_min = -44
f_max = 0

start_x = 0
end_x = 100

start_y = 0
end_y = 100

start_z = -55
end_z = 0

x_diff = end_x - start_x;
y_diff = end_y - start_y;
z_diff = end_z - start_z;

N_1 = 0;

for i = 1:N
    x = rand() * x_diff + start_x;
    y = rand() * y_diff + start_y;
    z = rand() * z_diff + start_z;
    fx = glebokosc(x, y);
    if z <= f_max && z >= fx
        N_1 = N_1 + 1;
    end
end

Vm = (N_1 / N) * abs(start_x - end_x) * abs(start_y - end_y) * abs(start_z - end_z)
