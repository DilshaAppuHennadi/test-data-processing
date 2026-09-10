function fileData = OpenDAT(fileName)
%OpenDAT Open .dat file
%   This function checks the given file name to make sure the file exists,
%   if so, it will import and return the stored data. Otherwise, it throws
%   an error to the user stating the file does not exist
if ~isfile(fileName)
    error('openMyFile:FileNotFound', ...
        'File does not exist: %s', fileName);
end

fileData = importdata(fileName);
end