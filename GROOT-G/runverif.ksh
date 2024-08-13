#!/bin/ksh
#SBATCH -t 02:00:00         # XXXX: Time Limit |  generally sufficient; may need to increase it
#SBATCH -A aoml-hafs1       # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p hera           # XXXX: Partition | keep it hera
#SBATCH --ntasks=1	    # XXXX: maximum of 1 task / node
#SBATCH --mail-type=fail    # XXXX: Email Type | NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov
#SBATCH -J VERIF            # XXXX: Job Name | change to whatever you'd like

##########################
# START OF USER SETTINGS #
##########################

# FOLLOW THE BELOW STEPS ~~IN ORDER~~ OR THE VERIFICATION CAPABILITY WON'T WORK!!
# 1) DO NOT CHANGE ANYTHING ABOVE THIS LINE. FIRST FILL OUT THE USER SETTINGS BELOW
# 2) AFTER DOING STEP 1, ONLY THEN CHANGE THE SBATCH -A and SBATCH --mail-user ABOVE TO MATCH WHAT YOU PUT DOWN IN actnew and emlnew BELOW

# Set Folders
homepath=/scratch1/AOML/aoml-osse/${USER} 			# directory path above the GROOT package running location (typically your home directory)
atcfoutput=/scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT/GROOT-G/GFSV16RECON/ # location of your atcf or adeck output
diagoutput=${atcfoutput}			                # location of your diag output (if you're not testing an observation type, set it to $atcfoutput

# What type of tracker files are you using?
usingadecks=0							# are you using ADECKS? if so, GROOT has an additional preprocessing step | (1) yes (0) no

# Date Range of Experiments
startdate1="2020-07-20 00"                              # first date in your sample in format "YYYY-MM-DD HH"
enddate1="2023-10-30 00"                                # last date in your sample in format "YYYY-MM-DD HH"
cycling="6"                                             # frequency of cycling in your model (often "6" for 6 h)

# Set Experiments
set -A expfold GFSv16_CTRL GFSv16_DENY 	        # exp folders (e.g., STORM1EXPERIMENT1 STORM2EXPERIMENT1 STORM1EXPERIMENT2 STORM2EXPERIMENT2)
set -A expnew ALL-R NO-R       			# names of exps (these will be the names on the graphics e.g., EXPERIMENT1 EXPERIMENT1 EXPERIMENT2 EXPERIMENT2)
numfold=2                               	# number of folders in expnew - the number must match!
set -A expyears 2020 2021 2022 2023             # years the experiments cover 
numyears=4                                      # number of years
obstype=uv					# the observation type you're testing, if any, and want graphics for (if you're not testing an observation type, leave it as is)

# Account Information
acntold=aoml-osse                       # account currently listed in SBATCH above
acntnew=aoml-hafs1                       # account you want listed in SBATCH above
emlold=sarah.d.ditchek@noaa.gov         # email address currently listed in SBATCH above
emlnew=sarah.d.ditchek@noaa.gov         # email address you want listed in SBATCH above

##########################################
########## END OF USER SETTINGS ##########
# DO NOT CHANGE ANYTHING BELOW THIS LINE #
##########################################

# Save start and end dates
startdate2=${startdate1}
enddate2=${enddate1}

# Clear Directories
rm -rf ${homepath}/GROOT/GROOT-G/GROOT-PR

# Paths
mkdir -p ${homepath}/GROOT/GROOT-G/scripts
mkdir -p ${homepath}/GROOT/GROOT-G/output
mkdir -p ${homepath}GROOT/GROOT-G/GROOT-PR

homepath=${homepath}
scriptspath=${homepath}/GROOT/GROOT-G/scripts
outputpath=${homepath}/GROOT/GROOT-G/output
progresspath=${homepath}/GROOT/GROOT-G//GROOT-PR

# Clean up old files
rm -f ${outputpath}/OUTPUT*VERIF*.txt
rm -f ${homepath}/GROOT/GROOT-G/slurm*
rm -f ${homepath}/GROOT/GROOT-G/SUBMISSION_FINISHED.txt

# Change Accounts and Emails
cd ${homepath}/GROOT/GROOT-G/
sed -i "s/#SBATCH --mail-user=${emlold}/#SBATCH --mail-user=${emlnew}/g" *.ksh
sed -i "s/#SBATCH -A ${acntold}/#SBATCH -A ${acntnew}/g" *.ksh
sed -i "s/#SBATCH --mail-user=sarah.d.ditchek@noaa.gov/#SBATCH --mail-user=${emlnew}/g" *.ksh # DO NOT CHANGE - this is a failsafe
sed -i "s/#SBATCH -A aoml-hafs1/#SBATCH -A ${acntnew}/g" *.ksh # DO NOT CHANGE - this is a failsafe
cd ${scriptspath}
sed -i "s/#SBATCH --mail-user=${emlold}/#SBATCH --mail-user=${emlnew}/g" *.ksh
sed -i "s/#SBATCH -A ${acntold}/#SBATCH -A ${acntnew}/g" *.ksh
sed -i "s/#SBATCH --mail-user=sarah.d.ditchek@noaa.gov/#SBATCH --mail-user=${emlnew}/g" *.ksh # DO NOT CHANGE - this is a failsafe 
sed -i "s/#SBATCH -A aoml-hafs1/#SBATCH -A ${acntnew}/g" *.ksh # DO NOT CHANGE - this is a failsafe
cd ${homepath}/GROOT/GROOT-G/

