clear all;
close all;

fname = 'laptops';
load(strcat('../mat/', fname, '_wordMap.mat'));

keys = wordMap.keys;
values = wordMap.values;
I = cell2mat(values) > 1;
keys = keys(I);

wordsRed = keys';
save(strcat('../mat/', fname, '_wordsRed.mat'), 'wordsRed')