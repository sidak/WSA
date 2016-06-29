function score = computeError(h, geodesic)
dist = pdist2(h, geodesic, 'cosine');
proj = find(dist==min(dist));
score = (proj-1)/10 + 1;
end