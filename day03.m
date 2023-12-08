data = chararray2d(erase(fileread('day03.test'), "\r"))
% data = chararray2d(erase(fileread('day03.data'), "\r"))


total = 0
for ii = 1:size(data,1)
  line = data(ii,:)
  [firsts,lasts] = regexp(line, '\d+')
  for iDigit = 1:length(firsts)
    number = str2num(line(firsts(iDigit):lasts(iDigit)))
  end
end