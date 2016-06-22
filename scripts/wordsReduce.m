clear all;
close all;

dirname = 'laptops';
load(strcat('../mat/', dirname, '_wordMap.mat'));

keys = wordMap.keys;
values = wordMap.values;
I = cell2mat(values) > 1;
keys = keys(I);

wordsRed = keys';
save(strcat('../mat/', dirname, '_wordsRed.mat'), 'wordsRed')