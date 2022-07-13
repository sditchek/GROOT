#!/bin/ksh
#SBATCH -t 00:30:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-osse        # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p hera	    # XXXX: Partition | keep it hera
#SBATCH --ntasks=1	    # XXXX: tasks 
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

# PREP COMPOSITE STORMS
matlab -nosplash -nodesktop -r "identindivstorm=0;identcomposite=1;identcompositeprep=1;identcompositerun=0;identcompositefin=0;" < ${scriptspath}/runverif.m > ${outputpath}/OUTPUT_VERIF_COMPOSITE.txt &
wait

# Import the values in the output file
cp compverif.txt ${scriptspath}/
cp stratverif*.txt ${scriptspath}/
source ./compverif.txt

# Create copies of matlab*composite based on the number of storms in the sample
typeset -a arr
cnti=0
for i in $initbasins; do
	echo i=$i
	source ./stratverif_${i}.txt
	cntj=0
	for j in $initstrat; do
		echo j=$j
		cp ${scriptspath}/matlabverifcompbatch.ksh ${scriptspath}/matlabverifcompbatch_${cnti}_${cntj}.ksh
		cntj=`expr ${cntj} + 1`
	done
	arr[${cnti}]=${i}
	cnti=`expr ${cnti} + 1`
done
wait
sbatch ${scriptspath}/matlabverifcompbatch_0_0.ksh 0 $scriptspath $outputpath $homepath 0

exit 0
