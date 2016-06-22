clear all;
close all;

dirname = 'laptops';
files = dir(strcat('../data/AmazonReviews/', dirname, '/*.json'));
data = [];

for file = files'
    json = loadjson(strcat('../data/AmazonReviews/', dirname, '/', file.name));
    reviews = cell2mat(json.Reviews);
    data = cat(1, data, reviews');
end

scores = {data.Overall};
reviewText = {data.Content};

save(strcat('../mat/', dirname, '_scores.mat'), 'scores')
save(strcat('../mat/', dirname, '_reviewText.mat'), 'reviewText')
