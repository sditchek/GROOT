#!/bin/ksh
#SBATCH -t 04:00:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-osse            # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p bigmem	    # XXXX: Partition | keep it bigmem
#SBATCH --ntasks=1	    # XXXX: maximum of 1 task / node
#SBATCH --mail-type=fail     # XXXX: Email Type | NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov # XXXX: Email | Use your email
#SBATCH -J HWDA		    # XXXX: Job Name | change to whatever you'd like

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
rm -f ${outputpath}/OUTPUT_DA_GRAPHICS_${stm}*.txt

# Run parallelized loop to create .mat files for various variables
if [ "${initda}" -eq 1 ]
then
typeset -a arr
cnt=0
for i in $cycles; do
cp ${scriptspath}/matlabdabatch.ksh ${scriptspath}/matlabdabatch_${cnt}.ksh
arr[${cnt}]=${i}
cnt=`expr ${cnt} + 1`
done
wait
sbatch ${scriptspath}/matlabdabatch_0.ksh 0 $scriptspath $outputpath $homepath
fi
exit 0
