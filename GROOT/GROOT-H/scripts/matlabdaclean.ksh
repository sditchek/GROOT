#!/bin/ksh
#SBATCH -t 00:30:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-osse            # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p bigmem	    # XXXX: Partition | keep it bigmem
#SBATCH --ntasks=1	    # XXXX: maximum of 1 task / node
#SBATCH --mail-type=fail     # XXXX: Email Type | NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov # XXXX: Email | Use your email
#SBATCH -J CLN		    # XXXX: Job Name | change to whatever you'd like

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

# Import the values in the output file
source ./common.txt

# Clean up old files
rm -f ${scriptspath}/matlabdabatch_*.ksh
exit 0
