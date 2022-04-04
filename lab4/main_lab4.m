clc
clear all
close all

[xvect, xdif, fx, it_cnt] = bisect(1,60000,1e-3,@compute_parameters_number);
semilogy(1:it_cnt, xvect)
title("[Bisekcja] Wartości kolejnych przybliżeń xi w zależności od numeru iteracji i");
ylabel("Liczba parametrów wejściowych N");
xlabel("Numer iteracji");
saveas(gcf, 'zad1_bisekcja_przybliżenia.png');
plot(2:it_cnt, xdif)
title("[Bisekcja] Różnice pomiędzy wartościami x w kolejnych iteracjach");
ylabel("Różnica pomiędzy poprz. i ob. wartością N");
xlabel("Numer iteracji");
saveas(gcf, 'zad1_bisekcja_różnice.png');

[xvect, xdif, fx, it_cnt] = secant(1,60000,1e-3,@compute_parameters_number);



[xvect, xdif, fx, it_cnt] = bisect(0,52,1e-12,@compute_impedance);

[xvect, xdif, fx, it_cnt] = secant(0,52,1e-12,@compute_impedance);



[xvect, xdif, fx, it_cnt] = bisect(0,52,1e-12,@compute_time);

[xvect, xdif, fx, it_cnt] = secant(0,52,1e-12,@compute_time);