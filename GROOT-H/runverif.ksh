#!/bin/ksh
#SBATCH -t 02:00:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-hafs1      # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p hera	    # XXXX: Partition | keep it hera
#SBATCH --ntasks=1	    # XXXX: maximum of 1 task / node
#SBATCH --mail-type=fail    # XXXX: Email Type | NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov # XXXX: Email | Use your email
#SBATCH -J VERIF	    # XXXX: Job Name | change to whatever you'd like

##########################
# START OF USER SETTINGS #
##########################

# FOLLOW THE BELOW STEPS ~~IN ORDER~~ OR THE VERIFICATION CAPABILITY WON'T WORK!!
# 1) DO NOT CHANGE ANYTHING ABOVE THIS LINE. FIRST FILL OUT THE USER SETTINGS BELOW
# 2) AFTER DOING STEP 1, ONLY THEN CHANGE THE SBATCH -A and SBATCH --mail-user ABOVE TO MATCH WHAT YOU PUT DOWN IN actnew and emlnew BELOW

# Set Folders
homepath=/scratch1/AOML/aoml-osse/${USER}/                              # directory path above the GROOT package running location (typically your home directory)
noscrubpath=/scratch2/AOML/aoml-hafs1/${USER}/noscrub/hafstrak/         # path to your atcf files
scrubpath=/scratch2/AOML/aoml-hafs1/${USER}/scrub/ 			# path to your scrub directory (if you are not running the assim obs capabilty, you can set this to $noscrubpath)

# What type of tracker files are you using?
usingadecks=0                                           # are you using ADECKS? if so, GROOT has an additional preprocessing step | (1) yes (0) no
numatcf=0						# if using ATCF files, do they start with a number (numatcf=1) or the TC name (numatcf=0)? if using ADECKS, this value won't matter

# If your tracker files are ADECKS...
startdate1="2018-05-01 00"				# first date in your sample in format "YYYY-MM-DD HH"
enddate1="2022-11-30 18"				# last date in your sample in format "YYYY-MM-DD HH"
cycling="6"               				# frequency of cycling in your model (often "6" for 6 h)

# Set Experiments
set -A expfold DELTA-ALL-A ELSA-ALL-A FIONA-ALL-A FRANKLIN-ALL-A HENRI-ALL-A IAN-ALL-A IDA-ALL-A IDALIA-ALL-A LAURA-ALL-A LEE-ALL-A SAM-ALL-A ZETA-ALL-A DELTA-NOG4-A ELSA-NOG4-A FIONA-NOG4-A FRANKLIN-NOG4-A HENRI-NOG4-A IAN-NOG4-A IDA-NOG4-A IDALIA-NOG4-A LAURA-NOG4-A LEE-NOG4-A SAM-NOG4-A ZETA-NOG4-A # names of the folders in scrub and noscrub that you want to include in the graphics # e.g.: STORM1EXPERIMENT1 STORM2EXPERIMENT1 STORM1EXPERIMENT2 STORM2EXPERIMENT2
set -A expnew ALL-A ALL-A ALL-A ALL-A ALL-A ALL-A ALL-A ALL-A ALL-A ALL-A ALL-A ALL-A NOG4-A NOG4-A NOG4-A NOG4-A NOG4-A NOG4-A NOG4-A NOG4-A NOG4-A NOG4-A NOG4-A NOG4-A # names of exps (these will be the names on the graphics) # e.g.: EXPERIMENT1 EXPERIMENT1 EXPERIMENT2 EXPERIMENT2
numfold=24                                              # number of entries in expnew
set -A expyears 2020 2021 2022 2023			# years the experiments cover
numyears=4						# number of years
hafsmodel=1						# did you run with HAFS (hafsmodel=1) or HWRF (hafsmodel=0)

acntold=aoml-hafs1  					# account currently listed in SBATCH above
acntnew=aoml-hafs1                      		# account you want listed in SBATCH above
emlold=sarah.d.ditchek@noaa.gov        			# email address currently listed in SBATCH above
emlnew=sarah.d.ditchek@noaa.gov         		# email address you want listed in SBATCH above

##########################################
########## END OF USER SETTINGS ##########
# DO NOT CHANGE ANYTHING BELOW THIS LINE #
##########################################

rm -rf ${homepath}/GROOT/GROOT-H/GROOT-PR/
mkdir -p ${homepath}/GROOT/GROOT-H/GROOT-PR
mkdir -p ${homepath}/GROOT/GROOT-H/output 
outputpath=${homepath}/GROOT/GROOT-H/output
verifpath=${homepath}/GROOT/GROOT-H/GROOT-PR
scriptspath=${homepath}/GROOT/GROOT-H/scripts

# Clean up old files
rm -f ${outputpath}/OUTPUT*VERIF*.txt
rm -f ${homepath}/GROOT/GROOT-H/slurm* 
rm -f ${homepath}/GROOT/GROOT-H/SUBMISSION_FINISHED.txt

