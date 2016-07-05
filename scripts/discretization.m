clear all;
close all;

% Loading data
load('../mat/laptops_barycenter1_cos.mat');
load('../mat/laptops_barycenter5_cos.mat');
load('../mat/laptops_distMatrixCos.mat');
M = M_cos/median(M_cos(:));
bcenters = [];
ends = [c1 c5];
%counts = [];

for t = 0.025:0.025:0.975
    weights = [1-t t];
    center = wassersteinBarycenter(ends, M, 10000, 20, false, 1e-4, weights);
    center = center';
    bcenters = [bcenters; center];
    %counts = [counts count];
end

bcenters = [c1'; bcenters; c5'];
save('../mat/laptops_geodesic.mat', 'bcenters');
%save('../mat/laptops_counts.mat', 'counts');