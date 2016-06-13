clear all;
close all;

% Loading data
h = waitbar(0, 'Loading data...')

dirname = 'laptops';
load(strcat('../mat/', dirname, '_reviewText.mat'));

waitbar(100, h, 'Done!')
close(h)

% TODO
% Cleaning the words
% - Separate words with dot
% - Separate words like 'youAgain'
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
    text = cell2mat(text);
    if not(isempty(text))
        % Replace dot with an arbitrary special character, e.g. '+', so
        % that it could be removed afterward
        expr = regexp(text, '[a-z_0-9]\.([A-Z]|\s)');
        text(expr+1) = '+';
        text = regexprep(text, expression, replace);

        current = strsplit(text);
        current = unique(current);
        words = cat(1, words, current');
        words = unique(words);
    end
end

close(h)

% Saving the processed data
h = waitbar(0, 'Saving data...')

save(strcat('../mat/', dirname, '_words.mat'), 'words')

waitbar(100, h, 'Done!')
close(h)