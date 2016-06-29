function m = constructHist(fname, label)

%fname = 'laptops';
load(strcat('../mat/', fname, '_scoreMap.mat'));
dict = load(strcat('../mat/', fname, '_dictRed.mat'));
vec = load(strcat('../mat/', fname, '_vecRed.mat'));
dict = dict.dictRed;
%vec = vec.vecRed;

%normalize = @(p) p/sum(p);

s = scoreMap(label);
len_y = length(dict);
len_x = length(s);

I = [];
J = [];
V = [];
T = 1:len_y;

h = waitbar(0, 'Constructing...');

counter = len_x;
step = 1/counter;

for i = 1:len_x
    waitbar(step*i, h, sprintf('%.2f%%...', step*i*100))
    b = bagOfWords(s1(i));
    current = cellfun(@(x) isKey(b, x), dict);
    J_current = T(current);
    I_current = repmat([i], 1, length(J_current));
    I = [I I_current];
    J = [J J_current];
    for j = J_current
        V = [V b(cell2mat(dict(j)))];
    end
end

close(h)

m = sparse(I, J, V, len_x, len_y);

str = int2str(label);
save(strcat('../mat/', fname, '_score', str, '.mat'), strcat('m', str));

end