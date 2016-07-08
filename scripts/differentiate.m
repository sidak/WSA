function differentiate

load('../mat/laptops_barycenter1_cos.mat');
load('../mat/laptops_barycenter5_cos.mat');
%load('../mat/laptops_barycenter1_euc.mat');
%load('../mat/laptops_barycenter5_euc.mat');
load('../mat/laptops_distMatrixCos.mat');
%load('../mat/laptops_distMatrixEuc.mat');
M = M_cos/median(M_cos(:));
%M = M_euc/median(M_euc(:));

% Set lambda
lambda = 20;

% Pre-compute K and U
%K = exp(-lambda*M);
%K(K<1e-200)=1e-200;
%U = K.*M;

len = length(c1);
pAD = myAD(c1);
outAD = func(pAD, c5, 0.025, M, lambda)
%dfAD = getderivs(outAD)

function fval = func(a, b, r, M, lambda)
    weights = [1-r r];
    ends = [a b];
    fval = wassersteinBarycenter(ends, M, 10000, lambda, false, 1e-4, weights);