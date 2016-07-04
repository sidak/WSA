clear all;
close all;

fname = 'laptops';

load(strcat('../mat/', fname, '_wordsRed.mat'));

cd word2vec/;
[dictRed, vecRed] = readWord2Vec('../../data/word2vec/GoogleNews-vectors-negative300.bin', wordsRed, 1);
cd ..;

save(strcat('../mat/', fname, '_dictRed.mat'), 'dictRed');
save(strcat('../mat/', fname, '_vecRed.mat'), 'vecRed');

M_cos = distMatrix(fname, 'cosine');
save('../mat/laptops_distMatrixCos.mat', 'M_cos');
M_euc = distMatrix(fname, 'euclidean');
save('../mat/laptops_distMatrixEuc.mat', 'M_euc');

% Constructing histograms
for i = 1:5;
    constructHist(fname, i);
end

% Partitioning the data
for i = 1:5;
    partition(fname, i);
end