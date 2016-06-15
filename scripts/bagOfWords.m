function [wordMap] = bagOfWords(text)
    text = cell2mat(text);
    expression = '[^a-zA-Z_0-9-.'']|--';
    replace = '\ ';
    wordMap = containers.Map;
    
    if not(isempty(text))
        % So that matched index should start from position of dot
        indices = regexp(text, '[a-z_0-9]\.') + 1;
        
        % Replace dot with space in these matched patterns
        text(indices) = ' ';
        text = regexprep(text, expression, replace);

        current = strsplit(text);
        sizeCurrent = size(current);

        for j = 1:sizeCurrent(2)
            word = cell2mat(current(j));
            if isKey(wordMap, word)
                wordMap(word) = wordMap(word) + 1;
            else    
                wordMap(word) = 1;
            end
        end
        % Later also try to remove invalid single letter words('e','o','u')    
    end
end