clear all;
close all;

fname = 'laptops';
load(strcat('../mat/', fname, '_scoreMap.mat'));
dict = load(strcat('../mat/', fname, '_dictRed.mat'));
vec = load(strcat('../mat/', fname, '_vecRed.mat'));
dict = dict.dictRed;
vec = vec.vecRed;

normalize = @(p) p/sum(p);

s1 = scoreMap(1);
s5 = scoreMap(5);

len_y = length(dict);
len_x1 = length(s1);
len_x5 = length(s5);
I1 = [];
J1 = [];
V1 = [];
%I5 = [];
%J5 = [];
%V5 = [];

h = waitbar(0, 'Constructing...');
counter = len_y;
step = 1/counter;

for i = 1:len_x1
    waitbar(step*i, h, sprintf('%.2f%%...', step*i*100))
    b = bagOfWords(s1(i));
    for j = 1:len_y
        if isKey(b, cell2mat(dict(j)))
            I1 = [I1 i];
            J1 = [J1 j];
            V1 = [V1 b(cell2mat(dict(j)))];
        end
    end
end
%for i = 1:len_x5
%    waitbar(step*i, h, sprintf('%.2f%%...', step*i*100))
%    b = bagOfWords(s5(i));
%    for j = 1:len_y
%        if isKey(b, cell2mat(dict(j)))
%            I5 = [I5 i];
%            J5 = [J5 j];
%            V5 = [V5 b(cell2mat(dict(j)))];
%        end
%    end
%end

close(h)

m1 = sparse(I1, J1, V1, len_x1, len_y);
%m2 = sparse(I5, J5, V5, len_x5, len_y);