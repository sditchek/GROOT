#!/bin/ksh
#SBATCH -t 02:00:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-osse        # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p bigmem	    # XXXX: Partition | keep it bigmem
#SBATCH --ntasks=40 	    # XXXX: maximum of 40 cores(tasks) / 1 node
#SBATCH --mail-type=fail    # XXXX: Email Type | NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov # XXXX: Email | Use your email
#SBATCH -J VERIFSTM	    # XXXX: Job Name | change to whatever you'd like

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
scriptspath=$2
outputpath=$3
homepath=$4

# Import the values in the output file
cp commonverif.txt ${scriptspath}/
source ./commonverif.txt

# Remove slurm
rm -f ${homepath}/slurm*

# Find how many cycles were selected
typeset -a arr
cnt=0
for i in $initstormsdone; do
arr[${cnt}]=${i}
cnt=`expr ${cnt} + 1`
done
wait
numcyc=$1
lencyc=${#arr[@]}


if [ $numcyc -lt $lencyc ] 
then
	numarr=${arr[$numcyc]}
	#echo $numcyc 
	#echo ${arr[$numcyc]}
	echo Starting storm number ${numarr} ...

	# INDIVIDUAL STORMS
	matlab -nosplash -nodesktop -r "identstormsdone=${numarr};identindivstorm=1;identcomposite=0;" < ${scriptspath}/runverif.m > ${outputpath}/OUTPUT_VERIF_${numarr}.txt &
	wait
	
	numcyc=`expr $numcyc + 1`
	
	if [ $numcyc -lt $lencyc ]
	then
		sbatch ${scriptspath}/matlabverifbatch_$numcyc.ksh $numcyc $scriptspath $outputpath $homepath
	else
		#echo $numcyc
	        #echo ${arr[$numcyc]}
	        #echo ${numarr}
		echo Starting the composite section of GROOT ...
		
                sbatch ${scriptspath}/matlabverifcomposite.ksh $scriptspath $outputpath $homepath
	fi

fi

exit 0
