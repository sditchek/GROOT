#!/bin/ksh -l
#SBATCH -t 24:00:00         					     # Time Limit: this is the max
#SBATCH -A aoml-hafs1       					     # Account: use your project account
#SBATCH -q batch            					     # Quality of Service: batch
#SBATCH --partition=service 					     # Partition: request specific partition for resource allocation
#SBATCH --ntasks=1          					     # Tasks: maximum of 1 task / node
#SBATCH --mail-type=end     					     # Email: NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov		 	     # Email: your email
#SBATCH -J TAPE             					     # Job Name
#SBATCH -o /scratch1/AOML/aoml-osse/Sarah.D.Ditchek/TAPE/archive.log # Output File: change
#SBATCH -e /scratch1/AOML/aoml-osse/Sarah.D.Ditchek/TAPE/error.log   # Output File: change

########################################################################################################
########### This script retrieves scrubbed data from tape or hpss for a given experiment ###############
########### NOTE: if you did not have iscyclecomplete.ksh in your crontab, just fill it  ###############
########### out and run it twice before running this retrieval script.                   ###############
########################################################################################################

set -x

##########################
# start of user settings #
##########################

# Storm and Directory Section
usr=Sarah.D.Ditchek                                                      # your user directory
cycling="6"                                                              # frequency of cycling in hours
storm_ID=09l                                                             # storm identifier - lowercase (e.g., 09l)
storm_ID2=09L                                                            # storm identifier - uppercase (e.g., 09L)
storm_nm=isaias                                                          # storm name - lowercase (e.g., harvey)
storm_yr="2020"                                                          # storm year
subexp=$1                                                                # subexp name from model run passed in on command line
tardir=/ESRL/BMC/qosap/5year/${usr}/HERA/HB20/${subexp}                  # retrieval directory on hpss or disk
tarcommand=htar                                                          # if hpss then tarcommand=htar | if disk then tarcommand=tar
current=/scratch1/AOML/aoml-hafs1/${usr}/TAPE/                           # directory of iscyclecomplete script
indir1=/scratch1/AOML/aoml-hafs1/${usr}/scrub/${subexp}/com              # your scrub directory path
indir2=/scratch/AOML/aoml-hafs1/${usr}/noscrub/hafstrak/${subexp}        # your noscrub directory path

# Dates where files identified by "name" | if none, keep as "" | format must be yyyy-mm-dd hh
startdate1="2020-07-24 18"
enddate1="2020-08-05 00"

# README: GRB DATA
# If you don't want to download the storm and synoptic grids, you need to comment out those lines below.
# These correspond to lines with tar at the beginning and .grb2 at the end.

########################
# end of user settings #
########################

# Setup Directories
mkdir -p ${indir1}
mkdir -p ${indir2}

# Grab files
if [ -z ${startdate1} ]
then
    echo No Name For This Storm!
else
        while [ "$startdate1" != "$( date -d "$enddate1 + $cycling hours" '+%Y-%m-%d %H')" ]; do
                usedate=$( date -d "$startdate1" '+%Y%m%d%H') # make format YYYYMMDDHH
                startdate1=$( date -d "$startdate1 + $cycling hours" '+%Y-%m-%d %H') # increment by 6 hours
                completion_file=${current}/${subexp}_completedcycles_old.txt
                storm_file=${indir1}/${usedate}/${storm_ID2}/${storm_nm}${storm_ID}.${usedate}.*.storm.analysis.cnvstat
                if [ $(grep -c $usedate $completion_file) -ne 0  ] # if completion file exists...
                then
                        echo Completion File ${usedate} Exists!
                        if [ !  -f $storm_file ] # if storm fhr0 does NOT exist...
                        then
                                tarfile=${tardir}/${storm_ID}.${usedate}.tar
                                if [ -e ${tarfile} ]
                                then
                                        echo Grabbing ${usedate} Files Now!
                                        mkdir -p ${indir1}/${usedate}/${storm_ID2}
                                        cd ${indir1}/${usedate}/${storm_ID2}
                                        #${tarcommand} -xvf ${tardir}/${storm_ID}.${usedate}.tar ${storm_ID}.${usedate}.*.storm.atm.f*.grb2
                                        #${tarcommand} -xvf ${tardir}/${storm_ID}.${usedate}.tar ${storm_ID}.${usedate}.*.parent.atm.f*.grb2
                                        ${tarcommand} -xvf ${tardir}/${storm_ID}.${usedate}.tar ${storm_ID}.${usedate}.*.storm.analysis.cnvstat
                                        ${tarcommand} -xvf ${tardir}/${storm_ID}.${usedate}.tar ${storm_ID}.${usedate}.*.storm.analysis.gsistat
                                        ${tarcommand} -xvf ${tardir}/${storm_ID}.${usedate}.tar ${storm_ID}.${usedate}.*.storm.analysis.radstat
                                        ${tarcommand} -xvf ${tardir}/${storm_ID}.${usedate}.tar ${storm_ID}.${usedate}.*.storm.analysis.gsisout
                                        ${tarcommand} -xvf ${tardir}/${storm_ID}.${usedate}.tar storm1.vitals.renumberlog
                                        ${tarcommand} -xvf ${storm_ID}.${usedate}.*.storm.analysis.cnvstat
                                        ${tarcommand} -xvf ${storm_ID}.${usedate}.*.storm.analysis.radstat
                                        gunzip *.gz
                                        rename ${storm_ID} ${storm_nm}${storm_ID} *${usedate}*
                                        rename diag ${storm_nm}${storm_ID} *${usedate}*
                                        grep ${usedate} *vitals* > ${storm_nm}${storm_ID}.${usedate}.storm_vit
                                        rm *vitals*
                                        cd ${indir2}
                                        ${tarcommand} -xvf ${tardir}/${storm_ID}.${usedate}.tar ${storm_ID}.${usedate}.*.trak.atcfunix
                                        rename ${storm_ID} ${storm_nm}${storm_ID} *${usedate}*
                                else
                                        echo ${tarcommand} file does not exist! Skipping...
                                fi
                else
                        echo You Already Grabbed Down ${usedate} Files! Skipping...
                fi
                else
                        echo Completion File ${usedate} Does Not Exist! Skipping...
                fi
        done
fi

exit 0
