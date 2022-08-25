#!/bin/bash -l
#SBATCH -t 24:00:00         # XXXX: Time Limit: generally sufficient; may need to increase it
#SBATCH -A aoml-osse        # XXXX: Account:   Use your project accounti
#SBATCH -q batch	   	    # XXXX: quality of service
#SBATCH --partition=service # XXXX: request specific partition for resource allocation
#SBATCH --ntasks=1	    	# XXXX: maximum of 1 task / node
#SBATCH --mail-type=fail    # XXXX: NONE, BEGIN, END, FAIL, REQUEUE, ALL 
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov
#SBATCH -J HWRFDA	    	# XXXX: Job Name: change
#SBATCH -o /scratch1/AOML/aoml-osse/Sarah.D.Ditchek/TAPE/hwrfda_o_03l.log # XXXX: Output
#SBATCH -e /scratch1/AOML/aoml-osse/Sarah.D.Ditchek/TAPE/hwrfda_e_03l.log # XXXX: Output

#################################################################################
########### This script retrieves HWRFDA files for a given experiment ###########
#################################################################################

##########################
# start of user settings #
##########################

rm -f hwrfda_e_03l.log

module load hpss

set -x

usr=Sarah.D.Ditchek       # your user directory
cycling="6" 		  	  # frequency of cycling
storm_ID=09l   	          # storm identifier - lowercase (e.g., 09l)
storm_ID2=09L   	      # storm identifier - uppercase (e.g., 09L) 
storm_nm=harvey	  	      # storm name - lowercase (e.g., hermine)
storm_nm2=nine      	  # storm number - lowercase (e.g., nine)
storm_nm3=invest  	      # storm invest - lowercase (e.g., invest)
storm_yr="2017"		      # storm year
subexp=$1                 # subexp name from model run passed in on command line

# Cycles Run | format must be yyyy-mm-dd hh
startdate3="2006-09-07 18"
enddate3="2006-09-11 18"

# FOR YOUR CRONTAB
# 0 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23 * * * /scratch1/AOML/aoml-osse/Sarah.D.Ditchek/TAPE/HWRFDA.ksh GSYESCR >/dev/null 2>&1

########################
# end of user settings #
########################

# Setup Directories
current=/scratch1/AOML/aoml-osse/${usr}/TAPE
indir1=/scratch1/AOML/aoml-osse/${usr}/scrub/${subexp}/
mkdir -p ${indir1}/HWRFDA/

# Grab files (invest)
if [ -z ${startdate3} ]
then
   echo No Date Specified For This Storm!
else
	while [ "$startdate3" != "$( date -d "$enddate3 + $cycling hours" '+%Y-%m-%d %H')" ]; do
	    usedate=$( date -d "$startdate3" '+%Y%m%d%H') # make format YYYYMMDDHH
	    startdate3=$( date -d "$startdate3 + $cycling hours" '+%Y-%m-%d %H') # increment by 6 hours
	    fgat1=${indir1}/${usedate}/${storm_ID2}/intercom/fgat.t${usedate}00/relocate.stage3/wrfghost_d02
	    fgat2=${indir1}/${usedate}/${storm_ID2}/intercom/fgat.t${usedate}00/relocate.stage3/wrfghost_d03
	    gsi1=${indir1}/${usedate}/${storm_ID2}/intercom/gsi_d02/gsi_out_storm1ghost_parent
	    gsi2=${indir1}/${usedate}/${storm_ID2}/intercom/gsi_d03/gsi_out_storm1ghost 
	    
		# if wrfghost_d02 file exists...
		if [ -f ${fgat1} ] 
	    then
			if [ ! -f ${indir1}/HWRFDA/${usedate}/${storm_ID2}/wrfghost_d02 ]
			then
				echo wrfghost_d02 for ${usedate} Exists!
				mkdir -p ${indir1}/HWRFDA/${usedate}/${storm_ID2}
				cd ${indir1}/HWRFDA/${usedate}/${storm_ID2}
				cp ${fgat1} .
			else
				echo wrfghost_d02 already exists! Skipping...
			fi
	    else
			echo wrfghost_d02 for ${usedate} Does Not Exist! Skipping...
	    fi

		# if wrfghost_d03 file exists...
	    if [ -f ${fgat2} ]
	    then
			if [ ! -f ${indir1}/HWRFDA/${usedate}/${storm_ID2}/wrfghost_d03 ]
			then
				echo wrfghost_d03 for ${usedate} Exists!
				mkdir -p ${indir1}/HWRFDA/${usedate}/${storm_ID2}
				cd ${indir1}/HWRFDA/${usedate}/${storm_ID2}
				cp ${fgat2} .
			else
				echo wrfghost_d03 already exists! Skipping...
			fi
	    else
			echo wrfghost_d03 for ${usedate} Does Not Exist! Skipping...
	    fi

		# if wrfghost_d02 file exists...
	    if [ -f ${gsi1} ] 
	    then
			if [ ! -f ${indir1}/HWRFDA/${usedate}/${storm_ID2}/gsi_out_storm1ghost_parent ]
			then
				echo gsi_out_storm1ghost_parent for ${usedate} Exists!
				mkdir -p ${indir1}/HWRFDA/${usedate}/${storm_ID2}
				cd ${indir1}/HWRFDA/${usedate}/${storm_ID2}
				cp ${gsi1} .
			else
				echo gsi_out_storm1ghost_parent already exists! Skipping...
			fi
		else
			echo gsi_out_storm1ghost_parent for ${usedate} Does Not Exist! Skipping...
		fi

		# if wrfghost_d02 file exists...
	    if [ -f ${gsi2} ] 
	    then
			if [ ! -f ${indir1}/HWRFDA/${usedate}/${storm_ID2}/gsi_out_storm1ghost ]
			then
				echo gsi_out_storm1ghost for ${usedate} Exists!
				mkdir -p ${indir1}/HWRFDA/${usedate}/${storm_ID2}
				cd ${indir1}/HWRFDA/${usedate}/${storm_ID2}
				cp ${gsi2} .
			else
				echo gsi_out_storm1ghost already exists! Skipping...
			fi
		else
			echo gsi_out_storm1ghost for ${usedate} Does Not Exist! Skipping...
		fi
	done
fi

exit 0
