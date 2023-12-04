data = strsplit(fileread('day02.test'), "\n");
data = strsplit(fileread('day02.data'), "\n");
g.maxRed = 12;
g.maxGreen = 13;
g.maxBlue = 14;

function result = parseLine(line, g)
  parts = strsplit(line, ':');
  game = parts{1};
  rounds = strsplit(parts{2}, ';');
  redCount = 0;
  blueCount = 0;
  greenCount = 0;
  for jj = 1:length(rounds)
    round = [rounds{jj} ' 0 red 0 blue 0 green'];
    redCount = max(redCount, str2double(strsplit(regexp(round, '\d+ red', 'match'){1}, ' '){1}));
    blueCount = max(blueCount, str2double(strsplit(regexp(round, '\d+ blue', 'match'){1}, ' '){1}));
    greenCount = max(greenCount, str2double(strsplit(regexp(round, '\d+ green', 'match'){1}, ' '){1}));
  end
  result = redCount <= g.maxRed && blueCount <= g.maxBlue && greenCount <= g.maxGreen;
end

out = [];
for ii=1:length(data)
  line = data{ii};
  out = [out, parseLine(line, g)];
end

sum(out.*(1:length(out)))


function result = parseLine2(line, g)
  parts = strsplit(line, ':');
  game = parts{1};
  rounds = strsplit(parts{2}, ';');
  redCount = 0;
  blueCount = 0;
  greenCount = 0;
  for jj = 1:length(rounds)
    round = [rounds{jj} ' 0 red 0 blue 0 green'];
    redCount = max(redCount, str2double(strsplit(regexp(round, '\d+ red', 'match'){1}, ' '){1}));
    greenCount = max(greenCount, str2double(strsplit(regexp(round, '\d+ green', 'match'){1}, ' '){1}));
    blueCount = max(blueCount, str2double(strsplit(regexp(round, '\d+ blue', 'match'){1}, ' '){1}));
  end
  result = [redCount, greenCount, blueCount];
end

minimums = [];

for ii=1:length(data)
  line = data{ii};
  minimums = [minimums; parseLine2(line, g)];
end

minimums
answer2 = sum(prod(minimums,2))