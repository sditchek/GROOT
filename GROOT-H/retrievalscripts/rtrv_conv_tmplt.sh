#!/bin/ksh -l
#SBATCH -t 24:00:00         # XXXX: Time Limit: generally sufficient; may need to increase it
#SBATCH -A aoml-osse        # XXXX: Account:   Use your project accounti
#SBATCH -q batch	   	    # XXXX: quality of service
#SBATCH --partition=service # XXXX: request specific partition for resource allocation
#SBATCH --ntasks=1	    	# XXXX: maximum of 1 task / node
#SBATCH --mail-type=end	    # XXXX: NONE, BEGIN, END, FAIL, REQUEUE, ALL 
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov
#SBATCH -J TAPE		    	# XXXX: Job Name: change
#SBATCH -o /scratch1/AOML/aoml-osse/Sarah.D.Ditchek/TAPE/archive.log # XXXX: Output
#SBATCH -e /scratch1/AOML/aoml-osse/Sarah.D.Ditchek/TAPE/error.log   # XXXX: Output

#################################################################################################
########### This script retrieves scrubbed data from HPSS for a given experiment ################
# 1) 3-h track files | 2) synoptic .grb2 files | 3) storm .grb2 files  | 4) gsi data you choose #
#################################################################################################
set -x
module load hpss

##########################
# start of user settings #
##########################

# Storm and Directory Section
usr=Sarah.D.Ditchek      						 # your user directory
cycling="6" 		     						 # frequency of cycling in hours
storm_ID=13l   	          						 # storm identifier - lowercase (e.g., 09l)
storm_ID2=13L   	      						 # storm identifier - uppercase (e.g., 09L) 
storm_nm=laura	  	      						 # storm name - lowercase (e.g., harvey)
storm_nm2=thirteen  	  						 # storm number - lowercase (e.g., nine)
storm_nm3=invest     	  						 # storm invest - lowercase (e.g., invest)
storm_yr="2020"		      						 # storm year
subexp=$1                 						 # subexp name from model run passed in on command line
hpssdir=/ESRL/BMC/qosap/5year/Benjamin.Johnston/HERA/HB20/${subexp} 		 # retrieval directory on hpss
current=/scratch1/AOML/aoml-osse/${usr}/GROOT/GROOT-H/retrievalscripts   # current directory
indir1=/scratch1/AOML/aoml-osse/${usr}/scrub/${subexp}/com 	 	 # your scrub directory path
indir2=/scratch1/AOML/aoml-osse/${usr}/noscrub/atcf/${subexp} 		 # your noscrub directory path

# Conventional Observation Section
numvars=6                                                                # number of conventional observations being processed
set -A convid 750 751 752 753 754 755                                    # conventional observation type (used by gsi_diag_conv.x to extract your data)
set -A convar gps gps gps gps gps gps                                    # conventional variable type (used by gsi_diag_conv.x to extract your data)
set -A newsubid 1 2 3 4 5 6						 # reassigned subtype ids for each conventional observation type | in editverif.m match identconvtype to this row
										# if numvars=1, and you DO want to keep the subtypes, newsubid="" 
										# if numvars=1, and you DO NOT want to keep the subtypes, newsubid=number
										# if numvars>1, and you DO want to keep the subtypes, newsubid=""
										# if numvars>1, and you DO NOT want to keep the subtypes, then number these sequentially 

# Dates where files identified by "invest" | if none, keep as "" | format must be yyyy-mm-dd hh
startdate3=""
enddate3=""

# Dates where files identified by "number" | if none, keep as "" | format must be yyyy-mm-dd hh
startdate2=""
enddate2=""

# Dates where files identified by "name" | if none, keep as "" | format must be yyyy-mm-dd hh
startdate1="2020-08-26 06"
enddate1="2020-08-26 06"

# README: GSI DATA
# You might need to change the gsi_diag_conv.f90 file and recompile for your particular case - see the README in this folder for more details

# README: GRB DATA
# If you don't want to download the storm and synoptic grids, you need to comment out those lines below. 
# These correspond to lines with htar at the beginning and .grb2 at the end.

########################
# end of user settings #
########################

