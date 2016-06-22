function M = distMatrix(fname, distance)
load(strcat('../mat/', fname, '_vecRed.mat'));

vec = vecRed';
D = pdist(vec, distance);
M = squareform(D);
end