# Change Accounts and Emails
cd ${homepath}/GROOT/GROOT-H/
sed -i "s/#SBATCH --mail-user=${emlold}/#SBATCH --mail-user=${emlnew}/g" rungrb.ksh
sed -i "s/#SBATCH -A ${acntold}/#SBATCH -A ${acntnew}/g" rungrb.ksh
sed -i "s/#SBATCH --mail-user=sarah.d.ditchek@noaa.gov/#SBATCH --mail-user=${emlnew}/g" rungrb.ksh # DO NOT CHANGE - this is a failsafe
sed -i "s/#SBATCH -A aoml-osse/#SBATCH -A ${acntnew}/g" rungrb.ksh # DO NOT CHANGE - this is a failsafe
cd ${scriptspath}
sed -i "s/#SBATCH --mail-user=${emlold}/#SBATCH --mail-user=${emlnew}/g" *.ksh
sed -i "s/#SBATCH -A ${acntold}/#SBATCH -A ${acntnew}/g" *.ksh
sed -i "s/#SBATCH --mail-user=sarah.d.ditchek@noaa.gov/#SBATCH --mail-user=${emlnew}/g" *.ksh # DO NOT CHANGE - this is a failsafe
sed -i "s/#SBATCH -A aoml-osse/#SBATCH -A ${acntnew}/g" *.ksh # DO NOT CHANGE - this is a failsafe
cd ${retrievalpath}
sed -i "s/#SBATCH --mail-user=${emlold}/#SBATCH --mail-user=${emlnew}/g" *.ksh
sed -i "s/#SBATCH -A ${acntold}/#SBATCH -A ${acntnew}/g" *.ksh
sed -i "s/#SBATCH --mail-user=sarah.d.ditchek@noaa.gov/#SBATCH --mail-user=${emlnew}/g" *.ksh # DO NOT CHANGE - this is a failsafe
sed -i "s/#SBATCH -A aoml-osse/#SBATCH -A ${acntnew}/g" *.ksh # DO NOT CHANGE - this is a failsafe
cd ${homepath}/GROOT/GROOT-H/

