#!/bin/ksh
#SBATCH -t 00:01:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-osse        # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p hera	    # XXXX: Partition | keep it hera
#SBATCH --ntasks=1	    # XXXX: tasks 
#SBATCH --mail-type=end     # XXXX: Email Type | NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov # XXXX: Email | Use your email
#SBATCH -J GROOT-G-DONE     # XXXX: Job Name | change to whatever you'd like


##########################
# START OF USER SETTINGS #
##########################

# NOTHING TO EDIT HERE :)

########################
# END OF USER SETTINGS #
########################

homepath=$1
scriptspath=$2

# Import the values in the output file
cp caseverif.txt ${scriptspath}/
source ./caseverif.txt

if [ "${initcasestudy}" -eq 1 ]
then
	echo This is a case study so 1. moving the TC directory outside of the VERIFICATION/ folder and 2. making a copy of files typically produced for this TC when not a case study in the VERIFICATION/ folder...
	mv ${initpath}/TRACKINT/ ${initend}/${initcasetcname}/
	mkdir -p ${initpath}/TRACKINT/FULL/
	cp ${initend}/${initcasetcname}/*.mat ${initpath}
	cp ${initend}/${initcasetcname}/TRACKINT/*track* ${initpath}/TRACKINT/
        cp ${initend}/${initcasetcname}/TRACKINT/*convcomp* ${initpath}/TRACKINT/
fi

echo "Thank you for using GROOT! Check out your results in the ${homepath}GROOT/GROOT-G/RESULTS/ directory. If you have any questions, please contact Sarah Ditchek (CIMAS-AOML)." > ${homepath}/GROOT/GROOT-G/SUBMISSION_FINISHED.txt

#rm -f ${homepath}/GROOT/GROOT-G/slurm*
rm -f ${homepath}/GROOT/GROOT-G/caseverif.txt
rm -f ${homepath}/GROOT/GROOT-G/scripts/caseverif.txt
rm -f ${homepath}/GROOT/GROOT-G/stratverif_*.txt
rm -f ${homepath}/GROOT/GROOT-G/scripts/stratverif_*.txt

exit 0
