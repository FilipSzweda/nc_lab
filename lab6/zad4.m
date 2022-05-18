load trajektoria1

plot3(x,y,z,'o')
grid on
axis equal
hold on

N = 50;
[wsp, xa] = aproksymacjaWiel(n,x,N);
[wsp, ya] = aproksymacjaWiel(n,y,N);
[wsp, za] = aproksymacjaWiel(n,z,N);

plot3(xa,ya,za,'lineWidth',4);
title("Trajektoria na bazie lokalizacji i aproksymowana wielomianowo (N=50)");
xlabel("x");
ylabel("y");
zlabel("z");
hold off

saveas(gcf, strcat("184738_szweda_zad4.png"));