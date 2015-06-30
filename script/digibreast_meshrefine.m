function mesh_refined=digibreast_meshrefine(mesh,centroid,radius,maxvol)
%
% mesh_refined=digibreast_meshrefine(mesh,centroid,radius,maxvol)
%
% Refine the input mesh within a spherical region centered at centroid.
%
% Authors: Bin Deng (bdeng1 <at> nmr.mgh.harvard.edu)
%          Qianqian Fang (fangq <at> nmr.mgh.harvard.edu)
%
% input:
%   mesh: a struct with at least two fields "node" and "elem"
%         mesh.node: existing tetrahedral mesh node list (N x 3 array, in length unit)
%         mesh.elem: existing tetrahedral element list (M x 4 array)
%         mesh.value: (optional) value list, one node can associate with K values (N x K array, K>=1)
%   centroid: [x,y,z] coordinates of the center of desired refine region (in length unit)
%   radius: radius of the sperical refined mesh region (in length unit)
%   maxvol: maximum element volume
%           For the DigiBreast phantom, the applied value is 0.1 (mm^-3) for
%           forward mesh and 1 (mm^-3) for reconstruction mesh.
%
% output:
%    mesh_refined: a struct with two fields containing the refined
%                  "node"  (in length unit) and "elem" lists
%
% dependency:
%    this function requires "meshrefine" and "meshcentroid" from iso2mesh toolbox.
%
% example:
%
%    % to generate the refined mesh used in [Deng2015] (see Table 1 for details)
%    mesh=ForwardMesh;
%    mesh_refined=digibreast_meshrefine(mesh,LesionCentroids.adipose,10,0.1);
%    plotmesh(mesh_refined.node,mesh_refined.elem,'z=15','facecolor','w');
%    reconmesh_refined=digibreast_meshrefine(ReconMesh,LesionCentroids.adipose,10,1);
%
%    % interpolation of glandularity maps in the refined mesh
%    mesh.value=[ForwardMesh.glandularity.truth ForwardMesh.glandularity.dualgaussian];
%    mesh_refined=digibreast_meshrefine(mesh,LesionCentroids.adipose,10,0.1);
%    figure; 
%    subplot(121);plotmesh([mesh_refined.node mesh_refined.value(:,1)],mesh_refined.elem,'z=15','linestyle','none');colorbar
%    subplot(122);plotmesh([mesh_refined.node mesh_refined.value(:,2)],mesh_refined.elem,'z=15','linestyle','none');colorbar
%
% reference:
%    [Deng2015] B. Deng, D. H. Brooks, D. A. Boas, M. Lundqvist, and Q. Fang, "Characterization of 
%               structural-prior guided optical tomography using realistic breast models derived 
%               from dual-energy x-ray mammography," Biomedical Optics Express 6(7): 2366-79 (2015)
%    [Fang2009] Q. Fang and D. Boas, "Tetrahedral mesh generation from volumetric binary and 
%               gray-scale images," Proceedings of IEEE International Symposium on Biomedical 
%               Imaging 2009, 1142-1145 (2009).
%
% -- this function is part of the OpenJData Project (http://openjd.sf.net/digibreast)
%

if(nargin<2)
    error('you must provide at least two inputs - mesh and centroid');
end

if(nargin<3)
    radius=10;
end

if(nargin<4)
    maxvol=0.1;
end

if(~isstruct(mesh) || ~isfield(mesh,'node') || ~isfield(mesh,'elem'))
    error('the mesh input must be a struct with node and elem fields')
end

% look for all tetrahedral elements whos centers are within the radius from the centroid
% set the desired maximum volume to a maxvol for those elements
c0=meshcentroid(mesh.node,mesh.elem(:,1:4));
dist=c0-repmat(centroid,[size(mesh.elem,1),1]);
dist=sqrt(sum(dist.*dist,2));
sz=zeros(size(mesh.elem,1),1); % sizing field
sz(dist<radius)=maxvol;

% refine the mesh
[node_refine,elem_refine]=meshrefine(mesh.node,mesh.elem,sz);
mesh_refined.node=node_refine;
mesh_refined.elem=elem_refine;

% plot meshes
%figure;
%subplot(2,1,1);plotmesh(mesh.node,mesh.elem,['z=' num2str(centroid(3))]);
%subplot(2,1,2);plotmesh(mesh_refined.node,mesh_refined.elem,['z=' num2str(centroid(3))]);

if(isfield(mesh,'value'))
    if(size(mesh.value,1)~=size(mesh.node,1))
        error('the value list must match the rows of the node list');
    end
    isoriginal=ismember(round(mesh_refined.node*1e10)*1e-10,round(mesh.node*1e10)*1e-10,'rows');
    newnodeidx=find(isoriginal==0); % find newly inserted nodes
    if(length(newnodeidx))
        [eid,weight]=tsearchn(mesh.node,mesh.elem,mesh_refined.node(newnodeidx,:));
    end
    mesh_refined.value=zeros(size(mesh_refined.node,1),size(mesh.value,2));
    mesh_refined.value(find(isoriginal==1),:)=mesh.value;
    for i=1:size(mesh.value,2)
        mesh_refined.value(newnodeidx,i)=sum(reshape(mesh.value(mesh.elem(eid,:),i),size(weight,1),size(weight,2)).*weight,2);
    end
end
