clear all;
close all;

% Loading data
h = waitbar(0, 'Loading data...')

fname = 'laptops';
load(strcat('../mat/', fname, '_reviewText.mat'));

waitbar(100, h, 'Done!')
close(h)

% TODO
% Cleaning the words
% - maybe separate words like 'youAgain'
% - better would be to use a map

expression = '[^a-zA-Z_0-9-.'']|--'
replace = '\ ';

dim = size(reviewText);
len = dim(2);
words = [];

% Splitting texts into words
h = waitbar(0, 'Splitting...')

counter = len;
step = 1/counter;

for i = 1:len
    waitbar(step*i, h, sprintf('%.2f%%...', step*i*100))
    text = reviewText(i);
    % Convert it into char vector
    text = cell2mat(text);
    if not(isempty(text))
        % So that matched index should start from position of dot
        indices = regexp(text, '[a-z_0-9]\.') + 1;
        
        % Replace dot with space in these matched patterns
        text(indices) = ' ';
        text = regexprep(text, expression, replace);

        current = strsplit(text);
        % Later also try to remove invalid single letter words('e','o','u')
        current = unique(current);
        
        words = cat(1, words, current');
        words = unique(words);
    end
end

close(h)

% Saving the processed data
h = waitbar(0, 'Saving data...')

save(strcat('../mat/', fname, '_words.mat'), 'words')

waitbar(100, h, 'Done!')
close(h)