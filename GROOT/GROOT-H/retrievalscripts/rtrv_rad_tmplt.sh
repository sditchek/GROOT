#!/bin/bash -l
#SBATCH -t 24:00:00         # XXXX: Time Limit: generally sufficient; may need to increase it
#SBATCH -A aoml-osse        # XXXX: Account:   Use your project accounti
#SBATCH -q batch	   	    # XXXX: quality of service
#SBATCH --partition=service # XXXX: request specific partition for resource allocation
#SBATCH --ntasks=1	    	# XXXX: maximum of 1 task / node
#SBATCH --mail-type=end	    # XXXX: NONE, BEGIN, END, FAIL, REQUEUE, ALL 
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov
#SBATCH -J TAPE		    	# XXXX: Job Name: change
#SBATCH -o /scratch1/BMC/qosap/Sarah.D.Ditchek/TAPE/archive_harvey09l.log # XXXX: Output
#SBATCH -e /scratch1/BMC/qosap/Sarah.D.Ditchek/TAPE/error_harvey09l.log   # XXXX: Output

#################################################################################################
########### This script retrieves scrubbed data from HPSS for a given experiment ################
# 1) 3-h track files | 2) synoptic .grb2 files | 3) storm .grb2 files  | 4) gsi data you choose #
#################################################################################################

##########################
# start of user settings #
##########################

rm -f error_harvey09l.log

module load hpss
module load idl

set -x

usr=Sarah.D.Ditchek       								 		  # your user directory
cycling="6" 		      								 		  # frequency of cycling in hours
storm_ID=09l   	          								 		  # storm identifier - lowercase (e.g., 09l)
storm_ID2=09L   	      								 		  # storm identifier - uppercase (e.g., 09L) 
storm_nm=harvey	  	      								 		  # storm name - lowercase (e.g., harvey)
storm_nm2=nine      	  								 		  # storm number - lowercase (e.g., nine)
storm_nm3=invest     	  								 		  # storm invest - lowercase (e.g., invest)
storm_yr="2017"		      								 		  # storm year
subexp=$1                 								 		  # subexp name from model run passed in on command line
hpssdir=/ESRL/BMC/qosap/5year/${usr}/HERA/HB20/${subexp} 		  # retrieval directory on hpss
current=/scratch1/BMC/qosap/${usr}/GROOT/GROOT-H/retrievalscripts # current directory
indir1=/scratch1/BMC/qosap/${usr}/scrub/${subexp}/com 	 		  # your scrub directory path
indir2=/scratch1/BMC/qosap/${usr}/noscrub/atcf/${subexp} 		  # your noscrub directory path
satid=iasi_g13		  											  # the satellite id you want data of
nc="618"		  												  # number of channels + 2 (e.g., iasi_g13 had 616 channels, so nc=616+2=618)
ch1="16"		  												  # first channel (e.g., the first channel for iasi_g13 is 16)

# Dates where files identified by "invest" | if none, keep as "" | format must be yyyy-mm-dd hh
startdate3="2017-08-16 06"
enddate3="2017-08-17 12"

# Dates where files identified by "number" | if none, keep as "" | format must be yyyy-mm-dd hh
startdate2="2017-08-17 18"
enddate2="2017-08-17 18"

# Dates where files identified by "name" | if none, keep as "" | format must be yyyy-mm-dd hh
startdate1="2017-08-18 00"
enddate1="2017-08-31 00"

# GSI DATA
# The current code is set up to read iasi data. 
# You need to know what satellite you're interested in generating plots for, the number of channels in that satellite, and the first channel number. 
# This script might take a bit of trial and error to get working for your case, but the basics are below.

# README: GRB DATA
# If you don't want to download the storm and synoptic grids, you need to comment out those lines below. 
# These correspond to lines 96, 97, 154, 155, 212, & 213.

########################
# end of user settings #
########################

# Setup Directories
mkdir -p ${indir2}

# Grab files (invest)
if [ -z ${startdate3} ]
then
    echo No Invest For This Storm!
