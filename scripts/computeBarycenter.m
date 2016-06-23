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
T = 1:len_y;

%h = waitbar(0, 'Constructing...');
%counter = len_x1;
%counter = len_x5;
%step = 1/counter;

%for i = 1:len_x1
%    waitbar(step*i, h, sprintf('%.2f%%...', step*i*100))
%    b = bagOfWords(s1(i));
%    current = cellfun(@(x) isKey(b, x), dict);
%    J_current = T(current);
%    I_current = repmat([i], 1, length(J_current));
%    I1 = [I1 I_current];
%    J1 = [J1 J_current];
%    for j = J_current
%        V1 = [V1 b(cell2mat(dict(j)))];
%    end
%end
%for i = 1:len_x5
%    waitbar(step*i, h, sprintf('%.2f%%...', step*i*100))
%    b = bagOfWords(s5(i));
%    current = cellfun(@(x) isKey(b, x), dict);
%    J_current = T(current);
%    I_current = repmat([i], 1, length(J_current));
%    I5 = [I5 I_current];
%    J5 = [J5 J_current];
%    for j = 1:J_current
%        V5 = [V5 b(cell2mat(dict(j)))];
%    end
%end

%close(h)

%m1 = sparse(I1, J1, V1, len_x1, len_y);
%m5 = sparse(I5, J5, V5, len_x5, len_y);

%save(strcat('../mat/', fname, '_score1.mat'), 'm1');
%save(strcat('../mat/', fname, '_score5.mat'), 'm5');

% Compute the barycenter of reviews with score 1
load('../mat/laptops_dict.mat');
load('../mat/laptops_score1.mat');
m = m1';
c = wassersteinBarycenter(m, M_laptops, 10000, 100, false, 1e-8)
save('../mat/laptops_barycenter1.mat', 'c');