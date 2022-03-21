clc
clear all
close all
diary('log_184738_lab3')

% odpowiednie fragmenty kodu mo¿na wykonaæ poprzez znazaczenie i wciœniêcie F9
% komentowanie/ odkomentowywanie: ctrl+r / ctrl+t

% Zadanie A
%------------------
N = 10;
density = 3; % parametr decyduj¹cy o gestosci polaczen miedzy stronami
indeks = 184738;
[Edges] = generate_network(N, density); % [Edges] = generate_network(N, density, indeks);
%-----------------

% Zadanie B
%------------------
% generacja macierzy I, A, B i wektora b
% ...
% macierze A, B i I musz¹ byæ przechowywane w formacie sparse (rzadkim)
d = 0.85;
B = sparse(Edges(2,:), Edges(1,:), 1, N, N);
I = speye(N);
L = zeros(1,N);
A = speye(N);
for i = 1:N
  L(i) = sum(B(:,i));
  A(i,i)=A(i,i)/L(i);
end
b = zeros(N,1);
b = ((b+1)-d)/N;

save zadB_184738 A B I b
%-----------------



%-----------------
% Zadanie C
%-----------------
% rozwiazanie ukladu rownan

M = sparse(I - d * B * A);
r = M \ b;

save zadC_184738 r



% Zadanie D
%------------------
clc
clear all
close all

N = [500, 1000, 3000, 6000, 12000];
d = 0.85;
density = 10;

for i = 1:5
    [Edges] = generate_network(N(i), density);
    B = sparse(Edges(2,:), Edges(1,:), 1, N(i), N(i));
    I = speye(N(i));
    L = zeros(1,N(i));
    A = speye(N(i));
    for j = 1:N(i)
      L(j) = sum(B(:,j));
      A(j,j)=A(j,j)/L(j);
    end
    b = zeros(N(i),1);
    b = ((b+1)-d)/N(i);
    M = sparse(I - d * B * A);

    tic
    r = M \ b;
    czas_Gauss(i) = toc;
end

plot(N, czas_Gauss)
title("Czas bezpoœredniego rozwi¹zania uk³adu równañ w zale¿noœci od liczby stron");
xlabel("Liczba stron");
ylabel("Czas [s]");
saveas(gcf,'zadD_184738.png')
%------------------



% Zadanie E
%------------------
clc
clear all
close all

% przyk³ad dzia³ania funkcji tril, triu, diag:
% Z = rand(4,4)
% tril(Z,-1) 
% triu(Z,1) 
% diag(diag(Z))
N = [500, 1000, 3000, 6000, 12000];
density = 10;
d = 0.85;
stop = 10^(-14);

for i = 1:5
    [Edges] = generate_network(N(i), density);
    B = sparse(Edges(2,:), Edges(1,:), 1, N(i), N(i));
    I = speye(N(i));
    L = zeros(1,N(i));
    A = speye(N(i));
    for j = 1:N(i)
      L(j) = sum(B(:,j));
      A(j,j)=A(j,j)/L(j);
    end
    b = zeros(N(i),1);
    b = ((b+1)-d)/N(i);
    M = sparse(I - d * B * A);

    r = ones(N(i), 1);
    D = diag(diag(M));
    U = triu(M, 1);
    L = tril(M, -1);
    first = (-D)^(-1) * (L + U);
    second = D^(-1) * b;

    iterations(i) = 1;
    res = 1;
    k = 1;
    tic
    while norm(res) >= stop
        if N(i) == 500
            normres(k) = norm(res);
            k = k + 1;
        end
        r = first * r + second;
        res = M * r - b;
        iterations(i) = iterations(i) + 1;
    end
    czas_Jacobi(i) = toc;
end

plot(N, czas_Jacobi);
title("Czas analizy w zale¿noœci od liczby stron (metoda Jacobiego)");
xlabel("Liczba stron");
ylabel("Czas [s]");
saveas(gcf, "zadE_184738_1.png");

plot(N, iterations);
title("Liczba iteracji w zale¿noœci od liczby stron (metoda Jacobiego)");
xlabel("Liczba stron");
ylabel("Liczba iteracji");
saveas(gcf, "zadE_184738_2.png");

semilogy(normres);
title("Norma residuum w dla kolejnych iteracji (metoda Jacobiego)");
xlabel("Iteracje");
ylabel("Norma residuum")
saveas(gcf, "zadE_184738_3.png");
%------------------