function priors=digibreast_priors(glandularity,lesionprofile)
%
% prior=digibreast_prior(glandularity,lesionprofile)
%
% Generate tissue compositional priors for the DigiBreast phantom.
%
% Author: Bin Deng (bdeng1 <at> nmr.mgh.harvard.edu)
%         Qianqian Fang (fangq <at> nmr.mgh.harvard.edu)
%
% input:
%   glandularity: volume fractions of fibroglandular tissue (N x 1 array, values between 0 and 1)
%   lesionprofile: volume fractions of identified lesion (N x 1 array, values between 0 and 1)
%   NOTE: glandularity and lesionprofile must be defined on the same mesh
%         i.e. the length of the data array must be the same
%
% output:
%   priors: a struct contains normal (and lesion) tissue compositional priors 
%           N x 2 for normal tissue priors, i.e. 2-composition priors -- [adipose,fibroglandular]
%           N x 3 for normal and lesion tissue priors, i.e. 3-composition priors -- [adipose,fibroglandular,lesion]
%
%
% example:
%
%   % to generate 2-compositional normal tissue priors using glandularity map derived from dual gaussian segmentation algorithm
%   priors=digibreast_priors(ForwardMesh.glandularity.dualgaussian);
%   figure;
%   subplot(211);plotmesh([ForwardMesh.node priors.normal(:,1)],ForwardMesh.elem,'z=15','linestyle','none');title('Adipose tissue volume fractions');colorbar;
%   subplot(212);plotmesh([ForwardMesh.node priors.normal(:,2)],ForwardMesh.elem,'z=15','linestyle','none');title('Fibroglandular tissue volume fractions');colorbar;
%
%   % to generate 3-compositional normal and lesion tissue priors using the same glandularity map derived from dual gaussian segmentation algorithm
%   lesionprofile=digibreast_lesionprofile(ForwardMesh.node,LesionCentroids.adipose,5);
%   priors=digibreast_priors(ForwardMesh.glandularity.dualgaussian,lesionprofile);
%   figure;
%   subplot(311);plotmesh([ForwardMesh.node priors.lesion(:,1)],ForwardMesh.elem,'z=15','linestyle','none');title('Adipose tissue volume fractions');colorbar;
%   subplot(312);plotmesh([ForwardMesh.node priors.lesion(:,2)],ForwardMesh.elem,'z=15','linestyle','none');title('Fibroglandular tissue volume fractions');colorbar;
%   subplot(313);plotmesh([ForwardMesh.node priors.lesion(:,3)],ForwardMesh.elem,'z=15','linestyle','none');title('Lesion tissue volume fractions');colorbar;
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

if (nargin==1)
    if max(glandularity)>1 || min(glandularity)<0
        error('glandularity should have values between 0 and 1');
    end
    priors.normal=[1-glandularity,glandularity];
end

if (nargin==2)
    if max(glandularity)>1 || min(glandularity)<0
        error('glandularity should have values between 0 and 1');
    elseif max(lesionprofile)>1 || min(lesionprofile)<0
        error('lesion profile should have values between 0 and 1');
    elseif length(glandularity)~=length(lesionprofile)
        error('glandularity and lesion profile should be defined on the same mesh with equal length');
    end
    
    priors.normal=[1-glandularity,glandularity];
    normalizor=1-lesionprofile(:);
    priors.lesion=[(1-glandularity).*normalizor,glandularity.*normalizor,lesionprofile];
    
end



