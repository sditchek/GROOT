#!/bin/ksh
#SBATCH -t 08:00:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-hafs1        # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p hera	    # XXXX: Partition | keep it hera
#SBATCH --ntasks=1 	    # XXXX: tasks
#SBATCH --exclusive         # XXXX: allocate entire node for memory-heavy process
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
cp caseverif.txt ${scriptspath}/
source ./caseverif.txt

# Remove slurm
#rm -f ${homepath}/GROOT/GROOT-G/slurm*

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

	# INDIVIDUAL TCS
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
		if [ "${initcasestudy}" -eq 1 ]
		then
			echo This is a case study so no need to start the composite section of GROOT...
		        sbatch ${scriptspath}/matlabverifcompositefin.ksh $scriptspath $outputpath $homepath
		else
		
			echo Starting the composite section of GROOT ...	
                	sbatch ${scriptspath}/matlabverifcomposite.ksh $scriptspath $outputpath $homepath
		fi
	fi

fi

exit 0
