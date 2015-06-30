function lesionprofile=digibreast_lesionprofile(node,centroid,size)

%
% lesionprofile=digibreast_lesionprofile(node,centroid,size)
%
% Generate the Gaussian sphere lesion profile at defined centroid.
%
% Author: Bin Deng (bdeng1 <at> nmr.mgh.harvard.edu)
%         Qianqian Fang (fangq <at> nmr.mgh.harvard.edu)
%
% input:
%   node: existing tetrahedral mesh node list (N x 3 array, in length unit)
%   centroid: [x,y,z] coordinates of the lesion center (in length unit)
%   size: full width half maximum (FWHM) of the Gaussian sphere profile (in length unit)
%
% output:
%   lesionprofile: lesion profile with a Gaussian sphere shape (N x 1 array, in length unit)
%
% reference:
%    [Deng2015] B. Deng, D. H. Brooks, D. A. Boas, M. Lundqvist, and Q. Fang, "Characterization of 
%               structural-prior guided optical tomography using realistic breast models derived 
%               from dual-energy x-ray mammography," Biomedical Optics Express 6(7): 2366-79 (2015)
%
% -- this function is part of the OpenJData Project (http://openjd.sf.net/digibreast)
%

if(nargin<2)
    centroid=zeros(1,size(node,2));
end

if(nargin<3)
    sigma=1;
else
    sigma=size/2.355;
end

dim=size(node,2);
normalizor=1./(sqrt(2*pi)*sigma).^dim;

coef=-1./(2*sigma*sigma);
dist=node-repmat(centroid(:)',size(node,1),1);
dist=sum(dist.*dist,2);
lesionprofile=normalizor.*exp(dist.*coef);

lesionprofile=lesionprofile/normalizor;
    
end

