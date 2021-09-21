#!/bin/ksh
#SBATCH -t 04:00:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-osse        # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p hera	    # XXXX: Partition | keep it hera
#SBATCH --ntasks=40 	    # XXXX: tasks 
#SBATCH --mail-type=fail     # XXXX: Email Type | NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov # XXXX: Email | Use your email
#SBATCH -J STMMAT	    # XXXX: Job Name | change to whatever you'd like

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
cp common.txt ${scriptspath}/
source ./common.txt

# Remove slurm
rm -f ${homepath}/slurm*

# Find how many cycles were selected
typeset -a arr
cnt=0
for i in $cycles; do
arr[${cnt}]=${i}
cnt=`expr ${cnt} + 1`
done
wait
numcyc=$1
lencyc=${#arr[@]}


if [ $numcyc -lt $lencyc ] 
then
	numarr=${arr[$numcyc]}
	echo $numcyc
	echo ${arr[$numcyc]}
	echo ${numarr}

	# Create MAT files for various variables
	if [ "${initstorm}" -eq 1 ]
	then
	#ALL VARIABLES
	matlab -nosplash -nodesktop -r "identbatch=${numarr};identda=0;identgraphics=0;identstorm=${initstorm};identsynoptic=0;identstormrt=0;identstormav=0;identsynopticrt=0;identsynopticav=0;identgraphicsstorm=0;identgraphicssynoptic=0;identshear=0;identsynopticclean=0;identstormclean=0;" < ${scriptspath}/rungrb.m > ${outputpath}/OUTPUT_STORM_${stm}_${numarr}.txt &
	wait
	#RADTAN AND RVRT
	matlab -nosplash -nodesktop -r "identbatch=${numarr};identda=0;identgraphics=0;identstorm=0;identsynoptic=0;identstormrt=1;identstormav=1;identsynopticrt=0;identsynopticav=0;identgraphicsstorm=0;identgraphicssynoptic=0;identshear=0;identsynopticclean=0;identstormclean=0;" < ${scriptspath}/rungrb.m > ${outputpath}/OUTPUT_STORM_${stm}_RADTANAV_${numarr}.txt &
	wait
	fi

	# Create copies of script based on how many variables user selected
	typeset -a arr
	cnt=0
	for i in $stormvariables; do
	cp ${scriptspath}/matlabstormvar.ksh ${scriptspath}/matlabstormvar_${cnt}.ksh
	arr[${cnt}]=${i}
	cnt=`expr ${cnt} + 1`
	done
	wait
	sbatch ${scriptspath}/matlabstormvar_0.ksh 0 $scriptspath $outputpath $homepath $numcyc $numarr $lencyc

fi

exit 0
