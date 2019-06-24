     __________________________________________________________________

DigiBreast

A Complex Digital Breast Phantom with 3D Tissue Compositions
     __________________________________________________________________

   DigiBreast

     * Version: 1.0
     * Release date: July 6, 2015
     * Created by: Bin Deng <bdeng1 at nmr.mgh.harvard.edu>, and Qianqian
       Fang <q.fang at neu.edu>
     * License: The DigiBreast phantom and source data are in the public
       domain; the MATLAB scripts are covered under the BSD license.
       Please refer to the LICENSE_BSD.txt for proper use and
       redistribution of the contents.
     * Acknowledgement: The mammogram and glandularity source images were
       measured using a Philips MicroDose SI mammography system,
       contributed by Philips Healthcare.

          1. [2]Download

          2. [3]Introduction

          3. [4]What's in the package

                3.1. [5]Folder structure

                3.2. [6]DigiBreast phantom data

                3.3. [7]DigiBreast source data

                3.4. [8]Scripts

          4. [9]Tissue optical properties

          5. [10]Footnote

          6. [11]Reference

1. Download

   Please download the latest release (Version 1) at our
   [12]registration/download page.

2. Introduction

   DigiBreast is a numerical breast phantom designed for 3D multi-physics
   simulations and validations of model-based image reconstruction
   algorithms for mammographically compressed breasts. The development of
   this phantom was described in [13]Deng2015 with the original intent of
   testing a structure-prior guided image reconstruction algorithm for
   combined x-ray mammography and diffuse optical tomography (DOT)
   imaging. This digital breast phantom contains generic information such
   as 3D breast shapes and internal anatomical structures. We believe such
   breast phantom can address the needs for simulation-based validations
   for a wide range of model-based imaging modalities. Potential utilities
   of this digital phantom include, but not limited to, simulations of
   breast deformation, 2D and 3D x-ray breast imaging, and tomographic
   imaging of a compressed breast using tomographic optical, microwave,
   thermal and electrical impedance methods.

   A unique aspect of this digital breast phantom is the inclusion of a
   realistic 3D glandularity map measured through a dual-energy x-ray
   mammography system, provided by Philips Healthcare. In comparison,
   conventional numerical breast phantoms represent various breast tissue
   constituents, i.e. the fibroglandular and adipose tissue, by
   piece-wise-constant regions (using a binary segmentation algorithm).
   Such representation removes the fine spatial details in the breast
   anatomical images, and results in loss of information. Statistical, or
   fuzzy segmentation methods avoid such information loss, and provide
   spatially-varying tissue volume fraction maps. In our previous works
   [14]Fang2010, we have reported a joint x-ray/DOT image reconstruction
   algorithm utilizing a spatially varying tissue compositional model to
   improve DOT image resolution. This method was further characterized in
   [15]Deng2015.

   The DigiBreast phantom has limitations. While the breast shape is in
   3D, the internal tissue compositional maps were derived from 2D x-ray
   measurements, thus, have an overall "cylindrical" shape along the
   sagittal direction. We, however, believe this approximation has
   negligible impact to most potential applications which deal with a
   mammographically compressed breast. This is because most of these
   methods utilizing a parallel-plate based measurement scheme and such
   scheme has an anisotropic spatial resolution - the horizontal/axial has
   significantly higher resolution than in the vertical/sagittal
   direction. Therefore, the focus in most of these imaging modalities are
   in the axial/horizontal view instead of the sagittal view. This
   limitation can be overcome in the future when 3D x-ray spectral imaging
   becomes available.

3. What's in the package