for ((i=0;i<${numfold};++i))
do
	# Make Directories
	mkdir -p ${verifpath}/obsall/${expnew[$i]}/
	mkdir -p ${verifpath}/tcvitals/
	mkdir -p ${verifpath}/${expnew[$i]}/

	# Remove Current Files
	rm ${verifpath}/tcvitals/*
	rm ${verifpath}/obsall/${expnew[$i]}/*
	rm ${verifpath}/${expnew[$i]}/*
done

if [ "${usingadecks}" -eq 0 ]
then
for ((i=0;i<${numfold};++i))
do	
	# Copy Over Files
	cp ${scrubpath}/${expfold[$i]}/**/**/**/*.latlon* ${verifpath}/obsall/${expnew[$i]}/
        cp ${scrubpath}/${expfold[$i]}/**/**/**/*details.txt ${verifpath}/obsall/${expnew[$i]}/
        cp ${scrubpath}/${expfold[$i]}/**/**/**/*profiles.txt ${verifpath}/obsall/${expnew[$i]}/
        cp ${scrubpath}/${expfold[$i]}/**/**/**/*channels.txt ${verifpath}/obsall/${expnew[$i]}/
        cp ${scrubpath}/${expfold[$i]}/**/**/**/qcflags*.txt ${verifpath}/obsall/${expnew[$i]}/
	cp ${scrubpath}/${expfold[$i]}/**/**/**/*vit ${verifpath}/tcvitals/
	cp ${scrubpath}/${expfold[$i]}/**/**/**/*enkf* ${verifpath}/obsall/${expnew[$i]}/
	cp ${scrubpath}/${expfold[$i]}/**/**/**/*nc4 ${verifpath}/obsall/${expnew[$i]}/
	cp -r ${noscrubpath}/${expfold[$i]}/*atcfunix ${verifpath}/${expnew[$i]}/
	rm ${verifpath}/${expnew[$i]}/*parent*
        rm ${verifpath}/${expnew[$i]}/*storm*

	if [ "${numatcf}" -eq 1 ]
	then
		matlab -nosplash -nodesktop -r  "identgrootpr='${verifpath}/${expnew[$i]}/';identout='${homepath}/GROOT/GROOT-H/';" < ${scriptspath}/tclookup_atcf.m > ${outputpath}/OUTPUT_TCLOOKUP.txt &
		wait
		mv ${homepath}/GROOT/GROOT-H/tclookup.txt ${verifpath}/${expnew[$i]}/tclookup.txt
		cd ${verifpath}/${expnew[$i]}/
		source ./tclookup.txt
		rm ${verifpath}/${expnew[$i]}/tclookup.txt
		cd ${homepath}/GROOT/GROOT-H/
	fi
done
fi

if [ "${usingadecks}" -eq 1 ]
then
startdate2=${startdate1}
enddate2=${enddate1}
# For each experiment, create directories, grab atcf and conv/rad diag files, separate the atcf files into individual storms, and process conv/rad diag files
for ((i=0;i<${numfold};++i))
do

	for ((j=0;j<${numyears};++j))
	do
		
		# What Experiment and Year
		echo Starting EXP: ${expnew[$i]} and YEAR: ${expyears[$j]} now...
		indir2=${verifpath}/${expnew[$i]}/
		cp ${noscrubpath}/a*${expyears[$j]}.dat ${indir2}
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
                        	        grep ", ${usedate}," ${storm_file} > ${indir2}/atcfunixp.gfs.${usedate}
		                        if [ -s ${indir2}/atcfunixp.gfs.${usedate} ]
                       		        then
					       echo It Lives! ${usedate}
					else
	                                	       rm -rf ${indir2}/atcfunixp.gfs.${usedate}
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

		#Create file that has all unique storm names
		grep -hEo ".{0,7} ${expyears[$j]}0" ${indir2}/atcfunixp.gfs.* > ${verifpath}/out1.txt # gets all text before 2019, only
                grep -hEo ".{0,7} ${expyears[$j]}1" ${indir2}/atcfunixp.gfs.* > ${verifpath}/out2.txt # gets all text before 2019, only
	        cat ${verifpath}/out* > /${verifpath}/out.txt
		rm -rf ${verifpath}/out1.txt
		rm -rf ${verifpath}/out2.txt
		sed -i 's/.$//' ${verifpath}/out.txt
		sort ${verifpath}/out.txt | uniq > ${verifpath}/listofstorms.txt # gets list of all storms 
		rm ${verifpath}/out.txt
		awk '{ t=$1 ; $1=$2; $2=t; print }' ${verifpath}/listofstorms.txt > ${verifpath}/nameofstorms.txt
		sed -e "s/, ${expyears[$j]}//g" ${verifpath}/nameofstorms.txt > ${verifpath}/names.txt
		sed -e 's/, //g' ${verifpath}/names.txt > ${verifpath}/nameofstorms.txt
		sed -i "/${expyears[$j]}/d" ${verifpath}/nameofstorms.txt
        	sed -i "/  /d" ${verifpath}/listofstorms.txt	
	        rm ${verifpath}/names.txt
		filename=${verifpath}/listofstorms.txt
		filename2=${verifpath}/nameofstorms.txt
		startdate2=${startdate1}	
		enddate2=${enddate1}

	
		# Grab files (name)
		if [ -z ${startdate1} ]
		then
		   echo	 No Start Date Listed! Exiting...
		else
		while [ "$startdate1" != "$( date -d "$enddate1 + $cycling hours" '+%Y-%m-%d %H')" ]; do
		   usedate=$( date -d "$startdate1" '+%Y%m%d%H') # make format YYYYMMDDHH
		   startdate1=$( date -d "$startdate1 + $cycling hours" '+%Y-%m-%d %H') # increment by 6 hours
		   # PROCESS ATCF AND DIAG FILES
		   storm_file=${indir2}/atcfunixp.gfs.${usedate}
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
		rm ${indir2}/atcfunixp.gfs.*
                rm ${verifpath}/nameofstorms.txt
		rm ${verifpath}/listofstorms.txt
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

	matlab -nosplash -nodesktop -r  "identgrootpr='${verifpath}/${expnew[$i]}/';identout='${homepath}/GROOT/GROOT-H/';" < ${scriptspath}/tclookup_adeck.m > ${outputpath}/OUTPUT_TCLOOKUP.txt &
        wait
        mv ${homepath}/GROOT/GROOT-H/tclookup.txt ${verifpath}/${expnew[$i]}/tclookup.txt
        cd ${verifpath}/${expnew[$i]}/
        source ./tclookup.txt
        rm ${verifpath}/${expnew[$i]}/tclookup.txt
        cd ${homepath}/GROOT/GROOT-H/

done
fi

#Grab TCVITALS for HAFS, only
if [ "${hafsmodel}" -eq 1 ]
then
for ((j=0;j<${numyears};++j))
do
   while read line
   do
   	name=`echo ${line} | awk '{print $2}'`
        date=`echo ${line} | awk '{print $4}'`
        tm=`echo ${line} | awk '{print $5}'`
        echo "${line}" > ${verifpath}/tcvitals/${name}.${date}${tm:0:2}.storm_vit
    done < /scratch1/NCEPDEV/hwrf/noscrub/input/SYNDAT-PLUS/syndat_tcvitals.${expyears[$j]}
done
fi

# Ensure BDECKs have HU instead of TY and ST
sed -i "s/, TY, /, HU, /g" ${homepath}/GROOT/GROOT-H/bdeck/b*.dat
sed -i "s/, ST, /, HU, /g" ${homepath}/GROOT/GROOT-H/bdeck/b*.dat

# Run the namelist
cd ${homepath}/GROOT/GROOT-H/
matlab -nosplash -nodesktop < editverif.m > ${outputpath}/OUTPUT_VERIF.txt
wait

# Import the values in the output file
cp commonverif.txt ${scriptspath}/
source ./commonverif.txt

# Run the package
sbatch ${scriptspath}/matlabverifgraphics.ksh $scriptspath $outputpath $homepath

exit 0
