Edges = sparse([1,1,2,2,2,3,3,3,4,4,5,5,6,6,7; ...
                4,6,3,4,5,5,6,7,5,6,4,6,4,7,6]);

d = 0.85;
N = 7;
I = speye(N);
B = sparse(Edges(2,:), Edges(1,:), 1, N, N);

L = zeros(1,N);
A = speye(N);
for i = 1:N
  L(i) = sum(B(:,i));
  A(i,i)=A(i,i)/L(i);
end

b = zeros(N,1);
b = ((b+1)-d)/N;

M = sparse(I - d*B*A);

r = M\b;

diary('log_184738_lab3')

[Edges] = generate_network(10, 3, 184738)
