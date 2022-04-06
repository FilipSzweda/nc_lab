function [value] = compute_time( t )
    g = 9.81;
    m_zero = 150000;
    q = 2700;
    u = 2000;
    v = u*log(m_zero/(m_zero-q*t))-g*t;
    value = v - 750;
    return;
end
