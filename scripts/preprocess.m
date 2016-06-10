dirname = 'laptops'
files = dir(strcat('../raw/AmazonReviews/', dirname, '/*.json'))
data = []

for file = files'
    json = loadjson(strcat('../raw/AmazonReviews/', dirname, '/', file.name));
    reviews = cell2mat(json.Reviews);
    data = cat(1, data, reviews');
end

scores = {data.Overall};
reviewText = {data.Content};

save(strcat('../data/', dirname, '_scores.mat'), 'scores')
save(strcat('../data/', dirname, '_reviewText.mat'), 'reviewText')
