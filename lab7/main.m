clc
clear all
close all

load P_ref
fun = @gestosc_prawdopodobienstwa
a = 0
b = 5
f_min = fun(0)
f_max = fun(0)

for i = 0:5
    if fun(i) > f_max
        f_max = fun(i)
    else
        if fun(i) < f_min
            f_min = fun(i)
        end
    end
end

err_p = [];
err_t = [];
err_s = [];
err_m = [];

for N = 5:50:10^4
    dx = (b - a) / N;

    res_p = 0;

    res_t = 0;

    res_s = 0;

    f_diff = f_max - f_min;
    i_diff = b - a;
    N_1 = 0;

    for i = 1:N
        x_i = a + (i - 1) * dx;
        x_i_1 = a + i * dx;
        
        % Metoda prostokątów
        res_p = res_p + fun((x_i + x_i_1) / 2) * dx;
        
        % Metoda trapezow
        res_t = res_t + (fun(x_i) + fun(x_i_1)) / 2 * dx;
        
        % Metoda Simpsona
        res_s = res_s + fun(x_i) + 4 * fun((x_i_1 + x_i) / 2) + fun(x_i_1);
        
        % Metoda Monte Carlo
        x = rand() * i_diff + a;
        y = rand() * f_diff + f_min;
        fx = fun(x);
        if y >= f_min && y <= fx
            N_1 = N_1 + 1;
        end
    end
    err_p = [err_p, abs(res_p - P_ref)];
    
    err_t = [err_t, abs(res_t - P_ref)];
    
    res_s = res_s * dx / 6;
    err_s = [err_s, abs(res_s - P_ref)];
    
    res_m = (N_1 / N) * abs(a - b) * abs(f_min - f_max);
    err_m = [err_m, abs(res_m - P_ref)];
end


x = 5:50:10^4;

figure();
loglog(x, err_p);
title('Błąd całkowania (metoda prostokątów)');
xlabel('Liczba przedziałów');
ylabel('Wartość błędu');
saveas(gcf, 'blad_calkowania_metoda_prostokatow.png')

figure();
loglog(x, err_t);
title('Błąd całkowania (metoda trapezów)');
xlabel('Liczba przedziałów');
ylabel('Wartość błędu');
saveas(gcf, 'blad_calkowania_metoda_trapezow.png')

figure();
loglog(x, err_s);
title('Błąd całkowania (metoda Simpsona)');
xlabel('Liczba przedziałów');
ylabel('Wartość błędu');
saveas(gcf, 'blad_calkowania_metoda_simpsona.png')

figure();
loglog(x, err_m);
title('Błąd całkowania (metoda Monte Carlo)');
xlabel('Liczba punktów');
ylabel('Wartość błędu');
saveas(gcf, 'blad_calkowania_metoda_monte_carlo.png')

N = 10^7

% Metoda prostokątów
tic
dx = (b - a) / N;
res_p = 0;
for i = 1:N
    x_i = a + (i - 1) * dx;
    x_i_1 = a + i * dx;
    res_p = res_p + fun((x_i + x_i_1)/2) * dx;
end
time_p = toc;

% Metoda trapezow
tic
dx = (b - a)/N;
res_t = 0;
for i = 1:N
    x_i = a + (i - 1) * dx;
    x_i_1 = a + i * dx;
    res_t = res_t + ((fun(x_i) + fun(x_i_1)) / 2) * dx;
end
time_t = toc;

% Metoda Simpsona
tic
dx = (b - a) / N;
res_s = 0;
for i = 1:N
    x_i = a + (i - 1) * dx;
    x_i_1 = a + i * dx;
    res_s = res_s + fun(x_i) + 4 * fun((x_i_1 + x_i) / 2) + fun(x_i_1);
end
res_s = res_s * dx / 6;
time_s = toc;

% Metoda Monte Carlo
tic
f_diff = f_max - f_min;
i_diff = b - a;
N_1 = 0;
for i = 1:N
    x = rand() * i_diff + a;
    y = rand() * f_diff + f_min;
    fx = fun(x);
    if y >= f_min && y <= fx
        N_1 = N_1 + 1;
    end
end
res_m = (N_1 / N) * abs(a - b) * abs(f_min - f_max);
time_m = toc;

figure();
y = [time_p; time_t; time_s; time_m];
bar(1:4, y);
set(gca, 'xticklabel', ["Metoda prostokątów", "Metoda trapezów", "Metoda Simpsona", "Metoda Monte Carlo"]);
title('Czas wykonania poszczególnych metod (N = 10^7)');
xlabel('Badana metoda');
ylabel('Czas [s]');
saveas(gcf, "czas_wykonania_metod.png");