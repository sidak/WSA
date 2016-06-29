function [err, score] = computeError(h, geodesic, K, U, lambda)
D = sinkhornTransport(h', geodesic', K, U, lambda);
D = D.^2;
proj = find(D==min(D));
err = min(D);
score = (proj-1)/10 + 1;
end