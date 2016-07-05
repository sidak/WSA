clear all;
close all;

% Compute the barycenter of reviews with score 1 and 5
%M_cos = load('../mat/laptops_distMatrixCos.mat');
M_euc = load('../mat/laptops_distMatrixEuc.mat');
m1 = load('../mat/laptops_score1_train.mat');
m5 = load('../mat/laptops_score5_train.mat');
%M = M_cos.M_cos;
M = M_euc.M_euc;
M = M/median(M(:));
m1 = m1.train;
m1 = m1(sum(m1, 2) ~= 0, :);
m5 = m5.train;
m5 = m5(sum(m5, 2) ~= 0, :);
% Normalize by rows
m1 = spdiags(spfun(@(x) 1./x, sum(m1, 2)), 0, size(m1, 1), size(m1, 1)) * m1;
m5 = spdiags(spfun(@(x) 1./x, sum(m5, 2)), 0, size(m5, 1), size(m5, 1)) * m5;
m1 = m1';
m5 = m5';
[c1, count1] = wassersteinBarycenter(m1, M, 10000, 20, false, 1e-4);
[c5, count5] = wassersteinBarycenter(m5, M, 10000, 20, false, 1e-4);
%save('../mat/laptops_barycenter1_cos.mat', 'c1');
%save('../mat/laptops_barycenter5_cos.mat', 'c5');
save('../mat/laptops_barycenter1_euc.mat', 'c1');
save('../mat/laptops_barycenter5_euc.mat', 'c5');