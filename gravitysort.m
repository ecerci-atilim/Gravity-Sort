% Gravity Sort
tic

n       = 2.5e3;                            % Number of integers
r       = 1e5;                              % Range of integers (from 1 to r)

rng default                                 % Default random number generator

data    = randi(r, 1, n);                   % Random data generation 
s       = zeros(length(data), max(data));   % Sorted array preallocation

for i = 1 : length(data)
    s(i,end-data(i)+1:end) = 1;
end

for i = 1 : size(s, 2)
    t = zeros(length(data), 1);
    t(end-sum(s(: ,i))+1:end) = 1;
    s(:,i)=t;
end

sorted  = sum(s, 2)';

toc