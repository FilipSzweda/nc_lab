a = 1;
r_max = 0.2;
n_max = 100;
n = 0;
xRecorded = [];
yRecorded = [];
rRecorded = [];
rand_counts = zeros(1, n_max);
av_rand_counts = zeros(1, n_max);
areas = [];

while(n < n_max)
    fits = false;
    rand_count = 0;
    while(fits == false)
        x = rand(1) * a;
        y = rand(1) * a;
        r = rand(1) * r_max;
        xLeft = x - r;
        xRight = x + r;
        yUp = y + r;
        yDown = y - r;
        if (xRight < a && xLeft > 0 && yUp < a && yDown > 0)
          fits = true;
        end
        rand_count = rand_count + 1;
    end
    test = 0;
    if (n>0 && fits)
      for i = 1:n
          value = sqrt((xRecorded(i) - x)^2+(yRecorded(i) - y)^2);
          if(value < rRecorded(i)+r)
              fits = false;
              break;
          end
      end
    end
  if(fits == true)
    axis equal;
    plot_circ(x,y,r);
    hold on;
    n = n + 1;
    xRecorded(n) = x;
    yRecorded(n) = y;
    rRecorded(n) = r;
    area = pi * r * r;
    if (n == 1)
        areas(n) = area;
        rand_sum = sum(rand_counts);
        rand_counts(n) = rand_count;
        av_rand_counts(n) = rand_sum/n;
    else
        areas(n) = areas(n-1) + area;
        rand_sum = sum(rand_counts);
        rand_counts(n) = rand_count;
        av_rand_counts(n) = rand_sum/n;
    end
    
    fprintf(1, ' %s%5d%s%.3g\r ', 'n =', n, ' S = ', area)
    pause(0.01)
  end
end

figure('Name', 'Powierzchnia calkowita');
semilogx(1:n, areas);
title('Powierzchnia calkowita');
xlabel('n');
ylabel('Powierzchnia');
saveas(gcf, 'wykres1.png');

figure('Name', 'Srednia liczba losowan');
loglog(av_rand_counts);
title('Srednia liczba losowan');
xlabel('n');
ylabel('Liczba losowan');
saveas(gcf, 'wykres2.png');

function plot_circ(X, Y, R)
theta = linspace(0,2*pi);
x = R*cos(theta) + X;
y = R*sin(theta) + Y;
plot(x,y)
end