# For each experiment, create directories, grab atcf and conv/rad diag files, separate the atcf files into individual storms, and process conv/rad diag files
for ((i=0;i<${numfold};++i))
do
        # Make Directories
        mkdir -p ${progresspath}/${expnew[$i]}/
        mkdir -p ${progresspath}/${expnew[$i]}/anl
        mkdir -p ${progresspath}/${expnew[$i]}/atcf
        mkdir -p ${progresspath}/tcvitals
        mkdir -p ${progresspath}/${expnew[$i]}/grb	

	# Setup Directories
	indir1=${progresspath}/${expnew[$i]}/anl
	indir2=${progresspath}/${expnew[$i]}/atcf
        indir3=${progresspath}/tcvitals
        indir4=${progresspath}/${expnew[$i]}/grb

	for ((j=0;j<${numyears};++j))
	do
		
		# What Experiment and Year
		echo Starting EXP: ${expnew[$i]} and YEAR: ${expyears[$j]} now...

		# Copy Over Files
		cp ${atcfoutput}/${expfold[$i]}/*atcfunix.gfs*.${expyears[$j]}* ${indir2}
		cp ${diagoutput}/${expfold[$i]}/*${obstype}*anl*.gz ${indir1}
        	cp ${diagoutput}/${expfold[$i]}/*${obstype}*anl*.nc4 ${indir1}

		# If using adecks, run an additional preprocessing step
                if [ $usingadecks == 1 ]
		then
			cp ${atcfoutput}/a*${expyears[$j]}.dat ${indir2}
			cat ${indir2}/a*${expyears[$j]}.dat > ${indir2}/${expyears[$j]}.dat  # Combine adeck files from the same year
			grep ${expfold[$i]} ${indir2}/${expyears[$j]}.dat > ${indir2}/${expfold[$i]}_${expyears[$j]}.dat # Extract Experiment from given year
	                if [ -z ${startdate1} ]
		        then
        		    echo  No Start Date Listed!
		        else
        			while [ "$startdate1" != "$( date -d "$enddate1 + $cycling hours" '+%Y-%m-%d %H')" ]; do
			        usedate=$( date -d "$startdate1" '+%Y%m%d%H') # make format YYYYMMDDHH
		        	startdate1=$( date -d "$startdate1 + $cycling hours" '+%Y-%m-%d %H') # increment by 6 hours
		                storm_file=${indir2}/${expfold[$i]}_${expyears[$j]}.dat
        	       			if [ -f $storm_file ] # if ATCF file exists...
		        	        then
        	                	        grep ", ${usedate}," ${storm_file} > ${indir2}/atcfunix.gfs.${usedate}
			                        if [ -s ${indir2}/atcfunix.gfs.${usedate} ]
                        		        then
						       echo It Lives!
						else
	                                 	       rm -rf ${indir2}/atcfunix.gfs.${usedate}
						       echo It Dies!
	        	                        fi
					fi
       				done
	        	fi
		        startdate1=${startdate2}
		        enddate1=${enddate2}
        		rm -rf ${indir2}/${expyears[$j]}.dat
			rm -rf ${indir2}/${expfold[$i]}_${expyears[$j]}.dat
			rm -rf ${indir2}/a*${expyears[$j]}.dat
			sed -i "s/0,   ,  34,/0, XX,  34,/g" ${indir2}/*
        		sed -i "s/0,   ,  50,/0, XX,  50,/g" ${indir2}/*
		        sed -i "s/0,   ,  64,/0, XX,  64,/g" ${indir2}/*
		fi

		#Create file that has all unique storm names
		grep -hEo ".{0,7} ${expyears[$j]}0" ${indir2}/atcfunix.gfs.* > ${progresspath}/out1.txt # gets all text before 2019, only
                grep -hEo ".{0,7} ${expyears[$j]}1" ${indir2}/atcfunix.gfs.* > ${progresspath}/out2.txt # gets all text before 2019, only
	        cat ${progresspath}/out* > /${progresspath}/out.txt
		rm -rf ${progresspath}/out1.txt
		rm -rf ${progresspath}/out2.txt
		sed -i 's/.$//' ${progresspath}/out.txt
		sort ${progresspath}/out.txt | uniq > ${progresspath}/listofstorms.txt # gets list of all storms 
		rm ${progresspath}/out.txt
		awk '{ t=$1 ; $1=$2; $2=t; print }' ${progresspath}/listofstorms.txt > ${progresspath}/nameofstorms.txt
		sed -e "s/, ${expyears[$j]}//g" ${progresspath}/nameofstorms.txt > ${progresspath}/names.txt
		sed -e 's/, //g' ${progresspath}/names.txt > ${progresspath}/nameofstorms.txt
		sed -i "/${expyears[$j]}/d" ${progresspath}/nameofstorms.txt
        	sed -i "/  /d" ${progresspath}/listofstorms.txt	
	        rm ${progresspath}/names.txt
		filename=${progresspath}/listofstorms.txt
		filename2=${progresspath}/nameofstorms.txt
		startdate2=${startdate1}	
		enddate2=${enddate1}

	
		# Grab TCVITALS - only once per year!
		if [ $i == 0 ]
		then 
			while read line
			do
			    name=`echo ${line} | awk '{print $2}'`
			    date=`echo ${line} | awk '{print $4}'`
			    tm=`echo ${line} | awk '{print $5}'`
	
			     echo "${line}" > ${indir3}/${name}.${date}${tm:0:2}.storm_vit
			done < /scratch1/NCEPDEV/hwrf/noscrub/input/SYNDAT-PLUS/syndat_tcvitals.${expyears[$j]}
		fi

		# Grab files (name)
		if [ -z ${startdate1} ]
		then
		   echo	 No Start Date Listed! Exiting...
		else
		while [ "$startdate1" != "$( date -d "$enddate1 + $cycling hours" '+%Y-%m-%d %H')" ]; do
		   usedate=$( date -d "$startdate1" '+%Y%m%d%H') # make format YYYYMMDDHH
		   startdate1=$( date -d "$startdate1 + $cycling hours" '+%Y-%m-%d %H') # increment by 6 hours
		   # PROCESS ATCF AND DIAG FILES
		   storm_file=${indir2}/atcfunix.gfs.${usedate}
		   storm_file1=${indir1}/diag_conv_${obstype}_anl.${usedate}.nc4.gz
                   storm_file2=${indir1}/diag_conv_${obstype}_anl.${usedate}.nc4

			if [ -f $storm_file ] # if ATCF file exists...
			then
			        	echo Dealing with ${usedate} File Now!
					cd ${indir2}/
	
					while read -r -u 8 p && read -r -u 9 q; do 
					    echo $p
					    echo $q
	 				   if grep -q "$p" ${storm_file}
					   then
					    	grep "$p" ${storm_file} > ${q}.${usedate}.tctracker.atcfunix
					   else
					    	echo storm does not exist for this cycle
					   fi
					done 8<${filename} 9<${filename2}
			
				if [ -f $storm_file1 ] # if GZ file exists...
	                        then
        	                        echo Dealing with ${usedate} diag File Now!
                	                cd ${indir1}/
                       	        	gunzip ${indir1}/diag_conv_${obstype}_anl.${usedate}.nc4.gz
                        	elif [ -f $storm_file2 ] # if already unzipped...
	                        then
        	                        echo GZ file already unzipped for ${usedate}!
                	        else
                        	        echo There is no GZ file for {$usedate}! Creating a blank conv/rad file now...
                                	cd ${indir1}/
	                                echo none > diag_conv_anl.${usedate}.${obstype}.latlon.txt
        	                fi
			else
			        echo There is no ATCF file for ${usedate}! Skipping...
			fi
		done
		fi

		startdate1=${startdate2}
		enddate1=${enddate2}
		rm ${indir2}/atcfunix.gfs.*
		rm ${progresspath}/nameofstorms.txt
		rm ${progresspath}/listofstorms.txt
	done

        rm ${indir2}/*AA* # not a valid bdeck identifier (A)
        rm ${indir2}/*SI* # not a valid bdeck identifier (S)
        rm ${indir2}/*BB* # not a valid bdeck identifier (B)
        rm ${indir2}/*SC* # not a valid bdeck identifier (O)
        rm ${indir2}/*EC* # not a valid bdeck identifier (T)
        rm ${indir2}/*AU* # not a valid bdeck identifier (U)
        rm ${indir2}/*SP* # not a valid bdeck identifier (P)
        rm ${indir2}/*SL* # not a valid bdeck identifier (Q)
        rm ${indir2}/*HC* # not a valid bdeck identifier (default)
        rm ${indir2}/6* # not a valid bdeck identifer
        rm ${indir2}/7* # not a valid bdeck identifer
        rm ${indir2}/8* # not a valid bdeck identifer
        rm ${indir2}/9* # not a valid bdeck identifer

done

# Ensure BDECKs have HU instead of TY and ST
sed -i "s/, TY, /, HU, /g" ${homepath}/GROOT/GROOT-G/bdeck/b*.dat
sed -i "s/, ST, /, HU, /g" ${homepath}/GROOT/GROOT-G/bdeck/b*.dat

# Run the namelist
cd ${homepath}/GROOT/GROOT-G/
matlab -nosplash -nodesktop < editverif.m > ${outputpath}/OUTPUT_verif.txt
wait

# Import the values in the output file
cp commonverif.txt ${scriptspath}/
source ./commonverif.txt

# Run the package
#sbatch ${scriptspath}/matlabverifgraphics.ksh $scriptspath $outputpath $homepath

exit 0
