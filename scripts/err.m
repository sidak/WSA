clear all;
close all;

fname = 'laptops';
load(strcat('../mat/', fname, '_distMatrix.mat'));

normalize = @(p) p/sum(p(:));

M = M_laptops/median(M_laptops(:));

% Set lambda
lambda = 20;

% Pre-compute K and U
K = exp(-lambda*M);
K(K<1e-200)=1e-200;
U = K.*M;

load(strcat('../mat/', fname, '_geodesic.mat'));
geodesic = bcenters;

for i = 5
    errors = [];
    scores = [];

    bar = waitbar(0, 'Computing...');

    load(strcat('../mat/', fname, '_score', int2str(i), '.mat'));
    m = m(sum(m, 2) ~= 0, :);
    m = spdiags(spfun(@(x) 1./x, sum(m, 2)), 0, size(m, 1), size(m, 1)) * m;

    counter = size(m, 1);
    step = 1/counter;
    
    for j = 1:counter
        waitbar(step*j, bar, sprintf('%.2f%%...', step*j*100));
        h = m(j, :);
        %h = full(h);
        h = normalize(h);
        [err, score] = computeError(h, geodesic, K, U, lambda);
        errors = [errors err];
        scores = [scores score];
    end
    
    close(bar);
    
    save(strcat('../mat/', fname, '_score', int2str(i), '_err.mat'), 'errors');
    save(strcat('../mat/', fname, '_score', int2str(i), '_proj.mat'), 'scores');
end