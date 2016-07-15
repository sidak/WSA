function fval = differentiate2(a, b, r, M, lambda)
    weights = [1-r r];
    ends = [a b];
    fval = wassersteinBarycenter(ends, M, 100, lambda, false, 1e-4, weights);
end