clear all;
close all;

% Loading data
%load('../mat/laptops_barycenter1_cos.mat');
%load('../mat/laptops_barycenter5_cos.mat');
load('../mat/laptops_barycenter1_euc.mat');
load('../mat/laptops_barycenter5_euc.mat');
%load('../mat/laptops_distMatrixCos.mat');
load('../mat/laptops_distMatrixEuc.mat');
%M = M_cos/median(M_cos(:));
M = M_euc/median(M_euc(:));
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
%save('../mat/laptops_geodesic_cos.mat', 'bcenters');
save('../mat/laptops_geodesic_euc.mat', 'bcenters');
%save('../mat/laptops_counts.mat', 'counts');