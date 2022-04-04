function [xvect,xdif,fx,it_cnt]=bisect(a,b,eps,fun)

x = (a + b)/2;
for i = 1:1000
    % bisection algorithm 
    feval(fun,x); % use feval to obtain the value of the function in 'x' 
end


end

