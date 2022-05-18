load trajektoria1

plot3(x,y,z,'o')
title("Trajektoria na bazie lokalizacji");
xlabel("x");
ylabel("y");
zlabel("z");
saveas(gcf, strcat("184738_szweda_zad2.png"));