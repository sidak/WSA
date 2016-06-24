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
M_laptops = load('../mat/laptops_distMatrix.mat');
m1 = load('../mat/laptops_score1.mat');
m5 = load('../mat/laptops_score5.mat');
M_laptops = M_laptops.M_laptops;
M = M_laptops/median(M_laptops(:));
m1 = m1.m1;
m5 = m5.m5;
% Normalize by rows
m1 = spdiags(spfun(@(x) 1./x, sum(m1, 2)), 0, size(m1, 1), size(m1, 1)) * m1;
m5 = spdiags(spfun(@(x) 1./x, sum(m5, 2)), 0, size(m5, 1), size(m5, 1)) * m5;
m1 = m1';
m5 = m5';
[c1, count1] = wassersteinBarycenter(m1, M_laptops, 10000, 20, false, 1e-8);
[c5, count5] = wassersteinBarycenter(m5, M_laptops, 10000, 20, false, 1e-8);
save('../mat/laptops_barycenter1.mat', 'c1');