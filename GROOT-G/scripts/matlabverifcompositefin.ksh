#!/bin/ksh
#SBATCH -t 00:30:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-osse        # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p hera	    # XXXX: Partition | keep it hera
#SBATCH --ntasks=1	    # XXXX: tasks 
#SBATCH --mail-type=fail    # XXXX: Email Type | NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov # XXXX: Email | Use your email
#SBATCH -J VERIFCOMPCONVSAT # XXXX: Job Name | change to whatever you'd like

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
cp caseverif.txt ${scriptspath}/
source ./caseverif.txt

# FINISH COMPOSITE TCS
if [ "${initcasestudy}" -eq 1 ]
then
        echo Cleaning up now since this is a case study...
else
	matlab -nosplash -nodesktop -r "identindivstorm=0;identcomposite=1;identcompositeprep=0;identcompositerun=0;identcompositefin=1;" < ${scriptspath}/runverif.m > ${outputpath}/OUTPUT_VERIF_COMPOSITE.txt &
	wait
fi

# Clean up old files
rm -f ${scriptspath}/matlabverifbatch_*.ksh
rm -f ${scriptspath}/matlabverifcompbatch_*.ksh
rm -f ${scriptspath}/commonverif.txt
rm -f ${scriptspath}/common.txt
rm -f ${scriptspath}/compverif.txt
rm -f ${homepath}/GROOT/GROOT-G/com*.txt
rm -f ${homepath}/GROOT/GROOT-G/*.mat

sbatch ${scriptspath}/matlabveriffinished.ksh ${homepath} ${scriptspath}

exit 0