3.1. Folder structure

   The DigiBreast package contains a "data" folder and a "script" folder,
   along with related documentation. In the JSON and UBJSON formatted
   packages, the data folder is replaced by either "json" or "ubjson". In
   either folder, MATLAB variables that encode the DigiBreast Phantom are
   saved as separate JSON and UBJSON formatted data files. These files can
   be loaded into MATLAB using the free JSONLab toolbox
   ([16]http://iso2mesh.sf.net/jsonlab).

   The package file structure is explained below.

DigiBreast
├── AUTHORS.txt                   # Acknowledgement of contributions
├── README.txt                    # This file
├── data                          # DigiBreast data in MATLAB .mat format
│   └── DigiBreast.mat              # DigiBreast main data
│   └── DigiBreast_source.mat       # DigiBreast source data
├── json                          # DigiBreast data in JSON format (optional)
│   └── <<VariableName>>.json       # JSON files for each MATLAB variable
├── ubjson                        # DigiBreast data in UBJSON format (optional)
│   └── <<VariableName>>.ubj        # UBJSON files for each MATLAB variable
├── script                        # All related MATLAB scripts
│   ├── digibreast_meshrefine.m     # Creating the refined meshes at a given ROI
│   ├── digibreast_savejson.m       # Saving DigiBreast data in JSON and UBJSON
│   ├── digibreast_priors.m         # Creating tissue compositional maps
│   ├── digibreast_lesionprofile.m  # Creating a Gaussian-spherical tumor prior
│   └── digibreast_tablelookup.m    # Utility to lookup the optical properties
└── LICENSE_BSD.txt               # License file

3.2. DigiBreast phantom data

   DigiBreast.mat is a MATLAB mat-file containing all essential components
   of the 3D digital breast phantom used in the simulation study as
   presented in the [17]Deng2015 paper. It contains 4 data structures -
   ForwardMesh, ReconMesh, LesionCentroids, and OpticalProperties. This
   phantom is built on the source images included in
   DigiBreast_source.mat, and a 2 cm slab was added toward the chest wall.

   ForwardMesh
          a MATLAB structure containing three fields, namely "node",
          "elem",and "glandularity".

     * ForwardMesh.node: the node coordinate list of the forward mesh
     * ForwardMesh.elem: the tetrahedral element list of the forward mesh
     * ForwardMesh.glandularity: a struct containing the following fields:
          + ForwardMesh.glandularity.truth: the measured glandularity at
            each node
          + ForwardMesh.glandularity.empirical: the nodal glandularity
            list using an empirical segmentation algorithm
          + ForwardMesh.glandularity.dualgaussian: the nodal glandularity
            list using a dual-gaussian segmentation method
          + ForwardMesh.glandularity.thresholdp2: the nodal glandularity
            list using a threshold segmentation method with a 0.2%
            threshold
          + ForwardMesh.glandularity.threshold2: the nodal glandularity
            list using a threshold segmentation method with a 2% threshold

   ReconMesh
          a MATLAB structure containing two fields, namely "node" and
          "elem".

     * ReconMesh.node: the node coordinate list of the reconstruction mesh
     * ReconMesh.elem: the tetrahedral element list of the reconstruction
       mesh

   LesionCentroids
          a MATLAB structure with two fields, "adipose" and
          "fibroglandular", containing the [x,y,z] lesion centroids (in
          mm) of the two simulated lesion locations (as used in the
          [18]Deng2015 paper) within either adipose or fibroglandular
          tissue vicinity.

   OpticalProperties
          a 4x9 cell array with optical properties (HbO, HbR, HbT, SO2,
          scattering power and amplitude, reduced scattering coefficients
          at 690 nm and 830 nm) of adipose and fibroglandular tissues, as
          well as of malignant lesions. These optical properties are
          estimated based on mean values of reconstruction optical images
          for our previous clinical study published in [19]Fang2011.
          Optical properties are all properly labeled within the variable,
          and should be easy to interpret. A function included in this
          package, "digibreast_tablelookup.m", can also be used to look up
          for any particular optical properties of a certain tissue type.

3.3. DigiBreast source data

   DigiBreast_source.mat is a MATLAB mat-file that contains the anonymized
   and down-sampled (1 mm pixel resolution) 2D images of the original
   mammogram, glandularity and thickness maps. All original images are
   clinical measurements from a normal breast in the cranio-caudal view
   (CC view) using a Philips dual-energy mammographic system - MicroDose
   SI. The MAT-file includes variables Mammogram, Glandularity,
   ThicknessMap, and Registration. Users can choose to use our
   readily-built 3D DigiBreast phantom in DigiBreast.mat, or to create
   their own 3D realistic breast phantoms using different meshing settings
   based on the 2D source images in DigiBreast_source.mat.

   Mammogram
          A digital breast mammogram in the CC view (335x307 in 1x1 mm
          pixels). The mammogram has been masked to exclude skin region.

   Glandularity
          Fibroglandular tissue volume fraction map (335x307 in 1x1 mm
          pixels) derived directly from the MicroDose SI measurement. This
          is the "ground truth" glandularity referred in the [20]Deng2015
          paper. By stacking vertically and repeating this image, we can
          map the forward mesh nodes into this 3D glandularity profile
          using the Registration data structure below, and produce the
          subfield ForwardMesh.glandularity.truth in DigiBreast.mat.

   ThicknessMap
          the measured breast thickness map at each pixel location
          (335x307 in 1x1 mm pixels).

   Registration
          a 12 x 3 matrix representing the mapping between the mammogram
          image space and optical probe space for multi-modal imaging
          purposes. The odd-numbered rows are 6 key-points (x/y/z
          coordinates) in the mammogram-voxel-space, and the even-numbered
          rows are the corresponding key-points in the optical probe space
          (the same as the mesh coordinate space).

3.4. Scripts

   digibreast_lesionprofile.m
          Generate a Gaussian-sphere lesion profile at defined centroid.

Example

   To generate a Gaussian lesion profile that represents the volume
   fractions of a 5 mm FWHM lesion located within the adipose vicinity as
   shown in [21]Deng2015 on the forward mesh

 node=ForwardMesh.node;
 centroid=LesionCentroids.adipose;
 fwhmsize=5;
 lesionprofile=digibreast_lesionprofile(node,centroid,fwhmsize);
 figure;
 plotmesh([ForwardMesh.node lesionprofile],ForwardMesh.elem,'z=15',...
    'linestyle','none');
 colorbar;

   digibreast_meshrefine.m
          Refine the input mesh within a spherical region centered at
          centroid.

Example

   To generate the refined mesh used in [22]Deng2015 (see Table 1 in the
   paper for details)

 mesh=ForwardMesh;
 mesh_refined=digibreast_meshrefine(mesh,LesionCentroids.adipose,10,0.1);
 plotmesh(mesh_refined.node,mesh_refined.elem,'z=15','facecolor','w');
 reconmesh_refined=digibreast_meshrefine(ReconMesh,LesionCentroids.adipose,10,1);
 % interpolation of glandularity maps in the refined mesh
 mesh.value=[ForwardMesh.glandularity.truth ForwardMesh.glandularity.dualgaussian];
 mesh_refined=digibreast_meshrefine(mesh,LesionCentroids.adipose,10,0.1);
 figure;
 subplot(121);
 plotmesh([mesh_refined.node mesh_refined.value(:,1)],mesh_refined.elem,'z=15',...
    'linestyle','none');colorbar;
 subplot(122);
 plotmesh([mesh_refined.node mesh_refined.value(:,2)],mesh_refined.elem,'z=15',...
    'linestyle','none');colorbar;

   digibreast_priors.m
          Generate tissue compositional priors for the DigiBreast phantom.

Example

   To generate 2-compositional normal tissue priors using glandularity map
   derived from dual gaussian segmentation algorithm

 priors=digibreast_priors(ForwardMesh.glandularity.dualgaussian);
 figure;
 subplot(211);
 plotmesh([ForwardMesh.node priors.normal(:,1)],ForwardMesh.elem,'z=15',...
    'linestyle','none');
 title('Adipose tissue volume fractions');colorbar;
 subplot(212);
 plotmesh([ForwardMesh.node priors.normal(:,2)],ForwardMesh.elem,'z=15',...
    'linestyle','none');
 title('Fibroglandular tissue volume fractions');colorbar;

   To generate 3-compositional normal and lesion tissue priors using the
   same glandularity map derived from dual gaussian segmentation algorithm

 lesionprofile=digibreast_lesionprofile(ForwardMesh.node,LesionCentroids.adipose,5);
 priors=digibreast_priors(ForwardMesh.glandularity.dualgaussian,lesionprofile);
 figure;
 subplot(311);
 plotmesh([ForwardMesh.node priors.lesion(:,1)],ForwardMesh.elem,'z=15',...
    'linestyle','none');
 title('Adipose tissue volume fractions');colorbar;
 subplot(312);
 plotmesh([ForwardMesh.node priors.lesion(:,2)],ForwardMesh.elem,'z=15',...
    'linestyle','none');
 title('Fibroglandular tissue volume fractions');colorbar;
 subplot(313);
 plotmesh([ForwardMesh.node priors.lesion(:,3)],ForwardMesh.elem,'z=15',...
    'linestyle','none');
 title('Lesion tissue volume fractions');colorbar;

   digibreast_savejson.m
          Export DigiBreast mesh data into JSON and UBJSON files.

   digibreast_tablelookup.m
          Search optical properties from the OpticalProperties table by
          tissue and property names.

Example

 Sp_fib=digibreast_tablelookup(OpticalProperties,'fib','s_power');

4. Tissue optical properties

   With the provided fibroglandular tissue volume fraction map (variable
   Glandularity within DigiBreast_source.mat), users can freely build your
   own breast phantom by multiplying the optical properties of
   fibroglandular, adipose, and cancerous tissues to the volume fractions
   at each pixel/node.
     __________________________________________________________________

    Tissue type   HbO (μM) HbR (μM)    μs’ (mm^−1)
                                    at 690 nm at 830 nm
      Adipose      13.84     4.81     0.851     0.713
   Fibroglandular  18.96     6.47     0.925     0.775
     Malignant     20.60     6.72     0.957     0.801
     __________________________________________________________________

5. Footnote

   The DigiBreast phantom main and source data is in the public domain.
   The MATLAB scripts under the "script" sub-folder have a BSD license.
   See LICENSE_BSD.txt for details.

   Some of the scripts included in this package requires the installation
   of the "iso2mesh" and "JSONLab" toolboxes. To download these toolboxes:

     * iso2mesh: [23]http://iso2mesh.sourceforge.net/
     * JSONLab [24]http://iso2mesh.sourceforge.net/jsonlab

   If you use this DigiBreast phantom main or source data in your
   publication, please cite the phantom version number (currently Version
   1) to avoid conflict to any further updates of this mesh. If you use
   DigiBreast data in your research, the authors are appreciated if you
   can cite the [25]Deng2015 paper below in your related publications.

6. Reference

   [Deng2015] B. Deng, D.H. Brooks, D.A. Boas, M. Lundqvist, and Q. Fang,
   "Characterization of structural-prior guided optical tomography using
   realistic breast models derived from dual-energy x-ray mammography,"
   Biomedical Optics Express 6(7): 2366-79 (2015).

   [Fang2010] Q. Fang, R.H. Moore, D. B. Kopans, D.A. Boas DA,
   “Compositional-prior-guided image reconstruction algorithm for
   multi-modality imaging,” Biomedical Optics Express, 1(1), 223-235
   (2010)

   [Fang2011] Q. Fang, J. Selb, S.A. Carp, G. Boverman, E.L. Miller, D.H.
   Brooks, R.H. Moore, D.B. Kopans and D.A. Boas, "Combined optical and
   X-ray tomosynthesis breast imaging," Radiology 258(1): 89-97 (2011).

References

   1. http://mcx.sourceforge.net/cgi-bin/index.cgi?action=rss
   2. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#Download
   3. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#Introduction
   4. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#What_s_in_the_package
   5. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#Folder_structure
   6. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#DigiBreast_phantom_data
   7. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#DigiBreast_source_data
   8. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#Scripts
   9. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#Tissue_optical_properties
  10. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#Footnote
  11. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#Reference
  12. http://mcx.sourceforge.net/cgi-bin/index.cgi?register/digibreast
  13. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#Deng2015
  14. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#Fang2010
  15. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#Deng2015
  16. http://iso2mesh.sf.net/jsonlab
  17. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#Deng2015
  18. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#Deng2015
  19. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#Fang2011
  20. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#Deng2015
  21. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#Deng2015
  22. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#Deng2015
  23. http://iso2mesh.sourceforge.net/
  24. http://iso2mesh.sourceforge.net/jsonlab
  25. http://mcx.sourceforge.net/cgi-bin/index.cgi?DigiBreast#Deng2015
