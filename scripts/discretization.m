clear all;
close all;

% Loading data
load('../mat/laptops_barycenter1.mat');
load('../mat/laptops_barycenter5.mat');
load('../mat/laptops_distMatrix.mat');
M = M_laptops/median(M_laptops(:));
bcenters = [];
ends = [c1 c5];
%counts = [];

for t = 0.025:0.025:0.975
    weights = [t 1-t];
    center = wassersteinBarycenter(ends, M, 10000, 20, false, 1e-4, weights);
    center = center';
    bcenters = [bcenters; center];
    %counts = [counts count];
end

close(h);

bcenters = [c1'; bcenters; c5'];
save('../mat/laptops_geodesic.mat', 'bcenters');
%save('../mat/laptops_counts.mat', 'counts');