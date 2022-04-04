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

% Zadanie C
%-----------------
% rozwiazanie ukladu rownan

M = sparse(I - d * B * A);
r = M \ b;

save zadC_184738 r
%-----------------

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
title("Czas bezpoœredniego rozwi¹zania uk³adu równañ");
xlabel("Rozmiar macierzy N");
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

    L = tril(M, -1);
    U = triu(M, 1);
    D = diag(diag(M));
    
    termOne = -D \ (L + U);
    termTwo = D \ b;

    iterations(i) = 0;

    r = ones(N(i), 1);
    res = M * r - b;
    k = 1;
    tic
    while norm(res) > stop
        if N(i) == 1000
            normres(k) = norm(res);
            k = k + 1;
        end
        r = termOne * r + termTwo;
        res = M * r - b;
        iterations(i) = iterations(i) + 1;
    end
    czas_Jacobi(i) = toc;
end

plot(N, czas_Jacobi);
title("Czas rozwi¹zania równania macierzowego (metoda Jacobiego)");
xlabel("Rozmiar macierzy N");
ylabel("Czas [s]");
saveas(gcf, "zadE_184738_1.png");

plot(N, iterations);
title("Liczba iteracji (metoda Jacobiego)");
xlabel("Rozmiar macierzy N");
ylabel("Liczba iteracji");
saveas(gcf, "zadE_184738_2.png");

semilogy(normres);
title("Norma residuum (dla N=1000, metoda Jacobiego)");
xlabel("Iteracje");
ylabel("Norma residuum")
saveas(gcf, "zadE_184738_3.png");
%------------------

% Zadanie F
%------------------
clc
clear all
close all

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

    L = tril(M, -1);
    U = triu(M, 1);
    D = diag(diag(M));

    r = ones(N(i), 1);

    termOne = -(D + L);
    termTwo = (D + L) \ b;

    iterations(i) = 1;
    res = 1;
    k = 1;
    tic
    while norm(res) > stop
        if N(i) == 1000
            normres(k) = norm(res);
            k = k + 1;
        end
        r = termOne \ (U * r) + termTwo;
        res = M * r - b;
        iterations(i) = iterations(i) + 1;
    end
    czas_GaussaSeidla(i) = toc;
end

plot(N, czas_GaussaSeidla);
title("Czas rozwi¹zania równania macierzowego (metoda Gaussa-Seidla)");
xlabel("Rozmiar macierzy N");
ylabel("Czas [s]");
saveas(gcf, "zadF_184738_1.png");

plot(N, iterations);
title("Liczba iteracji (metoda Gaussa-Seidla)");
xlabel("Rozmiar macierzy N");
ylabel("Liczba iteracji");
saveas(gcf, "zadF_184738_2.png");

semilogy(normres);
title("Norma residuum (dla N=1000, metoda Gaussa-Seidla)");
xlabel("Iteracje");
ylabel("Norma residuum")
saveas(gcf, "zadF_184738_3.png");
%------------------

% Zadanie G
%------------------
clc
clear all
close all

load Dane_Filtr_Dielektryczny_lab3_MN.mat

rDir = M \ b;

L = tril(M, -1);
U = triu(M, 1);
D = diag(diag(M));
stop = 10^(-14);

rJacobi = ones(20000, 1);
termOneJacobi = -D \ (L + U);
termTwoJacobi = D \ b;
resJacobi = M * rJacobi - b;
while norm(resJacobi) > stop
    if isnan(norm(resJacobi))
        break;
    end
    rJacobi = termOneJacobi * rJacobi + termTwoJacobi;
    resJacobi = M * rJacobi - b;
end

rGaussSeidl = ones(20000, 1);
termOneGaussSeidl = -(D + L);
termTwoGaussSeidl = (D + L) \ b;
resGaussSeidl = 1;
while norm(resGaussSeidl) > stop
    if isnan(norm(resGaussSeidl))
        break;
    end
    rGaussSeidl = termOneGaussSeidl \ (U * rGaussSeidl) + termTwoGaussSeidl;
    resGaussSeidl = M * rGaussSeidl - b;
end

%------------------