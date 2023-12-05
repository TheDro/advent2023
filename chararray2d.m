function result = chararray2d(data)
    result = [];
    rows = strsplit(data, "\n");
    for ii=1:length(rows)
      result(ii,:) = rows{ii};
    end
    result = char(result);
end