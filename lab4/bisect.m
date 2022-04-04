function [xvect,xdif,fx,it_cnt]=bisect(a,b,eps,fun)
    xvect = [];
    xdif = [];
    fx = [];
    it_cnt = 0;
    
    for i = 1:1000
        x = (a + b)/2;
        f_x = feval(fun,x);
        
        xvect(i) = x;
        fx(i) = f_x;
        if i > 1
            xdif(i-1) = abs(xvect(2)-xvect(1));
        end
        
        if abs(f_x) < eps || abs(a-b) < eps
            it_cnt = i;
            return;
        elseif feval(fun, a)*f_x < 0
            b = x;
        else
            a = x;
        end
    end
end

