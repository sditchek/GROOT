#!/bin/ksh
#SBATCH -t 02:00:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-osse        # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p bigmem	    # XXXX: Partition | keep it bigmem
#SBATCH --ntasks=40	    # XXXX: maximum of 1 task / node
#SBATCH --mail-type=end     # XXXX: Email Type | NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov # XXXX: Email | Use your email
#SBATCH -J GROOT-H-DONE     # XXXX: Job Name | change to whatever you'd like


##########################
# START OF USER SETTINGS #
##########################

# NOTHING TO EDIT HERE :)

########################
# END OF USER SETTINGS #
########################

homepath=$1

echo "Thank you for using GROOT! Check out your results in the ${homepath}/GROOT/GROOT-H/RESULTS/ directory. If you have any questions, please contact Sarah Ditchek (CIMAS-AOML)." > ${homepath}/GROOT/GROOT-H/SUBMISSION_FINISHED.txt

rm -f ${homepath}/GROOT/GROOT-H/slurm*

exit 0
