load trajektoria2

plot3(x,y,z,'o')
grid on
axis equal
hold on

N = 60;
xa = aprox_tryg(n, x, N);
ya = aprox_tryg(n, y, N);
za = aprox_tryg(n, z, N);

plot3(xa,ya,za,'lineWidth',4);
title("Trajektoria na bazie lokalizacji i aproksymowana trygonometrycznie (N=60)");
xlabel("x");
ylabel("y");
zlabel("z");
hold off

saveas(gcf, strcat("184738_szweda_zad7.png"));

err = [];
M = size(n,2);
for N = 1:71
    xa = aprox_tryg(n,x,N);
    ya = aprox_tryg(n,y,N);
    za = aprox_tryg(n,z,N);
    err = [err, (sqrt(sum((x - xa).^2)) / M) + (sqrt(sum((y - ya).^2)) / M) + (sqrt(sum((z - za).^2)) / M)];
end

semilogy(err);
grid on;
title("Błąd aproksymacji trygonometrycznej");
xlabel("N");
ylabel("Wartość błędu");
saveas(gcf, strcat("184738_szweda_zad7_b.png"));

%--------------------------------------------------------------------------
clc;
clear all;
close all;

load trajektoria2

plot3(x,y,z,'o')
grid on
axis equal
hold on

N = 60;
epsilon = 10^-3;
M = size(n,2);
while true
    N = N + 1;
    xa = aprox_tryg(n,x,N);
    ya = aprox_tryg(n,y,N);
    za = aprox_tryg(n,z,N);
    err = (sqrt(sum((x - xa).^2)) / M) + (sqrt(sum((y - ya).^2)) / M) + (sqrt(sum((z - za).^2)) / M);
    if err <= epsilon
        break
    end
end

xa = aprox_tryg(n,x,N);
ya = aprox_tryg(n,y,N);
za = aprox_tryg(n,z,N);

plot3(xa,ya,za,'lineWidth',4);
title("Trajektoria na bazie lokalizacji i aproksymowana trygonometrycznie (N=auto)");
xlabel("x");
ylabel("y");
zlabel("z");
hold off
