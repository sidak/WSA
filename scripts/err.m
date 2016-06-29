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
load(strcat('../mat/', fname, '_score1.mat'));
m1 = spdiags(spfun(@(x) 1./x, sum(m1, 2)), 0, size(m1, 1), size(m1, 1)) * m1;
geodesic = bcenters;

errors = [];
scores = [];

bar = waitbar(0, 'Computing...');

counter = size(m1, 1);
step = 1/counter;

for i = 1:counter
    waitbar(step*i, bar, sprintf('%.2f%%...', step*i*100));
    h = m1(i, :);
    h = full(h);
    h = normalize(h);
    [err, score] = computeError(h, geodesic, K, U, lambda);
    errors = [errors err];
    scores = [scores score];
end

close(bar);