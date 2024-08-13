#!/bin/ksh
#SBATCH -t 00:30:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-hafs1        # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p hera	    # XXXX: Partition | keep it hera
#SBATCH --ntasks=1	    # XXXX: tasks
#SBATCH --exclusive         # XXXX: memory
#SBATCH --mail-type=end     # XXXX: Email Type | NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov # XXXX: Email | Use your email
#SBATCH -J SYNCLEAN         # XXXX: Job Name | change to whatever you'd like

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
homepath=$2

# Import the values in the output file
source ./common.txt

echo "Thank you for using GROOT! Check out your SYNOPTIC GRID results in the ${homepath}/GROOT/GROOT-H/RESULTS/ directory. If you have any questions, please contact Sarah Ditchek (CIMAS-AOML)." > ${homepath}/SUBMISSION_SYNOPTICGRID_FINISHED.txt

# Clean up old files
rm -f ${scriptspath}/matlabsynopticbatch_*.ksh
exit 0
