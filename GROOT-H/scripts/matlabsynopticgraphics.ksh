#!/bin/ksh
#SBATCH -t 00:10:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-hafs1            # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p hera	    # XXXX: Partition | keep it hera
#SBATCH --ntasks=1	    # XXXX: tasks 
#SBATCH --exclusive         # XXXX: memory
#SBATCH --mail-type=fail     # XXXX: Email Type | NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov # XXXX: Email | Use your email
#SBATCH -J SYNGRAPH	    # XXXX: Job Name | change to whatever you'd like

###########################################################################
# This script runs all required files for cycles specified in editgrb.m #
###########################################################################

##########################
# START OF USER SETTINGS #
##########################

# NOTHING TO EDIT HERE :)

########################
# END OF USER SETTINGS #
########################

# Paths
scriptspath=$1
outputpath=$2
homepath=$3

# Import the values in the output file
cp common.txt ${scriptspath}/
source ./common.txt

# Clean up old files
rm -f ${outputpath}/OUTPUT_SYNOPTIC_GRAPHICS_${stm}*.txt

# Create copies of matlab*batch based on the number of cycles the user selected and submit the first cycle to generate 1) mat files and 2) graphics
typeset -a arr
cnt=0
for i in $cycles; do
cp ${scriptspath}/matlabsynopticbatch.ksh ${scriptspath}/matlabsynopticbatch_${cnt}.ksh
arr[${cnt}]=${i}
cnt=`expr ${cnt} + 1`
done
wait
sbatch ${scriptspath}/matlabsynopticbatch_0.ksh 0 $scriptspath $outputpath $homepath
exit 0