# Setup Directories
mkdir -p ${indir1}
mkdir -p ${indir2}

# Grab files (invest)
if [ -z ${startdate3} ]
then
    echo No Invest For This Storm!
else
	while [ "$startdate3" != "$( date -d "$enddate3 + $cycling hours" '+%Y-%m-%d %H')" ]; do
		usedate=$( date -d "$startdate3" '+%Y%m%d%H') 					# make format YYYYMMDDHH
		startdate3=$( date -d "$startdate3 + $cycling hours" '+%Y-%m-%d %H') 		# increment by 6 hours
		completion_file=${current}/${subexp}_completedcycles_old.txt		    	# did the cycle complete?
		storm_file=${indir1}/${usedate}/${storm_ID2}/${storm_nm}${storm_ID}.${usedate}.hwrfprs.storm.0p015.f000.grb2
		if [ $(grep -c $usedate $completion_file) -ne 0  ] # if completion file exists...
		then
			echo Completion File ${usedate} Exists!
			if [ ! -f $storm_file ] 					  # if storm fhr0 does NOT exist...
			then
				tarfile=${hpssdir}/${storm_nm3}${storm_ID}.${usedate}.tar
				hsi "ls -l ${tarfile}.idx"
				tar_file_exists=$?
				if [ $tar_file_exists -eq 0 ]
				then
					echo Grabbing ${usedate} Files Now!
					mkdir -p ${indir1}/${usedate}/${storm_ID2}
					cd ${indir1}/${usedate}/${storm_ID2}
					#htar -xvf ${hpssdir}/${storm_nm3}${storm_ID}.${usedate}.tar ${storm_nm3}${storm_ID}.${usedate}.hwrfprs.storm.0p015.f*.grb2
					#htar -xvf ${hpssdir}/${storm_nm3}${storm_ID}.${usedate}.tar ${storm_nm3}${storm_ID}.${usedate}.hwrfprs.synoptic.0p125.f*.grb2
					htar -xvf ${hpssdir}/${storm_nm3}${storm_ID}.${usedate}.tar ${storm_nm3}${storm_ID}.${usedate}.gsi_d02.diag_conv_anl.gz
                  			htar -xvf ${hpssdir}/${storm_nm3}${storm_ID}.${usedate}.tar ${storm_nm3}${storm_ID}.${usedate}.gsi_d02.diag_conv_ges.gz
					htar -xvf ${hpssdir}/${storm_nm3}${storm_ID}.${usedate}.tar ${storm_nm3}${storm_ID}.${usedate}.gsi_d02.stdout.anl
					htar -xvf ${hpssdir}/${storm_nm3}${storm_ID}.${usedate}.tar ${storm_nm3}${storm_ID}.${usedate}.storm_vit
					rename ${storm_nm3} ${storm_nm} *
                    			gunzip ${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_conv_anl.gz
					gunzip ${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_conv_ges.gz					
					${current}/gsi_diag_conv.x ${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_conv_anl ${indir1}/${usedate}/${storm_ID2}/ ${usedate} anl > log.an
					${current}/gsi_diag_conv.x ${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_conv_ges ${indir1}/${usedate}/${storm_ID2}/ ${usedate} ges > log.ge
					rm log.an
					rm log.ge
                                        for ((j=0;j<${numvars};++j))
                                        do
                                                if grep -q "${convar[$j]}      ${convid[$j]}" gsidiag_anl.${usedate}.${convar[$j]}_conv
                                                then
                                                        grep "${convar[$j]}      ${convid[$j]}" gsidiag_anl.${usedate}.${convar[$j]}_conv > tmp.txt
                                                        uniq tmp.txt > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.anl0.latlon.txt1
                                                        rm tmp.txt
                                                        if [ -z "${newsubid}" ];then;cat ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.anl0.latlon.txt1 > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.anl0.latlon.txt;else;awk '{print substr($0,1,28) v substr($0,33)}' v="  ${newsubid[$j]}" ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.anl0.latlon.txt1 > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.anl0.latlon.txt;fi
                                                else
                                                        echo none > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.anl0.latlon.txt
                                                fi
                                                if grep -q "${convar[$j]}      ${convid[$j]}" gsidiag_ges.${usedate}.${convar[$j]}_conv
                                                then
                                                        grep "${convar[$j]}      ${convid[$j]}" gsidiag_ges.${usedate}.${convar[$j]}_conv > tmp.txt
                                                        uniq tmp.txt > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.ges0.latlon.txt1
                                                        rm tmp.txt
                                                        if [ -z "${newsubid}" ];then;cat ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.ges0.latlon.txt1 > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.ges0.latlon.txt;else;awk '{print substr($0,1,28) v substr($0,33)}' v="  ${newsubid[$j]}" ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.ges0.latlon.txt1 > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.ges0.latlon.txt;fi
                                                else
                                                        echo none > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.ges0.latlon.txt
                                                fi
                                        done
					rm gsidiag*
                                        cat ${storm_nm}${storm_ID}.${usedate}.*.indiv.anl0.latlon.txt > ${storm_nm}${storm_ID}.${usedate}.anl0.latlon.txt0
                                        rm ${storm_nm}${storm_ID}.${usedate}.*.indiv.anl0.latlon.txt*
                                        uniq ${storm_nm}${storm_ID}.${usedate}.anl0.latlon.txt0 > ${storm_nm}${storm_ID}.${usedate}.anl0.latlon.txt
                                        rm ${storm_nm}${storm_ID}.${usedate}.anl0.latlon.txt0
                                        sed -i "s/Infinity/0/g" ${storm_nm}${storm_ID}.${usedate}.anl0.latlon.txt
                                        sed -i "s/none//g" ${storm_nm}${storm_ID}.${usedate}.anl0.latlon.txt
                                        cat ${storm_nm}${storm_ID}.${usedate}.*.indiv.ges0.latlon.txt > ${storm_nm}${storm_ID}.${usedate}.ges0.latlon.txt0
                                        rm ${storm_nm}${storm_ID}.${usedate}.*.indiv.ges0.latlon.txt*
                                        uniq ${storm_nm}${storm_ID}.${usedate}.ges0.latlon.txt0 > ${storm_nm}${storm_ID}.${usedate}.ges0.latlon.txt
                                        rm ${storm_nm}${storm_ID}.${usedate}.ges0.latlon.txt0
                                        sed -i "s/Infinity/0/g" ${storm_nm}${storm_ID}.${usedate}.ges0.latlon.txt
                                        sed -i "s/none//g" ${storm_nm}${storm_ID}.${usedate}.ges0.latlon.txt
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
					#htar -xvf ${hpssdir}/${storm_nm2}${storm_ID}.${usedate}.tar ${storm_nm2}${storm_ID}.${usedate}.hwrfprs.storm.0p015.f*.grb2
					#htar -xvf ${hpssdir}/${storm_nm2}${storm_ID}.${usedate}.tar ${storm_nm2}${storm_ID}.${usedate}.hwrfprs.synoptic.0p125.f*.grb2
					htar -xvf ${hpssdir}/${storm_nm2}${storm_ID}.${usedate}.tar ${storm_nm2}${storm_ID}.${usedate}.gsi_d02.stdout.anl
					htar -xvf ${hpssdir}/${storm_nm2}${storm_ID}.${usedate}.tar ${storm_nm2}${storm_ID}.${usedate}.gsi_d02.diag_conv_anl.gz
                                        htar -xvf ${hpssdir}/${storm_nm2}${storm_ID}.${usedate}.tar ${storm_nm2}${storm_ID}.${usedate}.gsi_d02.diag_conv_ges.gz
					htar -xvf ${hpssdir}/${storm_nm2}${storm_ID}.${usedate}.tar ${storm_nm2}${storm_ID}.${usedate}.storm_vit
					rename ${storm_nm2} ${storm_nm} *
					gunzip ${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_conv_anl.gz
					gunzip ${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_conv_ges.gz					
					${current}/gsi_diag_conv.x ${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_conv_anl ${indir1}/${usedate}/${storm_ID2}/ ${usedate} anl > log.an
					${current}/gsi_diag_conv.x ${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_conv_ges ${indir1}/${usedate}/${storm_ID2}/ ${usedate} ges > log.ge
					rm log.an
					rm log.ge
                                        for ((j=0;j<${numvars};++j))
                                        do
                                                if grep -q "${convar[$j]}      ${convid[$j]}" gsidiag_anl.${usedate}.${convar[$j]}_conv
                                                then
                                                        grep "${convar[$j]}      ${convid[$j]}" gsidiag_anl.${usedate}.${convar[$j]}_conv > tmp.txt
                                                        uniq tmp.txt > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.anl0.latlon.txt1
                                                        rm tmp.txt
                                                        if [ -z "${newsubid}" ];then;cat ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.anl0.latlon.txt1 > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.anl0.latlon.txt;else;awk '{print substr($0,1,28) v substr($0,33)}' v="  ${newsubid[$j]}" ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.anl0.latlon.txt1 > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.anl0.latlon.txt;fi
                                                else
                                                        echo none > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.anl0.latlon.txt
                                                fi
                                                if grep -q "${convar[$j]}      ${convid[$j]}" gsidiag_ges.${usedate}.${convar[$j]}_conv
                                                then
                                                        grep "${convar[$j]}      ${convid[$j]}" gsidiag_ges.${usedate}.${convar[$j]}_conv > tmp.txt
                                                        uniq tmp.txt > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.ges0.latlon.txt1
                                                        rm tmp.txt
                                                        if [ -z "${newsubid}" ];then;cat ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.ges0.latlon.txt1 > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.ges0.latlon.txt;else;awk '{print substr($0,1,28) v substr($0,33)}' v="  ${newsubid[$j]}" ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.ges0.latlon.txt1 > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.ges0.latlon.txt;fi
                                                else
                                                        echo none > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.ges0.latlon.txt
                                                fi
                                        done
					rm gsidiag*
                                        cat ${storm_nm}${storm_ID}.${usedate}.*.indiv.anl0.latlon.txt > ${storm_nm}${storm_ID}.${usedate}.anl0.latlon.txt0
                                        rm ${storm_nm}${storm_ID}.${usedate}.*.indiv.anl0.latlon.txt*
                                        uniq ${storm_nm}${storm_ID}.${usedate}.anl0.latlon.txt0 > ${storm_nm}${storm_ID}.${usedate}.anl0.latlon.txt
                                        rm ${storm_nm}${storm_ID}.${usedate}.anl0.latlon.txt0
                                        sed -i "s/Infinity/0/g" ${storm_nm}${storm_ID}.${usedate}.anl0.latlon.txt
                                        sed -i "s/none//g" ${storm_nm}${storm_ID}.${usedate}.anl0.latlon.txt
                                        cat ${storm_nm}${storm_ID}.${usedate}.*.indiv.ges0.latlon.txt > ${storm_nm}${storm_ID}.${usedate}.ges0.latlon.txt0
                                        rm ${storm_nm}${storm_ID}.${usedate}.*.indiv.ges0.latlon.txt*
                                        uniq ${storm_nm}${storm_ID}.${usedate}.ges0.latlon.txt0 > ${storm_nm}${storm_ID}.${usedate}.ges0.latlon.txt
                                        rm ${storm_nm}${storm_ID}.${usedate}.ges0.latlon.txt0
                                        sed -i "s/Infinity/0/g" ${storm_nm}${storm_ID}.${usedate}.ges0.latlon.txt
                                        sed -i "s/none//g" ${storm_nm}${storm_ID}.${usedate}.ges0.latlon.txt
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
					#htar -xvf ${hpssdir}/${storm_nm}${storm_ID}.${usedate}.tar ${storm_nm}${storm_ID}.${usedate}.hwrfprs.storm.0p015.f*.grb2
					#htar -xvf ${hpssdir}/${storm_nm}${storm_ID}.${usedate}.tar ${storm_nm}${storm_ID}.${usedate}.hwrfprs.synoptic.0p125.f*.grb2
					htar -xvf ${hpssdir}/${storm_nm}${storm_ID}.${usedate}.tar ${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_conv_anl.gz
                                        htar -xvf ${hpssdir}/${storm_nm}${storm_ID}.${usedate}.tar ${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_conv_ges.gz
					htar -xvf ${hpssdir}/${storm_nm}${storm_ID}.${usedate}.tar ${storm_nm}${storm_ID}.${usedate}.gsi_d02.stdout.anl
					htar -xvf ${hpssdir}/${storm_nm}${storm_ID}.${usedate}.tar ${storm_nm}${storm_ID}.${usedate}.storm_vit
					gunzip ${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_conv_anl.gz
					gunzip ${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_conv_ges.gz					
					${current}/gsi_diag_conv.x ${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_conv_anl ${indir1}/${usedate}/${storm_ID2}/ ${usedate} anl > log.an
					${current}/gsi_diag_conv.x ${storm_nm}${storm_ID}.${usedate}.gsi_d02.diag_conv_ges ${indir1}/${usedate}/${storm_ID2}/ ${usedate} ges > log.ge
					rm log.an
					rm log.ge
					for ((j=0;j<${numvars};++j))
				    	do
						if grep -q "${convar[$j]}      ${convid[$j]}" gsidiag_anl.${usedate}.${convar[$j]}_conv
						then
							grep "${convar[$j]}      ${convid[$j]}" gsidiag_anl.${usedate}.${convar[$j]}_conv > tmp.txt
				                        uniq tmp.txt > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.anl0.latlon.txt1
				                        rm tmp.txt
							if [ -z "${newsubid}" ];then;cat ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.anl0.latlon.txt1 > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.anl0.latlon.txt;else;awk '{print substr($0,1,28) v substr($0,33)}' v="  ${newsubid[$j]}" ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.anl0.latlon.txt1 > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.anl0.latlon.txt;fi
						else
							echo none > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.anl0.latlon.txt
						fi
						if grep -q "${convar[$j]}      ${convid[$j]}" gsidiag_ges.${usedate}.${convar[$j]}_conv
						then
							grep "${convar[$j]}      ${convid[$j]}" gsidiag_ges.${usedate}.${convar[$j]}_conv > tmp.txt
				                        uniq tmp.txt > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.ges0.latlon.txt1
				                        rm tmp.txt
						        if [ -z "${newsubid}" ];then;cat ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.ges0.latlon.txt1 > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.ges0.latlon.txt;else;awk '{print substr($0,1,28) v substr($0,33)}' v="  ${newsubid[$j]}" ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.ges0.latlon.txt1 > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.ges0.latlon.txt;fi
						else
							echo none > ${storm_nm}${storm_ID}.${usedate}.${convar[$j]}.${convid[$j]}.indiv.ges0.latlon.txt
						fi
					done
					rm gsidiag*
					cat ${storm_nm}${storm_ID}.${usedate}.*.indiv.anl0.latlon.txt > ${storm_nm}${storm_ID}.${usedate}.anl0.latlon.txt0
			                rm ${storm_nm}${storm_ID}.${usedate}.*.indiv.anl0.latlon.txt*
			                uniq ${storm_nm}${storm_ID}.${usedate}.anl0.latlon.txt0 > ${storm_nm}${storm_ID}.${usedate}.anl0.latlon.txt
			                rm ${storm_nm}${storm_ID}.${usedate}.anl0.latlon.txt0
			                sed -i "s/Infinity/0/g" ${storm_nm}${storm_ID}.${usedate}.anl0.latlon.txt
			                sed -i "s/none//g" ${storm_nm}${storm_ID}.${usedate}.anl0.latlon.txt
					cat ${storm_nm}${storm_ID}.${usedate}.*.indiv.ges0.latlon.txt > ${storm_nm}${storm_ID}.${usedate}.ges0.latlon.txt0
			                rm ${storm_nm}${storm_ID}.${usedate}.*.indiv.ges0.latlon.txt*
			                uniq ${storm_nm}${storm_ID}.${usedate}.ges0.latlon.txt0 > ${storm_nm}${storm_ID}.${usedate}.ges0.latlon.txt
			                rm ${storm_nm}${storm_ID}.${usedate}.ges0.latlon.txt0
			                sed -i "s/Infinity/0/g" ${storm_nm}${storm_ID}.${usedate}.ges0.latlon.txt
			                sed -i "s/none//g" ${storm_nm}${storm_ID}.${usedate}.ges0.latlon.txt
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

