clc
clear all
close all

[xvect, xdif, fx, it_cnt] = bisect(1,60000,1e-3,@compute_parameters_number);
plot(1:it_cnt, xvect);
title("[Bisekcja] Wartości przybliżeń N w kolejnych iteracjach");
ylabel("N");
xlabel("Numer iteracji");
saveas(gcf, 'problem1_bisekcja_przybliżenia.png');
semilogy(2:it_cnt, xdif);
title("[Bisekcja] Różnice pomiędzy wartościami N w kolejnych iteracjach");
ylabel("Różnica pomiędzy poprz. i ob. wartością N");
xlabel("Numer iteracji");
saveas(gcf, 'problem1_bisekcja_różnice.png');

[xvect, xdif, fx, it_cnt] = secant(1,60000,1e-3,@compute_parameters_number);
plot(1:it_cnt, xvect)
title("[M. siecznych] Wartości przybliżeń N w kolejnych iteracjach");
ylabel("Liczba parametrów wejściowych N");
xlabel("Numer iteracji");
saveas(gcf, 'problem1_metoda_siecznych_przybliżenia.png');
semilogy(2:it_cnt, xdif);
title("[M. siecznych] Różnice pomiędzy wartościami N w kolejnych iteracjach");
ylabel("Różnica pomiędzy poprz. i ob. wartością N");
xlabel("Numer iteracji");
saveas(gcf, 'problem1_metoda_siecznych_różnice.png');


[xvect, xdif, fx, it_cnt] = bisect(0,52,1e-12,@compute_impedance);
plot(1:it_cnt, xvect)
title("[Bisekcja] Wartości przybliżeń ω w kolejnych iteracjach");
ylabel("ω [rad/s]");
xlabel("Numer iteracji");
saveas(gcf, 'problem2_bisekcja_przybliżenia.png');
semilogy(2:it_cnt, xdif);
title("[Bisekcja] Różnice pomiędzy wartościami ω w kolejnych iteracjach");
ylabel("Różnica pomiędzy poprz. i ob. wartością ω");
xlabel("Numer iteracji");
saveas(gcf, 'problem2_bisekcja_różnice.png');

[xvect, xdif, fx, it_cnt] = secant(0,52,1e-12,@compute_impedance);
plot(1:it_cnt, xvect)
title("[M. siecznych] Wartości przybliżeń ω w kolejnych iteracjach");
ylabel("ω [rad/s]");
xlabel("Numer iteracji");
saveas(gcf, 'problem2_metoda_siecznych_przybliżenia.png');
semilogy(2:it_cnt, xdif);
title("[M. siecznych] Różnice pomiędzy wartościami ω w kolejnych iteracjach");
ylabel("Różnica pomiędzy poprz. i ob. wartością ω");
xlabel("Numer iteracji");
saveas(gcf, 'problem2_metoda_siecznych_różnice.png');



[xvect, xdif, fx, it_cnt] = bisect(0,52,1e-12,@compute_time);
plot(1:it_cnt, xvect)
title("[Bisekcja] Wartości przybliżeń t w kolejnych iteracjach");
ylabel("t [s]");
xlabel("Numer iteracji");
saveas(gcf, 'problem3_bisekcja_przybliżenia.png');
semilogy(2:it_cnt, xdif);
title("[Bisekcja] Różnice pomiędzy wartościami t w kolejnych iteracjach");
ylabel("Różnica pomiędzy poprz. i ob. wartością t [s]");
xlabel("Numer iteracji");
saveas(gcf, 'problem3_bisekcja_różnice.png');

[xvect, xdif, fx, it_cnt] = secant(0,52,1e-12,@compute_time);
plot(1:it_cnt, xvect)
title("[M. siecznych] Wartości przybliżeń t w kolejnych iteracjach");
ylabel("t [s]");
xlabel("Numer iteracji");
saveas(gcf, 'problem3_metoda_siecznych_przybliżenia.png');
semilogy(2:it_cnt, xdif)
title("[M. siecznych] Różnice pomiędzy wartościami t w kolejnych iteracjach");
ylabel("Różnica pomiędzy poprz. i ob. wartością t [s]");
xlabel("Numer iteracji");
saveas(gcf, 'problem3_metoda_siecznych_różnice.png');

% options = optimset('Display','iter');
% fzero(@tan,6, options)
% fzero(@tan,4.5, options)