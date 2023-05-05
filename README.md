# GROOT

## What Is GROOT?
GROOT stands for GRaphics for OS(S)Es and Other modeling applications on TCs. It is a visualization package for evaluating Observing System Experiments (OSEs), Observing System Simulation Experiments (OSSEs), new modeling systems, and model upgrades that use HWRF, Basin-Scale HWRF, HAFS, or the FV3GFS with a focus on tropical cyclone (TC) verification.

## What Capabilities Are Included?
GROOT has a hurricane component (GROOT-H) and a global component (GROOT-G). Both still focus on TC verification, but their usage depends on what model is being used.

### GROOT-H

Use this component if you are running HWRF, the basin-scale HWRF, or HAFS. It has four main features:

  1) **Error Statistics Capability:** graphics for individual storms, composites, and various subsets are generated
  2) **Assimilated Observations Capability:** graphics for individual storms and storm-relative composites are generated
  3) **GRB Capability:** plan-view and azimuthally-averaged graphics for individual storms for each experiment and difference graphics between experiments are generated (currently for HWRF, only)
  4) **Retrieval Scripts:** shell scripts are included that grab down all required files for error statistics, assimilated observations, and GRB graphics from HPSS

### GROOT-G

Use this component if you are running the FV3GFS. It has only two features at the moment - the Error Statistics Capability and the Assimilated Observations Capability. The GRB Capability and Retrieval Scripts will be added in the future as a new release:

  1) **Error Statistics Capability:** graphics for individual storms, composites, and various subsets are generated
  2) **Assimilated Observations Capability:** graphics for individual storms and storm-relative composites are generated
  
 ## Why Use GROOT?
  1) **It's Comprehensive:** results for both individual storms and composite studies are generated, retrieval scripts to grab GROOT-required files from HPSS are provided, and capabilities are continuously being added
  2) **Project Flexibility:** user input is confined to a brief namelist, any number of experiments can be compared (recommended maximum: 6), customization of colors and of baseline model available in the namelist, it works with model output from HWRF, the basin-scale HWRF, and FV3GFS, and users can switch between GROOT-H and GROOT-G with ease – the same process is used to run both components
  3) **Uniformity:** uniform, publication-ready graphics are generated, and graphics generated are those that are often needed in OS(S)E studies that evaluate TC performance

  ## How To Use GROOT
  
  First read the Users Guide to see if GROOT is for you! If it is, checkout the code and read the README within either the GROOT-H or GROOT-G directories, depending on which component you'll be using. After submitting GROOT, kick back and relax – a watched script never finishes! Thousands (tens of thousands if many storms) of graphics are being generated. 
  
  If something is not working, do a `cat slurm*` in your GROOT-H/ or GROOT-G/ directory. Failures typically occur due to user errors in the namelist or since the required files were not retrieved, so double check that your namelist is error free and that all of your files you expected to be included are in the GROOT-PR/ directory.
  
  ## How to Cite GROOT
  
  You are free to use this package to generate results for your research!
  
  If using this graphics package in **PUBLICATIONS**, please include the following in the acknowledgements section: 
  > The GRaphics for OS(s)Es and Other modeling applications on TCs (GROOT) verification package developed by Dr. Sarah Ditchek and funded by the Quantitative Observing System Assessment Program (QOSAP) and the FY18 Hurricane Supplemental (NOAA Award ID #NA19OAR0220188) was used to generate graphics for this publication."
  
  If using this graphics package in **PRESENTATIONS**, please indicate the following verbally or include the information somewhere on your slides:
  > Graphics were made using GROOT - a verification package developed by Dr. Sarah Ditchek and funded by QOSAP and the FY18 Hurricane Supplemental."
