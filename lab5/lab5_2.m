[XX,YY] = meshgrid(linspace(0,100,101),linspace(0,100,101));
div_wiel = [];
div_tryg = [];
for i = 5:45
    [x,y,f] = lazik(i);

    [p] = polyfit2d(x,y,f);
    [FF_wiel] = polyval2d(XX,YY,p);

    [p] = trygfit2d(x,y,f);
    [FF_tryg] = trygval2d(XX,YY,p);

    if i == 5
        FF_wiel_prev = FF_wiel;
        FF_tryg_prev = FF_tryg;
    else
        div_wiel = [div_wiel, max(max(abs(FF_wiel - FF_wiel_prev)))];
        FF_wiel_prev = FF_wiel;
        div_tryg = [div_tryg, max(max(abs(FF_tryg - FF_tryg_prev)))];
        FF_tryg_prev = FF_tryg;
    end
end

plot(6:45, div_wiel);
title("Zbieżność dla interpolacji wielomianowej");
ylabel("Maksymalna wartość różnicy różnicy interpolowanych funkcji");
xlabel("Liczba punktów pomiarowych K");
saveas(gcf, "zbieżność_dla_interpolacji_wielomianowej.png");

plot(6:45, div_tryg);
title("Zbieżność dla interpolacji trygonometrycznej");
ylabel("Maksymalna wartość różnicy różnicy interpolowanych funkcji");
xlabel("Liczba punktów pomiarowych K");
saveas(gcf, "zbieżność_dla_interpolacji_trygonometrycznej.png");