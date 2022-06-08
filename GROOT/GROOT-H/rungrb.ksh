#!/bin/ksh
#SBATCH -t 01:00:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-osse        # XXXX: Account |  Use your project accounti
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p hera	    # XXXX: Partition | keep it hera
#SBATCH --ntasks=1	    # XXXX: maximum of 1 task / node
#SBATCH --mail-type=fail    # XXXX: Email Type | NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov # XXXX: Email | Use your email
#SBATCH -J SING  	    # XXXX: Job Name | change to whatever you'd like

##########################
# START OF USER SETTINGS #
##########################

# FOLLOW THE BELOW STEPS IN ORDER OR THE VERIFICATION CAPABILITY WON'T WORK!!
# 1) DO NOT CHANGE ANYTHING ABOVE THIS LINE. FIRST FILL OUT THE USER SETTINGS BELOW
# 2) AFTER DOING STEP 1, ONLY THEN CHANGE THE SBATCH -A and SBATCH --mail-user ABOVE TO MATCH WHAT YOU PUT DOWN IN actnew and emlnew BELOW

# Account Information
acntold=aoml-osse				# account currently listed in SBATCH above
acntnew=aoml-osse				# account you want listed in SBATCH above
emlold=sarah.d.ditchek@noaa.gov			# email address currently listed in SBATCH above
emlnew=sarah.d.ditchek@noaa.gov			# email address you want listed in SBATCH above
dirpth=/scratch1/AOML/aoml-osse/${USER}/GROOT	# directory path above GROOT-H location

########################
# END OF USER SETTINGS #
########################

# Paths
scriptspath=${dirpth}/GROOT-H/scripts
outputpath=${dirpth}/GROOT-H/output
homepath=${dirpth}/GROOT-H
retrievalpath=${dirpth}/GROOT-H/retrievalscripts

# Check if a directory does not exist
if [ ! -d "${outputpath}" ]
then
   mkdir ${outputpath}
fi

# Clean up old files
rm -f ${outputpath}/OUTPUT_S*.txt
rm -f ${outputpath}/OUTPUT_DA*.txt
rm -f ${homepath}/slurm*
rm -f ${homepath}/SUBMISSION_S*FINISHED.txt

# Change Accounts and Emails
cd ${homepath}
sed -i "s/#SBATCH --mail-user=${emlold}/#SBATCH --mail-user=${emlnew}/g" *.ksh
sed -i "s/#SBATCH -A ${acntold}/#SBATCH -A ${acntnew}/g" *.ksh
cd ${scriptspath}
sed -i "s/#SBATCH --mail-user=${emlold}/#SBATCH --mail-user=${emlnew}/g" *.ksh
sed -i "s/#SBATCH -A ${acntold}/#SBATCH -A ${acntnew}/g" *.ksh
cd ${retrievalpath}
sed -i "s/#SBATCH --mail-user=${emlold}/#SBATCH --mail-user=${emlnew}/g" *.ksh
sed -i "s/#SBATCH -A ${acntold}/#SBATCH -A ${acntnew}/g" *.ksh
cd ${homepath}

# Run the case
matlab -nosplash -nodesktop < editgrb.m > ${outputpath}/OUTPUT_editgrb.txt
wait

# Import the values in the output file
cp common.txt ${scriptspath}/
source ./common.txt

# Clean up old files
rm -f ${outputpath}/OUTPUT_${stm}*.txt

# This will get track/intensity and observation (either conventional or satellite) data - no graphics produced - for that you need to run the verification capability!
if [ "${initgraphics}" -eq 1 ]
then
matlab -nosplash -nodesktop -r "identbatch=0;identda=0;identgraphics=1;identsynoptic=0;identsynopticrt=0;identsynopticav=0;identstorm=0;identstormrt=0;identstormav=0;identgraphicsstorm=0;identgraphicssynoptic=0;identshear=0;" < ${scriptspath}/rungrb.m > ${outputpath}/OUTPUT_${stm}_TRKINT.txt &
fi
wait

# Creates DA Graphics
if [ "${initda}" -eq 1 ]
then
sbatch ${scriptspath}/matlabdagraphics.ksh $scriptspath $outputpath $homepath
fi

# Submits SYNOPTIC scripts
sbatch ${scriptspath}/matlabsynopticgraphics.ksh $scriptspath $outputpath $homepath

# Submits STORM scripts
sbatch ${scriptspath}/matlabstormgraphics.ksh $scriptspath $outputpath $homepath

exit 0

