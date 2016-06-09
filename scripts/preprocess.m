files = dir('./laptops/*.json')
data = []
for file = files'
    json = loadjson(file.name)
    reviews = cell2mat(json.Reviews)
    data = cat(1, data, reviews')
end

scores = {data.Overall}
reviewText = {data.Content}

save('scores.mat', 'scores')
save('reviewText.mat', 'reviewText')
