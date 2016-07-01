function [train, test] = partition(fname, score)
load(strcat('../mat/', fname, '_score', int2str(score), '.mat'));
n = size(m, 1);
c = cvpartition(n, 'Holdout', 0.25);
train = m(c.training, :);
test = m(c.test, :);
save(strcat('../mat/', fname, '_score', int2str(score), '_train.mat'), 'train');
save(strcat('../mat/', fname, '_score', int2str(score), '_test.mat'), 'test');
end