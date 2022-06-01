function ft = gestosc_prawdopodobienstwa (t)
  sigma = 3;
  mi = 10;
  
  ft = (1 / (sigma * sqrt(2 * pi))) * exp(-(t - mi)^2 /(2 * sigma^2));
end