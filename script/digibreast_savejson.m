function digibreast_savejson(matfile,outputdir,varargin)
%
% digibreast_savejson(matfile,outputdir)
%  or
% digibreast_savejson(matfile,outputdir,'param1',value1,'param2',value2,...)
%
% Export DigiBreast mesh data into JSON and UBJSON files
%
% Author: Qianqian Fang (fangq <at> nmr.mgh.harvard.edu)
%
% input:
%   matfile: the full or relative path to the DigiBreast.mat file
%   outputdir: (optional) the output folder where the JSON data will be written;
%        the JSON files will be saved under the 'json' subfolder with a suffix '.json';
%        the UBJSON files will be saved under 'ubjson' subfolder with a suffix '.ubj'
%        if ignored, the folders will be created under the path containing the .mat file
%   param1,value1,...:  optional savejson parameters, see "help savejson" for details
%
%
% -- this function is part of the OpenJData Project (http://openjd.sf.net/digibreast)
%

if(~exist(matfile,'file'))
    error('matfile does not exist');
end

dat=load(matfile);

if(nargin==1)
    outputdir=fileparts(matfile);
end

jsondir=[outputdir filesep 'json'];
if(~exist(jsondir,'dir'))
    success=mkdir(outputdir, 'json');
    if(success==0)
        error(['can not create folder ' jsondir]);
    end
end

ubjdir=[outputdir filesep 'ubjson'];
if(~exist(ubjdir,'dir'))
    success=mkdir(outputdir, 'ubjson');
    if(success==0)
        error(['can not create folder ' ubjdir]);
    end
end

names=fieldnames(dat);

for i=1:length(names)
    savejson  ('',dat.(names{i}),'FileName',[jsondir filesep names{i} '.json'],'ArrayIndent',0,varargin{:});
    saveubjson('',dat.(names{i}),'FileName',[ubjdir  filesep names{i} '.ubj']);
end

%disp('JSON file export succeeded');
