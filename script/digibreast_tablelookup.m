function val=digibreast_tablelookup(proplist,tissuetype,propname)
%
% val=digibreast_tablelookup(proplist,tissuetyoe,propname)
%
% Search optical properties from the OpticalProperties table by tissue and property names
%
% Author: Qianqian Fang (fangq <at> nmr.mgh.harvard.edu)
%
% input:
%   proplist: the OpticalProperties (2D cell array with the first column/row as indices)
%   tissuetype: a string for the desired tissue type (case insensitive), possible values 
%             include 'adi','fib','malig'
%   propname: a string for the desired optical property name (case insensitive), possible
%             values include 'hbo','hbr','so_2','s_amp','s_power','musp_830','musp_690'
%
% example:
%   Sp_fib=digibreast_tablelookup(OpticalProperties,'fib','s_power');
%
% license:
%    BSD License, see LICENSE_BSD.txt file for details
%
% -- this function is part of the OpenJData Project (http://openjd.sf.net/digibreast)
%

rowid=find(strcmpi(proplist(:,1),tissuetype));
if(isempty(rowid))
   error('tissue type can not be found');
end
colid=find(strcmpi(proplist(1,:),propname));
if(isempty(colid))
   error('property type can not be found');
end
val=proplist{rowid,colid};
