#!/bin/ksh 
#SBATCH -t 01:00:00         # XXXX: Time Limit: generally sufficient; may need to increase it
#SBATCH -A aoml-osse        # XXXX: Account:   Use your project accounti
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH --partition=bigmem  # XXXX: request specific partition for resource allocation
#SBATCH --ntasks=40	    # XXXX: maximum of 1 task / node
#SBATCH --mail-type=fail    # XXXX: NONE, BEGIN, END, FAIL, REQUEUE, ALL 
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov
#SBATCH -J VERIF            # XXXX: Job Name: change

##########################
# start of user settings #
##########################

# FOLLOW THE BELOW STEPS IN ORDER OR THE VERIFICATION CAPABILITY WON'T WORK!!
# 1) FILL OUT THE USER SETTINGS BELOW
# 2) AFTER DOING STEP 1, CHANGE THE SBATCH -A and SBATCH --mail-user ABOVE TO MATCH WHAT YOU PUT DOWN IN actnew and emlnew BELOW
# 3) OTHERWISE THERE IS NOTHING ELSE TO EDIT HERE :)

# Set Folders
dirpth=/scratch1/BMC/qosap/${USER}      # directory path above GROOT-G location
cycling="6"               		# frequency of cycling in your model (often 6 for 6 h)
year="2019"               		# year of file range (currently, cannot overlap years - email Sarah Ditchek if you need this capability)
atcfoutput=/scratch2/AOML/aoml-osse/Karina.Apodaca/projects/aeolus/noscrub/archive/ 		# location of your atcf output
diagoutput=/scratch2/AOML/aoml-osse/Karina.Apodaca/projects/aeolus/postprocessing/cnvstats/	# location of your diag output

# Identify Experiments
set -A expfold Lorena_ctl Lorena_noVQC	# exp folders (e.g., STORM1EXPERIMENT1 STORM2EXPERIMENT1 STORM1EXPERIMENT2 STORM2EXPERIMENT2)
set -A expnew noAEOLUS AEOLUS           # names of exps (these will be the names on the graphics e.g., EXPERIMENT1 EXPERIMENT1 EXPERIMENT2 EXPERIMENT2)
numfold=2                               # number of folders in expnew - the number must match!
obstype=dw				# the observation type you're testing and want graphics for (currently not a capability of the package, but you can grab the files anyway)

# Account Information
acntold=aoml-osse                       # account currently listed in SBATCH above
acntnew=aoml-osse                       # account you want listed in SBATCH above
emlold=sarah.d.ditchek@noaa.gov         # email address currently listed in SBATCH above
emlnew=sarah.d.ditchek@noaa.gov         # email address you want listed in SBATCH above

# Date range of files desired | format must be yyyy-mm-dd hh
startdate1="2019-09-15 06"
enddate1="2019-09-20 18"

########################
# END OF USER SETTINGS #
########################

# Clear Directories
rm -rf ${dirpth}/GROOT/GROOT-G/GROOT-PR

# Paths
mkdir -p ${dirpth}/GROOT/GROOT-G/scripts
mkdir -p ${dirpth}/GROOT/GROOT-G/output
mkdir -p ${dirpth}/GROOT/GROOT-G/RESULTS
mkdir -p ${dirpth}/GROOT/GROOT-G/GROOT-PR

homepath=${dirpth}
scriptspath=${dirpth}/GROOT/GROOT-G/scripts
outputpath=${dirpth}/GROOT/GROOT-G/output
resultspath=${dirpth}/GROOT/GROOT-G/RESULTS/
progresspath=${dirpth}/GROOT/GROOT-G/GROOT-PR

# Clean up old files
rm -f ${outputpath}/OUTPUT_editsingle.txt
#rm -f ${homepath}/slurm*

# Change Accounts and Emails
cd ${homepath}/GROOT/GROOT-G/
sed -i "s/#SBATCH --mail-user=${emlold}/#SBATCH --mail-user=${emlnew}/g" *.ksh
sed -i "s/#SBATCH -A ${acntold}/#SBATCH -A ${acntnew}/g" *.ksh
cd ${scriptspath}
sed -i "s/#SBATCH --mail-user=${emlold}/#SBATCH --mail-user=${emlnew}/g" *.ksh
sed -i "s/#SBATCH -A ${acntold}/#SBATCH -A ${acntnew}/g" *.ksh
cd ${homepath}/GROOT/GROOT-G/

