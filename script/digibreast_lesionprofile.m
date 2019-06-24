function lesionprofile=digibreast_lesionprofile(node,centroid,fwhmsize)
%
% lesionprofile=digibreast_lesionprofile(node,centroid,fwhmsize)
%
% Generate the Gaussian sphere lesion profile at defined centroid.
%
% Author: Bin Deng (bdeng1 <at> nmr.mgh.harvard.edu)
%         Qianqian Fang (q.fang <at> neu.edu)
%
% input:
%   node: tetrahedral mesh node list (N x 3 array, in length unit)
%   centroid: [x,y,z] coordinates of the lesion center (in length unit)
%   size: full width half maximum (FWHM) of the Gaussian sphere profile (in length unit)
%
% output:
%   lesionprofile: lesion profile with a Gaussian sphere shape (N x 1 array, in length unit)
%
% example:
%   % to generate a Gaussian lesion profile that represents the volume fractions of a 5mm FWHM size lesion located within the adipose vicinity as shown in [Deng2015] on the forward mesh
%   node=ForwardMesh.node;
%   centroid=LesionCentroids.adipose;
%   fwhmsize=5;
%   lesionprofile=digibreast_lesionprofile(node,centroid,fwhmsize);
%   figure;plotmesh([ForwardMesh.node lesionprofile],ForwardMesh.elem,'z=15','linestyle','none');colorbar;
%
% reference:
%    [Deng2015] B. Deng, D. H. Brooks, D. A. Boas, M. Lundqvist, and Q. Fang, "Characterization of 
%               structural-prior guided optical tomography using realistic breast models derived 
%               from dual-energy x-ray mammography," Biomedical Optics Express 6(7): 2366-79 (2015)
%
% license:
%    BSD License, see LICENSE_BSD.txt file for details
%
% -- this function is part of the OpenJData Project (http://openjd.sf.net/digibreast)
%

if(nargin<2)
    centroid=zeros(1,size(node,2));
end

if(nargin<3)
    sigma=1;
else
    sigma=fwhmsize/2.355;
end

dim=size(node,2);
normalizor=1./(sqrt(2*pi)*sigma).^dim;

coef=-1./(2*sigma*sigma);
dist=node-repmat(centroid(:)',size(node,1),1);
dist=sum(dist.*dist,2);
lesionprofile=normalizor.*exp(dist.*coef);

lesionprofile=lesionprofile/normalizor;
    
end

