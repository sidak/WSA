function h = entropy(x)
x = double(x);
i = find(x);
h = -sum(x(i) .* log2(x(i)));
end