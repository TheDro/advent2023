data = strsplit(fileread('day04.test'), "\n");
data = strsplit(fileread('day04.data'), "\n");


winning_numbers = {};
picked_numbers = {};
won_numbers = [];

for ii = 1:length(data)
    line = data{ii};
    numbers = strsplit(line, ':')(end);
    lists  = strsplit(numbers{1}, '|');
    winning_numbers{ii} = str2double(strsplit(strtrim(lists{1}), ' '));
    picked_numbers{ii} = str2double(strsplit(strtrim(lists{2}), ' '));
    
    won_numbers(ii) = sum(ismember(winning_numbers{ii}, picked_numbers{ii}));

end

points = floor(2.^(won_numbers-1))
result_1 = sum(points)


multipliers = ones(size(won_numbers));
total_wins = 0;
for ii = 1:length(won_numbers)
    total_wins = total_wins + multipliers(ii);
    multipliers(ii+(1:won_numbers(ii))) = multipliers(ii+(1:won_numbers(ii))) + multipliers(ii);

end

total_wins