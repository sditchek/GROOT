# GROOT

## What Is GROOT?
GROOT stands for GRaphics for OSEs and OSSEs on TCs. It is a visualization package for Observing System Experiments (OSEs) and Observing System Simulation Experiments (OSSEs) that use HWRF, the Basin-Scale HWRF, or the FV3GFS with a focus on tropical cyclone (TC) verification.

## What Capabilities Are Included?
GROOT has a hurricane component (GROOT-H) and a global component (GROOT-G). Both still focus on TC verification, but their usage depends on what model is being used.

### GROOT-H

Use this component if you are running HWRF or the basin-scale HWRF. It has four main features:

  1) **Error Statistics Capability:** graphics for individual storms, composites, and various subsets are generated
  2) **Assimilated Observations Capability:** graphics for individual storms and storm-relative composites are generated
  3) **GRB Capability:** plan-view and azimuthally-averaged graphics for individual storms for each experiment and difference graphics between experiments are generated
  4) **Retrieval Scripts:** shell scripts are included that grab down all required files for error statistics, assimilated observations, and GRB graphics from HPSS

### GROOT-G

Use this component if you are running the FV3GFS. It has only one feature at the moment - the Error Statistics Capability. The Assimilated Observations Capability, GRB Capability, and Retrieval Scripts will be added in the future as a new release:

  - **Error Statistics Capability:** graphics for individual storms, composites, and various subsets are generated   
  
 ## Why Use GROOT?
  1) **It's Comprehensive:** results for both individual storms and composite studies are generated, retrieval scripts to grab GROOT-required files from HPSS are provided, and capabilities are continuously being added
  2) **Project Flexibility:** user input is confined to a brief namelist, any number of experiments can be compared (recommended maximum: 6), customization of colors and of baseline model available in the namelist, it works with model output from HWRF, the basin-scale HWRF, and FV3GFS, and users can switch between GROOT-H and GROOT-G with ease – the same process is used to run both components
  3) **Uniformity:** uniform, publication-ready graphics are generated, and graphics generated are those that are often needed in OS(S)E studies that evaluate TC performance

  ## How To Use GROOT
  
  Checkout the code and read the README within either the GROOT-H or GROOT-G directories, depending on which component you'll be using.
  
  ## How to Cite GROOT
  
  You are free to use this package to generate results for your research. If doing so, and if you include the graphics in presentations or papers, please cite this package as:
  - Ditchek, S.D., 2021: GRaphics for OSEs and OSSEs on TCs (GROOT; Version v1.0.1). Zenodo. http://doi.org/10.5281/zenodo.4527625

  [![DOI](https://zenodo.org/badge/336020440.svg)](https://zenodo.org/badge/latestdoi/336020440)
