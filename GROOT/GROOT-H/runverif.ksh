#!/bin/ksh
#SBATCH -t 00:05:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-osse        # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p hera		    # XXXX: Partition | keep it hera
#SBATCH --ntasks=1	    # XXXX: maximum of 1 task / node
#SBATCH --mail-type=fail    # XXXX: Email Type | NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov # XXXX: Email | Use your email
#SBATCH -J VERIF	    # XXXX: Job Name | change to whatever you'd like

##########################
# START OF USER SETTINGS #
##########################

# FOLLOW THE BELOW STEPS IN ORDER OR THE VERIFICATION CAPABILITY WON'T WORK!!
# 1) FILL OUT THE USER SETTINGS BELOW
# 2) AFTER DOING STEP 1, CHANGE THE SBATCH -A and SBATCH --mail-user ABOVE TO MATCH WHAT YOU PUT DOWN IN actnew and emlnew BELOW
# 3) OTHERWISE THERE IS NOTHING ELSE TO EDIT HERE :)

# Set Folders
homepath=/scratch1/AOML/aoml-osse/${USER}/              # directory path above the GROOT package
resultspath=/scratch2/AOML/aoml-osse/${USER}/           # directory path for results
noscrubpath=${homepath}/noscrub/atcf                    # path to your atcf files
scrubpath=${homepath}/scrub				# path to your scrub directory
dirpth=${homepath}/GROOT                                # directory path above GROOT-H location

# Set Experiments
set -A expfold HB20_B1_ALL HB20new HB20_B2_ALL HB20_B3_ALL HB20_B6_ALL HB20_B7_ALL HB20_B8_ALL HB20_B1_NO HB20_NO HB20_B2_NO HB20_B3_NO HB20_B6_NO HB20_B7_NO HB20_B8_NO #exp folders (the folders in scrub and noscrub that you want to include in the graphics e.g., STORM1EXPERIMENT1 STORM2EXPERIMENT1 STORM1EXPERIMENT2 STORM2EXPERIMENT2)
set -A expnew ALL ALL ALL ALL ALL ALL ALL NO NO NO NO NO NO NO # names of exps (these will be the names on the graphics e.g., EXPERIMENT1 EXPERIMENT1 EXPERIMENT2 EXPERIMENT2)
numfold=14

# Account Information
acntold=aoml-osse                       		# account currently listed in SBATCH above
acntnew=aoml-osse                       		# account you want listed in SBATCH above
emlold=sarah.d.ditchek@noaa.gov        			# email address currently listed in SBATCH above
emlnew=sarah.d.ditchek@noaa.gov         		# email address you want listed in SBATCH above

########################
# END OF USER SETTINGS #
########################

rm -rf ${resultspath}/GROOT/GROOT-H/GROOT-PR/
mkdir -p ${resultspath}/GROOT/GROOT-H/GROOT-PR
mkdir -p ${homepath}/GROOT/GROOT-H/output 
outputpath=${homepath}/GROOT/GROOT-H/output
verifpath=${resultspath}/GROOT/GROOT-H/GROOT-PR
scriptspath=${homepath}/GROOT/GROOT-H/scripts

# Clean up old files
rm -f ${outputpath}/OUTPUT*VERIF*.txt
#rm -f ${homepath}/GROOT/GROOT-H/slurm* 
rm -f ${homepath}/GROOT/GROOT-H/SUBMISSION_FINISHED.txt

# Change Accounts and Emails
cd ${homepath}
sed -i "s/#SBATCH --mail-user=${emlold}/#SBATCH --mail-user=${emlnew}/g" *.ksh
sed -i "s/#SBATCH -A ${acntold}/#SBATCH -A ${acntnew}/g" *.ksh
sed -i "s/#SBATCH --mail-user=sarah.d.ditchek@noaa.gov/#SBATCH --mail-user=${emlnew}/g" *.ksh
sed -i "s/#SBATCH -A aoml-osse/#SBATCH -A ${acntnew}/g" *.ksh
cd ${scriptspath}
sed -i "s/#SBATCH --mail-user=${emlold}/#SBATCH --mail-user=${emlnew}/g" *.ksh
sed -i "s/#SBATCH -A ${acntold}/#SBATCH -A ${acntnew}/g" *.ksh
sed -i "s/#SBATCH --mail-user=sarah.d.ditchek@noaa.gov/#SBATCH --mail-user=${emlnew}/g" *.ksh
sed -i "s/#SBATCH -A aoml-osse/#SBATCH -A ${acntnew}/g" *.ksh
cd ${retrievalpath}
sed -i "s/#SBATCH --mail-user=${emlold}/#SBATCH --mail-user=${emlnew}/g" *.ksh
sed -i "s/#SBATCH -A ${acntold}/#SBATCH -A ${acntnew}/g" *.ksh
sed -i "s/#SBATCH --mail-user=sarah.d.ditchek@noaa.gov/#SBATCH --mail-user=${emlnew}/g" *.ksh
sed -i "s/#SBATCH -A aoml-osse/#SBATCH -A ${acntnew}/g" *.ksh
cd ${homepath}

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

for ((i=0;i<${numfold};++i))
do	
	# Copy Over Files
	cp ${scrubpath}/${expfold[$i]}/**/**/**/*conv.latlon* ${verifpath}/obsall/${expnew[$i]}/
        cp ${scrubpath}/${expfold[$i]}/**/**/**/*details.txt ${verifpath}/obsall/${expnew[$i]}/
        cp ${scrubpath}/${expfold[$i]}/**/**/**/*profiles.txt ${verifpath}/obsall/${expnew[$i]}/
        cp ${scrubpath}/${expfold[$i]}/**/**/**/*channels.txt ${verifpath}/obsall/${expnew[$i]}/
        cp ${scrubpath}/${expfold[$i]}/**/**/**/qcflags*.txt ${verifpath}/obsall/${expnew[$i]}/
	cp ${scrubpath}/${expfold[$i]}/**/**/**/*vit ${verifpath}/tcvitals/
	cp ${noscrubpath}/${expfold[$i]}/*.trak.hwrf.atcfunix* ${verifpath}/${expnew[$i]}/
done

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