# For each experiment, create directories, grab atcf and conv/rad diag files, separate the atcf files into individual storms, and process conv/rad diag files
for ((i=0;i<${numfold};++i))
do
        # Make Directories
        mkdir -p ${progresspath}/${expnew[$i]}/
        mkdir -p ${progresspath}/${expnew[$i]}/anl
        mkdir -p ${progresspath}/${expnew[$i]}/ges
        mkdir -p ${progresspath}/${expnew[$i]}/atcf


	# Setup Directories
	indir1=${progresspath}/${expnew[$i]}/anl
	indir2=${progresspath}/${expnew[$i]}/atcf

	# Copy Over Files
	cp ${atcfoutput}/${expfold[$i]}/*atcfunixp.gfs* ${indir2}
	cp ${diagoutput}/${expfold[$i]}/*${obstype}*anl*.gz ${indir1}

	# Create file that has all unique storm names
	grep -hEo ".{0,8}${year}" ${indir2}/atcfunixp.gfs.* > ${progresspath}/out.txt # gets all text before 2019, only
	sort ${progresspath}/out.txt | uniq > ${progresspath}/listofstorms.txt # gets list of all storms 
	rm ${progresspath}/out.txt
	awk '{ t=$1 ; $1=$2; $2=t; print }' ${progresspath}/listofstorms.txt > ${progresspath}/nameofstorms.txt
	sed -e "s/, ${year}//g" ${progresspath}/nameofstorms.txt > ${progresspath}/names.txt
	sed -e 's/, //g' ${progresspath}/names.txt > ${progresspath}/nameofstorms.txt
	rm ${progresspath}/names.txt
	filename=${progresspath}/listofstorms.txt
	filename2=${progresspath}/nameofstorms.txt
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
	   # PROCESS ATCF FILES
	   storm_file=${indir2}/atcfunixp.gfs.${usedate}
		if [ -f $storm_file ] # if ATCF file exists...
		then
		        	echo Dealing with ${usedate} File Now!
				cd ${indir2}/
	
				while read -r -u 8 p && read -r -u 9 q; do 
				    echo $p
				    echo $q
	 			   if grep -q "$p" ${storm_file}
				   then
				    	grep "$p" ${storm_file} > ${q}.${usedate}.trak.hwrf.atcfunix
				   else
				    	echo storm does not exist for this cycle
				   fi
				done 8<${filename} 9<${filename2}
		else
		        echo There is no ATCF file for this cycle! Skipping...
		fi
	  # PROCESS DIAG FILES
	  storm_file=${indir1}/diag_conv_${obstype}_anl.${usedate}.nc4.gz
	        if [ -f $storm_file ] # if GZ file exists...
        	then
                        echo Dealing with ${usedate} File Now!
                        cd ${indir1}/
                        gunzip ${indir1}/diag_conv_${obstype}_anl.${usedate}.nc4.gz
	        else
                	echo There is no GZ file for this cycle! Creating a blank conv/rad file now...
			cd ${indir1}/
			echo none > diag_conv_anl.${usedate}.${obstype}.latlon.txt	
        	fi

	done
	fi

	startdate1=${startdate2}
	enddate1=${enddate2}
	rm ${indir2}/atcfunixp.gfs.*
	rm ${progresspath}/nameofstorms.txt
	rm ${progresspath}/listofstorms.txt
done


# Run the namelist
cd ${homepath}/GROOT/GROOT-G/
matlab -nosplash -nodesktop < editverif.m > ${outputpath}/OUTPUT_verif.txt
#wait

# Import the values in the output file
cp commonverif.txt ${scriptspath}/
source ./commonverif.txt

# Run the package
sbatch ${scriptspath}/matlabverifgraphics.ksh $scriptspath $outputpath $homepath

exit 0
