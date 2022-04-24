K = [5, 15, 25, 33];

[XX,YY] = meshgrid(linspace(0,100,101),linspace(0,100,101));
for i = K
    [x,y,f] = lazik(i);

    subplot(2,2,1);
    plot(x,y,'-o','linewidth',3);
    title(strcat("Droga ruchu łazika dla K =", num2str(i)));
    ylabel("y[m]");
    xlabel("x[m]");

    subplot(2,2,2);
    plot3(x,y,f,'o');
    title(strcat("Wartości zebranych próbek dla K =", num2str(i)));
    ylabel("y[m]");
    xlabel("x[m]");
    zlabel("f(x,y)");

    [p] = polyfit2d(x,y,f);
    [FF] = polyval2d(XX,YY,p);

    subplot(2,2,3);
    surf(XX,YY,FF);
    title(strcat("Interpolacja wielomianowa dla K =", num2str(i)));
    ylabel("y[m]");
    xlabel("x[m]");
    zlabel("f(x,y)");

    [p] = trygfit2d(x,y,f);
    [FF] = trygval2d(XX,YY,p);

    subplot(2,2,4);
    surf(XX,YY,FF);
    surf(XX,YY,FF);
    title(strcat("Interpolacja trygonometryczna dla K =", num2str(i)));
    ylabel("y[m]");
    xlabel("x[m]");
    zlabel("f(x,y)");

    saveas(gcf, strcat("K_", num2str(i), ".png"));
end