else
	while [ "$startdate3" != "$( date -d "$enddate3 + $cycling hours" '+%Y-%m-%d %H')" ]; do
		usedate=$( date -d "$startdate3" '+%Y%m%d%H') # make format YYYYMMDDHH
		startdate3=$( date -d "$startdate3 + $cycling hours" '+%Y-%m-%d %H') # increment by 6 hours
		completion_file=${current}/${subexp}_completedcycles_old.txt
		storm_file=${indir1}/${usedate}/${storm_ID2}/${storm_nm}${storm_ID}.${usedate}.hwrfprs.storm.0p015.f000.grb2
		if [ $(grep -c $usedate $completion_file) -ne 0  ] # if completion file exists...
		then
			echo Completion File ${usedate} Exists!
			if [ ! -f $storm_file ] # if storm fhr0 does NOT exist...
			then
				tarfile=${hpssdir}/${storm_nm3}${storm_ID}.${usedate}.tar
				hsi "ls -l ${tarfile}.idx"
				tar_file_exists=$?
				if [ $tar_file_exists -eq 0 ]
				then
					echo Grabbing ${usedate} Files Now!
					mkdir -p ${indir1}/${usedate}/${storm_ID2}
					cd ${indir1}/${usedate}/${storm_ID2}
					htar -xvf ${hpssdir}/${storm_nm3}${storm_ID}.${usedate}.tar ${storm_nm3}${storm_ID}.${usedate}.hwrfprs.storm.0p015.f*.grb2
					htar -xvf ${hpssdir}/${storm_nm3}${storm_ID}.${usedate}.tar ${storm_nm3}${storm_ID}.${usedate}.hwrfprs.synoptic.0p125.f*.grb2
					htar -xvf ${hpssdir}/${storm_nm3}${storm_ID}.${usedate}.tar ${storm_nm3}${storm_ID}.${usedate}.gsi_d02.diag_${satid}_anl.gz
					htar -xvf ${hpssdir}/${storm_nm3}${storm_ID}.${usedate}.tar ${storm_nm3}${storm_ID}.${usedate}.gsi_d02.stdout.anl
					htar -xvf ${hpssdir}/${storm_nm3}${storm_ID}.${usedate}.tar ${storm_nm3}${storm_ID}.${usedate}.storm_vit
					rename ${storm_nm3} ${storm_nm} *
					gunzip ${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_${satid}_anl.gz
					cp ${current}/RAD/namelist.rad .
					sed -i "s/infile_anl/${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_iasi_g13_anl/g" namelist.rad
					sed -i "s/outfile.txt/${storm_nm}${storm_ID}.${usedate}.${satid}.txt/g" namelist.rad
					${current}/gsi_diag_rad.x
					( head -${nc} > ${storm_nm}${storm_ID}.${usedate}.channels.txt ; cat > ${storm_nm}${storm_ID}.${usedate}.details.txt ) < ${storm_nm}${storm_ID}.${usedate}.${satid}.txt
					grep "${satid}           " ${storm_nm}${storm_ID}.${usedate}.gsi_d02.stdout.anl > ${storm_nm}${storm_ID}.${usedate}.profiles.txt
					cut="`grep -n " ${ch1} ${satid} " ${storm_nm}${storm_ID}.${usedate}.profiles.txt | cut -d : -f 1 | tail -1`"
					cutline=`expr ${cut} - 1`
					sed -e "1,${cutline}d" ${storm_nm}${storm_ID}.${usedate}.profiles.txt > ${storm_nm}${storm_ID}.${usedate}.profile.txt
					mv ${storm_nm}${storm_ID}.${usedate}.profile.txt ${storm_nm}${storm_ID}.${usedate}.profiles.txt
					cp ${current}/RAD/*.pro .
					sed -i "s/path/${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_${satid}_anl/g" surfaceloc.pro
					idl -e "surfaceloc, ${usedate}"
					cd ${indir2}
					htar -xvf ${hpssdir}/${storm_nm3}${storm_ID}.${usedate}.tar ${storm_nm3}${storm_ID}.${usedate}.trak.hwrf.atcfunix
					rename ${storm_nm3}${storm_ID} ${storm_nm}${storm_ID} *
				else
					echo Tar file does not exist! Skipping...
				fi
			else
				echo You Already Grabbed Down ${usedate} Files! Skipping...
			fi
		else
			echo Completion File ${usedate} Does Not Exist! Skipping...
		fi
	done
fi

# Grab files (number)
if [ -z ${startdate2} ]
then
   echo No Number For This Storm!
else
	while [ "$startdate2" != "$( date -d "$enddate2 + $cycling hours" '+%Y-%m-%d %H')" ]; do
		usedate=$( date -d "$startdate2" '+%Y%m%d%H') # make format YYYYMMDDHH
		startdate2=$( date -d "$startdate2 + $cycling hours" '+%Y-%m-%d %H') # increment by 6 hours
		completion_file=${current}/${subexp}_completedcycles_old.txt
		storm_file=${indir1}/${usedate}/${storm_ID2}/${storm_nm}${storm_ID}.${usedate}.hwrfprs.storm.0p015.f000.grb2
		if [ $(grep -c $usedate $completion_file) -ne 0  ] # if completion file exists...
		then
			echo Completion File ${usedate} Exists!
			if [ ! -f $storm_file ] # if storm fhr0 does NOT exist...
			then
				tarfile=${hpssdir}/${storm_nm2}${storm_ID}.${usedate}.tar
				hsi "ls -l ${tarfile}.idx"
				tar_file_exists=$?
				if [ $tar_file_exists -eq 0 ]
				then
					echo Grabbing ${usedate} Files Now!
					mkdir -p ${indir1}/${usedate}/${storm_ID2}
					cd ${indir1}/${usedate}/${storm_ID2}
					htar -xvf ${hpssdir}/${storm_nm2}${storm_ID}.${usedate}.tar ${storm_nm2}${storm_ID}.${usedate}.hwrfprs.storm.0p015.f*.grb2
					htar -xvf ${hpssdir}/${storm_nm2}${storm_ID}.${usedate}.tar ${storm_nm2}${storm_ID}.${usedate}.hwrfprs.synoptic.0p125.f*.grb2
					htar -xvf ${hpssdir}/${storm_nm2}${storm_ID}.${usedate}.tar ${storm_nm2}${storm_ID}.${usedate}.gsi_d02.stdout.anl
					htar -xvf ${hpssdir}/${storm_nm2}${storm_ID}.${usedate}.tar ${storm_nm2}${storm_ID}.${usedate}.gsi_d02.diag_${satid}_anl.gz
					htar -xvf ${hpssdir}/${storm_nm2}${storm_ID}.${usedate}.tar ${storm_nm2}${storm_ID}.${usedate}.storm_vit
					rename ${storm_nm2} ${storm_nm} *
					gunzip ${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_${satid}_anl.gz
					cp ${current}/RAD/namelist.rad .
					sed -i "s/infile_anl/${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_iasi_g13_anl/g" namelist.rad
					sed -i "s/outfile.txt/${storm_nm}${storm_ID}.${usedate}.${satid}.txt/g" namelist.rad
					${current}/gsi_diag_rad.x
					( head -${nc} > ${storm_nm}${storm_ID}.${usedate}.channels.txt ; cat > ${storm_nm}${storm_ID}.${usedate}.details.txt ) < ${storm_nm}${storm_ID}.${usedate}.${satid}.txt
					grep "${satid}           " ${storm_nm}${storm_ID}.${usedate}.gsi_d02.stdout.anl > ${storm_nm}${storm_ID}.${usedate}.profiles.txt
					cut="`grep -n " ${ch1} ${satid} " ${storm_nm}${storm_ID}.${usedate}.profiles.txt | cut -d : -f 1 | tail -1`"
					cutline=`expr ${cut} - 1`
					sed -e "1,${cutline}d" ${storm_nm}${storm_ID}.${usedate}.profiles.txt > ${storm_nm}${storm_ID}.${usedate}.profile.txt
					mv ${storm_nm}${storm_ID}.${usedate}.profile.txt ${storm_nm}${storm_ID}.${usedate}.profiles.txt
					cp ${current}/RAD/*.pro .
					sed -i "s/path/${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_${satid}_anl/g" surfaceloc.pro
					idl -e "surfaceloc, ${usedate}"
					cd ${indir2}
					htar -xvf ${hpssdir}/${storm_nm2}${storm_ID}.${usedate}.tar ${storm_nm2}${storm_ID}.${usedate}.trak.hwrf.atcfunix
					rename ${storm_nm2}${storm_ID} ${storm_nm}${storm_ID} *
				else
					echo Tar file does not exist! Skipping...
				fi
			else
				echo You Already Grabbed Down ${usedate} Files! Skipping...
			fi
		else
			echo Completion File ${usedate} Does Not Exist! Skipping...
		fi
	done
fi

# Grab files (name)
if [ -z ${startdate1} ]
then
     echo No Name For This Storm!
else
	while [ "$startdate1" != "$( date -d "$enddate1 + $cycling hours" '+%Y-%m-%d %H')" ]; do
	   usedate=$( date -d "$startdate1" '+%Y%m%d%H') # make format YYYYMMDDHH
	   startdate1=$( date -d "$startdate1 + $cycling hours" '+%Y-%m-%d %H') # increment by 6 hours
	   completion_file=${current}/${subexp}_completedcycles_old.txt
	   storm_file=${indir1}/${usedate}/${storm_ID2}/${storm_nm}${storm_ID}.${usedate}.hwrfprs.storm.0p015.f000.grb2
	   if [ $(grep -c $usedate $completion_file) -ne 0  ] # if completion file exists...
	   then
			echo Completion File ${usedate} Exists!	
			if [ !  -f $storm_file ] # if storm fhr0 does NOT exist...
			then
				tarfile=${hpssdir}/${storm_nm}${storm_ID}.${usedate}.tar
				hsi "ls -l ${tarfile}.idx"
				tar_file_exists=$?
				if [ $tar_file_exists -eq 0 ]
				then
					echo Grabbing ${usedate} Files Now!
					mkdir -p ${indir1}/${usedate}/${storm_ID2}
					cd ${indir1}/${usedate}/${storm_ID2}
					htar -xvf ${hpssdir}/${storm_nm}${storm_ID}.${usedate}.tar ${storm_nm}${storm_ID}.${usedate}.hwrfprs.storm.0p015.f*.grb2
					htar -xvf ${hpssdir}/${storm_nm}${storm_ID}.${usedate}.tar ${storm_nm}${storm_ID}.${usedate}.hwrfprs.synoptic.0p125.f*.grb2
					htar -xvf ${hpssdir}/${storm_nm}${storm_ID}.${usedate}.tar ${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_${satid}_anl.gz
					htar -xvf ${hpssdir}/${storm_nm}${storm_ID}.${usedate}.tar ${storm_nm}${storm_ID}.${usedate}.gsi_d02.stdout.anl
					htar -xvf ${hpssdir}/${storm_nm}${storm_ID}.${usedate}.tar ${storm_nm}${storm_ID}.${usedate}.storm_vit
					gunzip ${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_${satid}_anl.gz
					cp ${current}/RAD/namelist.rad .
					sed -i "s/infile_anl/${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_${satid}_anl/g" namelist.rad
					sed -i "s/outfile.txt/${storm_nm}${storm_ID}.${usedate}.${satid}.txt/g" namelist.rad
					${current}/gsi_diag_rad.x
					( head -${nc} > ${storm_nm}${storm_ID}.${usedate}.channels.txt ; cat > ${storm_nm}${storm_ID}.${usedate}.details.txt ) < ${storm_nm}${storm_ID}.${usedate}.${satid}.txt
					grep "${satid}           " ${storm_nm}${storm_ID}.${usedate}.gsi_d02.stdout.anl > ${storm_nm}${storm_ID}.${usedate}.profiles.txt
					cut="`grep -n " ${ch1} ${satid} " ${storm_nm}${storm_ID}.${usedate}.profiles.txt | cut -d : -f 1 | tail -1`"
					cutline=`expr ${cut} - 1`
					sed -e "1,${cutline}d" ${storm_nm}${storm_ID}.${usedate}.profiles.txt > ${storm_nm}${storm_ID}.${usedate}.profile.txt
					mv ${storm_nm}${storm_ID}.${usedate}.profile.txt ${storm_nm}${storm_ID}.${usedate}.profiles.txt
					rm gsidiag*
					cp ${current}/RAD/*.pro .			
					sed -i "s/path/${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_${satid}_anl/g" surfaceloc.pro
					idl -e "surfaceloc, ${usedate}"
					cd ${indir2}
					htar -xvf ${hpssdir}/${storm_nm}${storm_ID}.${usedate}.tar ${storm_nm}${storm_ID}.${usedate}.trak.hwrf.atcfunix
				else
					echo Tar file does not exist! Skipping...
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
