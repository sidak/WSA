clear all;
close all;

dirname = 'laptops';
load(strcat('../mat/', dirname, '_scoreMap.mat'));
load(strcat('../mat/', dirname, '_dict.mat'));
load(strcat('../mat/', dirname, '_vec.mat'));

normalize = @(p) p/sum(p);

s1 = scoreMap(1);
s5 = scoreMap(5);

len_y = length(dict);
len_x1 = length(s1);
len_x5 = length(s5);
I = [];
J = [];
V = [];

h = waitbar(0, 'Constructing...');
counter = len_y;
step = 1/counter;

for i = 1:len_x1
    waitbar(step*i, h, sprintf('%.2f%%...', step*i*100))
    b = bagOfWords(s1(i));
    for j = 1:len_y
        if isKey(b, cell2mat(dict(j)))
            I = [I i];
            J = [J j];
            V = [V b(cell2mat(dict(j)))];
        end
    end
end

close(h)

m1 = sparse(I, J, V, len_x1, len_y);