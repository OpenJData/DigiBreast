-------------------------------------------------------------------------------------------------
=   DigiBreast - A Complex Digital Breast Phantom with Clinically-Derived Tissue Compositions   =
-------------------------------------------------------------------------------------------------

<html><img src="http://mcx.sf.net/upload/Breast3D_logo.png" style="float:right;clear:left;" title="Digital Breast Phantom"/></html>

*Release date: work-in-progress
*Created by: Bin Deng <bdeng1 at nmr.mgh.harvard.edu>, Qianqian Fang <fangq at nmr.mgh.harvard.edu>
*License: The DigiBreast phantom main and source data are in the public domain; the MATLAB scripts \
are covered under the BSD license. Please refer to the LICENSE_BSD.txt for proper use \
and redistribution of the contents.

<toc>

== # Download ==

Coming soon…

== # Introduction ==



== # What's in the package ==

=== # Folder Structure ===
The DigiBreast package is comprised of the "data" folder and the "script" folder, 
together with related documentation. The package folder/file structure is explained
below.

<pre>
DigiBreast
├── AUTHORS.txt                      # Acknowledgement of contributions
├── README.txt                       # This file
├── data                             # DigiBreast data in MATLAB .mat format
│   └── DigiBreast.mat                 # DigiBreast main data
│   └── DigiBreast_source.mat          # DigiBreast source data
├── script                           # All related MATLAB scripts
│   ├── digibreast_meshrefine.m        # Creating the refined meshes at a given ROI
│   ├── digibreast_savejson.m          # Saving DigiBreast data in JSON and UBJSON
│   ├── digibreast_priors.m            # Creating tissue compositional maps
│   ├── digibreast_lesionprofile.m     # Creating a Gaussian-spherical tumor prior
│   └── digibreast_tablelookup.m       # Utility to lookup the optical properties
└── LICENSE_BSD.txt                  # License file
</pre>

=== # DigiBreast Data ===

DigiBreast.mat is a MAT-file that contains all essential components of the digital breast phantom used in the simulation study as presented in [http:?DigiBreast#Deng2015 Deng2015] paper, including variables ForwardMesh, ReconMesh, LesionCentroids, and OpticalProperties.

;'''ForwardMesh''': a 1x1 structure contains three fields, namely "node","elem",and "glandularity".

* ForwardMesh.node:
* ForwardMesh.elem:
* ForwardMesh.glandularity:
** ForwardMesh.glandularity.truth:
** ForwardMesh.glandularity.empirical:
** ForwardMesh.glandularity.dualgaussian:
** ForwardMesh.glandularity.thresholdp2:
** ForwardMesh.glandularity.threshold2:

;'''ReconMesh''': a 1x1 structure contains two fields, namely "node" and "elem".
* ReconMesh.node:
* ReconMesh.elem:

;'''LesionCentroids''':  a 1x1 structure with two fields, "adipose" and "fibroglandular", containing the [x,y,z] lesion centroids (in mm) of the two simulated lesion locations (as used in the [http:?DigiBreast#Deng2015 Deng2015] paper) within either adipose or fibroglandular tissue vicinity.

;'''OpticalProperties''': 


=== # DigiBreast Source Data ===

DigiBreast_source.mat is a MAT-file that contains all essential components of the digital breast phantom, including variables Mammogram, Glandularity_Truth, Thickness, and CoordinateMap.

;'''Mammogram''': Generate the Gaussian sphere lesion profile at defined centroid.

;'''Glandularity_Truth''': Refine the input mesh within a spherical region centered at centroid.

;'''Thickness''': Generate tissue compositional priors for the DigiBreast phantom.

;'''CoordinateMap''': Export DigiBreast mesh data into JSON and UBJSON files.


=== # Script ===
;'''digibreast_lesionprofile.m''': Generate the Gaussian sphere lesion profile at defined centroid.

;'''digibreast_meshrefine.m''': Refine the input mesh within a spherical region centered at centroid.

;'''digibreast_priors.m''': Generate tissue compositional priors for the DigiBreast phantom.

;'''digibreast_savejson.m''': Export DigiBreast mesh data into JSON and UBJSON files.

;'''digibreast_tablelookup.m''': Search optical properties from the OpticalProperties table by tissue and property names.

== # Tissue optical properties ==

With the provided fibroglandular tissue volume fraction map, users can freely build your own breast phantom by multiplying the optical properties of fibroglandular, adipose, and cancerous tissues to the volume fractions at each pixel/node. 

-------------------------------------------------------------------------------
!!__ Tissue type      !!__ HbO (μM) !!__ HbR (μM) !!!!μs’ (mm<sup>−1</sup>)  !!
!!                                                  at 690 nm  !! at 830 nm  !!
||Adipose             ||13.84       ||4.81        ||0.851      ||    0.713   ||
||Fibroglandular      ||18.96       ||6.47        ||0.925      ||    0.775   ||
||Malignant           ||20.60       ||6.72        ||0.957      ||    0.801   ||
-------------------------------------------------------------------------------

== # Footnote ==

The DigiBreast phantom main and source data is in the public domain. The MATLAB scripts under 
the "script" sub-folder have a BSD license. See LICENSE_BSD.txt 
for details.

Some of the scripts included in this package requires the installation of the "

If you use this DigiBreast phantom main or source data in your publication, please cite the phantom 
version number (currently Version_1) to avoid conflict to any further updates of this
mesh. We are also appreciated if you can cite the [http:?DigiBreast#Deng2015 Deng2015] paper below.

== # Reference ==

[#Deng2015][Deng2015] B. Deng, D. H. Brooks, D. A. Boas, M. Lundqvist, and Q. Fang, 
"Characterization of structural-prior guided optical tomography using realistic breast models derived from dual-energy x-ray mammography," 
Biomedical Optics Express 6(7): 2366-79 (2015). doi: [https://www.osapublishing.org/boe/abstract.cfm?uri=boe-6-7-2366 10.1364/BOE.6.002366]
