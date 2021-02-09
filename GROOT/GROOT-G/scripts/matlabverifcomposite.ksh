#!/bin/ksh
#SBATCH -t 08:00:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-osse        # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p bigmem	    # XXXX: Partition | keep it bigmem
#SBATCH --ntasks=40	    # XXXX: maximum of 1 task / node
#SBATCH --mail-type=fail    # XXXX: Email Type | NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov # XXXX: Email | Use your email
#SBATCH -J VERIFCOMP	    # XXXX: Job Name | change to whatever you'd like

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
cp commonverif.txt ${scriptspath}/
source ./commonverif.txt

# COMPOSITE STORMS
matlab -nosplash -nodesktop -r "identindivstorm=0;identcomposite=1;" < ${scriptspath}/runverif.m > ${outputpath}/OUTPUT_VERIF_COMPOSITE.txt &
wait

# Clean up old files
rm -f ${scriptspath}/matlabverifbatch_*.ksh
rm -f ${scriptspath}/commonverif.txt
rm -f ${scriptspath}/common.txt
rm -f ${homepath}/GROOT/GROOT-G/startverif.mat
rm -f ${homepath}/GROOT/GROOT-G/indivparams.mat
rm -f ${homepath}/GROOT/GROOT-G/common.txt
rm -f ${homepath}/GROOT/GROOT-G/commonverif.txt

sbatch ${scriptspath}/matlabveriffinished.ksh ${homepath}

exit 0
