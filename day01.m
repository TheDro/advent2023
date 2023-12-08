data = strsplit(fileread('day01.test'), "\n");
% data = strsplit(fileread('day01b.test'), "\n")
% data = strsplit(fileread('day01.data'), "\n");

function result = getCodes(data)
  data1 = {};
  result = [];
  for ii=1:size(data)(2)
    data1{ii} = strtrim(regexprep(data{ii}, '[a-z]', ''));
    content = data1{ii};
    result = [result, str2double([content(1), content(end)])];
    % for iChar = 1:floor(size(content)(2)/2)
    %   value = [content(iChar), content(end-(iChar-1))]
    %   result = [result, str2double(value)]
    % end
  end

end

% disp(sum(getCodes(data)))

numbers = {
  'one',
  'two',
  'three',
  'four',
  'five',
  'six',
  'seven',
  'eight',
  'nine',
  'zero',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '0'
};

function result = getNumbers(data, numbers)
  result = [];
  for ii=1:length(data)
    content = data{ii};

    firstLocation = 1000;
    firstNumber = -1;
    for jj=1:length(numbers)
      newLocation = strfind(content, numbers{jj});
      if ~isempty(newLocation) && newLocation(1) < firstLocation
        firstLocation = newLocation(1);
        firstNumber = mod(jj, 10);
      end
    end

    lastLocation = -1;
    lastNumber = -1;
    for jj=1:length(numbers)
      newLocation = strfind(content, numbers{jj});
      if ~isempty(newLocation) && newLocation(end) > lastLocation
        lastLocation = newLocation(end);
        lastNumber = mod(jj, 10);
      end
    end

    value = 10*firstNumber + lastNumber;
    result = [result, value];
  end
end

result = getNumbers(data, numbers)
sum(result)