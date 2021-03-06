% Modified listfile v 1.3 (original from Yi-Hsuan Yang)
% The last author: Chin-Chia Yeh 2013/8/29
%
% file_list = listfile(path, ext, verbose)
% ext = '.m' for all .m files
% ext = false for all file type
%

function files = listfile_query_by_format(path, ext, verbose, parent_files)
if ~exist('verbose', 'var')
    verbose = false;
end
if ~exist('ext', 'var')
    ext = false;
end
if ~exist('parent_files', 'var')
    parent_files = {};
end
%% search dir only
names = dir(path);
current_files = cell(size(names));
isfile = false(size(names));
for n = 1:length(names)
    if strcmp(names(n).name, '..')
        continue;
    elseif strcmp(names(n).name, '.')
        continue;
    else
        f = fullfile(path, names(n).name);
    end
    if exist(f, 'dir')==7 % directory
        parent_files = listfile_query_by_format(f, ext, verbose, parent_files);
    else % file
        continue;
    end
end

%% search for current directory with format
clear names
root_path = pwd;
cd(path);
names = cellstr(ls(ext));
cd(root_path);
for n=1:size(names, 1)    
    if strcmp(names{n}, '..'), continue;
    elseif strcmp(names{n}, '.'), continue;
    else f = fullfile(path,names{n});
    end
    if exist(f, 'dir')==7, % directory
        continue;
    end
    parent_files = [parent_files; f];
    if verbose, disp(['add: ' f]); end    
end

current_files = current_files(isfile);
files = [parent_files; current_files];