%load('../mat/laptops_geodesic.mat');
%load('../mat/laptops_dictRed.mat');

%[sortedValues, sortIndex] = sort(bcenters', 'descend');
%sortedValues = sortedValues';
%sortIndex = sortIndex';
%maxIndex = sortIndex(:, 1:30);
%frequentWords = dictRed(maxIndex);
%frequentWords = frequentWords';
%save('../mat/laptops_frequentWords.mat', 'frequentWords');
%csvwrite('../mat/laptops_frequentWords.csv', frequentWords, 30 ,41);

load('../mat/laptops_distMatrixCos.mat');
load('../mat/laptops_score1_train.mat');
test1 = cvpartition(size(train, 1), 'Holdout', 20);
test1 = train(test1.test, :);
load('../mat/laptops_score2_train.mat');
test2 = cvpartition(size(train, 1), 'Holdout', 20);
test2 = train(test2.test, :);
load('../mat/laptops_score3_train.mat');
test3 = cvpartition(size(train, 1), 'Holdout', 20);
test3 = train(test3.test, :);
load('../mat/laptops_score4_train.mat');
test4 = cvpartition(size(train, 1), 'Holdout', 20);
test4 = train(test4.test, :);
load('../mat/laptops_score5_train.mat');
test5 = cvpartition(size(train, 1), 'Holdout', 20);
test5 = train(test5.test, :);
test = [test1; test2; test3; test4; test5];

normalize = @(p) p/sum(p(:));

M = M_cos/median(M_cos(:));
%M = M_euc/median(M_euc(:));

% Set lambda
lambda = 20;

% Pre-compute K and U
K = exp(-lambda*M);
K(K<1e-200)=1e-200;
U = K.*M;

test = spdiags(spfun(@(x) 1./x, sum(test, 2)), 0, size(test, 1), size(test, 1)) * test;

D = zeros(100, 100);
for i = 1:100
    for j = (i+1):100
        D(i, j) = sinkhornTransport(test(i, :)', test(j, :)', K, U, lambda)
    end
end
for j = 1:100
    for i = (j+1):100
        D(i, j) = D(j, i);
    end
end