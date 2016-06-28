clear all;
close all;

% Loading data
load('../mat/laptops_barycenter1.mat');
load('../mat/laptops_barycenter5.mat');
load('../mat/laptops_distMatrix.mat');
M = M_laptops/median(M_laptops(:));
bcenters = [];
ends = [c1 c5];

h = waitbar(0, 'Calculating the geodesic...');
count = 41;
step = 1/count;

for t = 0.025:0.025:4.975
    waitbar(step*i, h, sprintf('%.2f%%...', step*i*100))
    weights = [t 1-t];
    center = wassersteinBarycenter(ends, M, 10000, 20, false, 1e-8, weights);
    bcenters = [bcenters; center]
end

close(h);

bcenters = [c1; bcenters; c5];
save('../mat/laptops_geodesic.mat', 'bcenters');