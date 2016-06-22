clear all;
close all;

fname = 'laptops';
load(strcat('../mat/', fname, '_reviewText.mat'));
load(strcat('../mat/', fname, '_scores.mat'));

keySet = [1, 2, 3, 4, 5];

dim = size(reviewText);
len = dim(2);

X1 = [];
X2 = [];
X3 = [];
X4 = [];
X5 = [];

h = waitbar(0, 'In progress...')

counter = len;
step = 1/counter;

for i = 1:len
    waitbar(step*i, h, sprintf('%.2f%%...', step*i*100))
    n = str2num(cell2mat(scores(i)));
    switch n
        case 1
            X1 = [X1 reviewText(i)];
        case 2
            X2 = [X2 reviewText(i)];
        case 3
            X3 = [X3 reviewText(i)];
        case 4
            X4 = [X4 reviewText(i)];
        case 5
            X5 = [X5 reviewText(i)];
    end
end

close(h)

valueSet = [{X1}, {X2}, {X3}, {X4}, {X5}];
scoreMap = containers.Map(keySet, valueSet);

save(strcat('../mat/', fname, '_scoreMap.mat'), 'scoreMap')