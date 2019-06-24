function digibreast_load(jdatafile,varargin)
%
% digibreast_load(jdatafile)
%  or
% digibreast_load(jdatafile,'param1',value1,'param2',value2,...)
%
% Load Digibreast data from text or binary JData file
%
% Author: Qianqian Fang (q.fang <at> neu.edu)
%
% input:
%   jdatafile: the full or relative path to the DigiBreast*.jdat or DigiBreast*.ubjd file
%   param1,value1,...:  optional loadjson parameters, see "help loadjson" for details
%
% license:
%    BSD License, see LICENSE_BSD.txt file for details
%
% -- this function is part of the OpenJData Project (http://openjd.sf.net/digibreast)
%

if(~exist(jdatafile,'file'))
    error('DigiBreast JData file does not exist');
end

if(regexp(filename,'\.jdat$') || regexp(filename,'\.json$'))
    data=loadjson(jdatafile,varargin{:});
elseif(regexp(filename,'\.ubjd$') || regexp(filename,'\.ubj$') )
    data=loadubjson(jdatafile,varargin{:});
else
    error('file suffix must be .json, .jdat, .ubj or .ubjd');
end

