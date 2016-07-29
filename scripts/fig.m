clear all;
close all;

load('../mat/laptops_score1_proj.mat');
score1 = scores;

load('../mat/laptops_score2_proj.mat');
score2 = scores;

load('../mat/laptops_score3_proj.mat');
score3 = scores;

load('../mat/laptops_score4_proj.mat');
score4 = scores;

load('../mat/laptops_score5_proj.mat');
score5 = scores;

% figure;
% X = [1 2 3 4 5];
% Y1 = [length(score1(score1==1))/length(score1)];
% Y1 = [Y1 length(score2(score2==1))/length(score2)];
% Y1 = [Y1 length(score3(score3==1))/length(score3)];
% Y1 = [Y1 length(score4(score4==1))/length(score4)];
% Y1 = [Y1 length(score5(score5==1))/length(score5)];
% plot(X, Y1);
% hold on;
% Y5 = [length(score1(score1==5))/length(score1)];
% Y5 = [Y5 length(score2(score2==5))/length(score2)];
% Y5 = [Y5 length(score3(score3==5))/length(score3)];
% Y5 = [Y5 length(score4(score4==5))/length(score4)];
% Y5 = [Y5 length(score5(score5==5))/length(score5)];
% plot(X, Y5);
% hold off;
 
figure;
T = 1:0.1:5;
Y = []
for t = 1:0.1:5
    num = 0;
    num = num + length(score1(score1==t));
    num = num + length(score2(score2==t));
    num = num + length(score3(score3==t));
    num = num + length(score4(score4==t));
    num = num + length(score5(score5==t));
    Y = [Y num];
end
fig1 = plot(T, Y);
xlabel('Score');
ylabel('Number of reviews');
saveas(fig1, '../fig/score_dist.png');

figure;
S = 1:5;
N = [length(score1) length(score2) length(score3) length(score4) length(score5)];
fig2 = plot(S, N);
xlabel('Score');
ylabel('Number of reviews');
saveas(fig2, '../fig/score_ideal.png');

load(strcat('../mat/laptops_distMatrixCos.mat'));

normalize = @(p) p/sum(p(:));

M = M_cos/median(M_cos(:));

% Set lambda
lambda = 20;

% Pre-compute K and U
K = exp(-lambda*M);
K(K<1e-200)=1e-200;
U = K.*M;

load(strcat('../mat/laptops_geodesic.mat'));
geodesic = bcenters;

X = 0:0.025:1;

load('../mat/laptops_score1.mat');
test = cvpartition(size(m, 1), 'Holdout', 20);
m1_fig = m(test.test, :);
%save('../mat/laptops_score1_fig.mat', 'm1_fig');
fig1 = figure;
for i = 1:20
    h = m1_fig(i, :);
    h = normalize(h);
    D = sinkhornTransport(h', geodesic', K, U, lambda);
    plot(X, D);
    hold on;
end
saveas(fig1, '../fig/score1_dist_evol.png')

load('../mat/laptops_score2.mat');
test = cvpartition(size(m, 1), 'Holdout', 20);
m2_fig = m(test.test, :);
%save('../mat/laptops_score2_fig.mat', 'm2_fig');
fig2 = figure;
for i = 1:20
    h = m2_fig(i, :);
    h = normalize(h);
    D = sinkhornTransport(h', geodesic', K, U, lambda);
    plot(X, D);
    hold on;
end
saveas(fig2, '../fig/score2_dist_evol.png')

load('../mat/laptops_score3.mat');
test = cvpartition(size(m, 1), 'Holdout', 20);
m3_fig = m(test.test, :);
%save('../mat/laptops_score3_fig.mat', 'm3_fig');
fig3 = figure;
for i = 1:20
    h = m3_fig(i, :);
    h = normalize(h);
    D = sinkhornTransport(h', geodesic', K, U, lambda);
    plot(X, D);
    hold on;
end
saveas(fig3, '../fig/score3_dist_evol.png')

load('../mat/laptops_score4.mat');
test = cvpartition(size(m, 1), 'Holdout', 20);
m4_fig = m(test.test, :);
%save('../mat/laptops_score4_fig.mat', 'm4_fig');
fig4 = figure;
for i = 1:20
    h = m4_fig(i, :);
    h = normalize(h);
    D = sinkhornTransport(h', geodesic', K, U, lambda);
    plot(X, D);
    hold on;
end
saveas(fig4, '../fig/score4_dist_evol.png')

load('../mat/laptops_score5.mat');
test = cvpartition(size(m, 1), 'Holdout', 20);
m5_fig = m(test.test, :);
%save('../mat/laptops_score5_fig.mat', 'm5_fig');
fig5 = figure;
for i = 1:20
    h = m5_fig(i, :);
    h = normalize(h);
    D = sinkhornTransport(h', geodesic', K, U, lambda);
    plot(X, D);
    hold on;
end
saveas(fig5, '../fig/score5_dist_evol.png')

% load('../mat/laptops_wordMap.mat');
% load('../mat/laptops_dictRed.mat');
% counts = [];
% for i = 1:length(dictRed)
%     counts = [counts wordMap(cell2mat(dictRed(i)))];
% end
% 
% load('../mat/laptops_geodesic.mat');
% X = 1:41;
% Y = bcenters(:, counts>10000);
% Y = Y';
% fig0 = figure;
% for i = 1:25;
%     subplot(5, 5, i)
%     plot(X,Y(i,:));
%     hold on;
% end
% saveas(fig0, '../fig/frequent.png')