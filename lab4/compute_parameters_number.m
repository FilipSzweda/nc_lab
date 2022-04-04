function [value] = compute_parameters_number( N )
    t = (N^1.43+N^1.14)/1000;
    value = t - 5000;
end
