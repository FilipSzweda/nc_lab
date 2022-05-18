load trajektoria2

plot3(x,y,z,'o')
grid on
axis equal
hold on

N = 60;
[wsp, xa] = aproksymacjaWiel(n,x,N);
[wsp, ya] = aproksymacjaWiel(n,y,N);
[wsp, za] = aproksymacjaWiel(n,z,N);

plot3(xa,ya,za,'lineWidth',4);
title("Trajektoria na bazie lokalizacji i aproksymowana wielomianowo (N=60)");
xlabel("x");
ylabel("y");
zlabel("z");
hold off

saveas(gcf, strcat("184738_szweda_zad5.png"));

err = [];
M = size(n,2);
for N = 1:71
    [wsp_wielomianu,xa] = aproksymacjaWiel(n,x,N);
    [wsp_wielomianu,ya] = aproksymacjaWiel(n,y,N);
    [wsp_wielomianu,za] = aproksymacjaWiel(n,z,N);
    err = [err, (sqrt(sum((x - xa).^2)) / M) + (sqrt(sum((y - ya).^2)) / M) + (sqrt(sum((z - za).^2)) / M)];
end

semilogy(err);
grid on;
title("Błąd aproksymacji wielomianowej");
xlabel("N");
ylabel("Wartość błędu");
saveas(gcf, strcat("184738_szweda_zad5_b.png"));