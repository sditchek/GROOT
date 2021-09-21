#!/bin/ksh
#SBATCH -t 04:00:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-osse        # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p hera	    # XXXX: Partition | keep it hera
#SBATCH --ntasks=40 	    # XXXX: tasks 
#SBATCH --mail-type=fail    # XXXX: Email Type | NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov # XXXX: Email | Use your email
#SBATCH -J STMGR	    # XXXX: Job Name | change to whatever you'd like

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
numcyc=$5
numarrc=$6
lencyc=$7

# Import the values in the output file
cp common.txt ${scriptspath}/
source ./common.txt

# Find how many cycles were selected
typeset -a arr
cnt=0
for i in $stormvariables; do
arr[${cnt}]=${i}
cnt=`expr ${cnt} + 1`
done
wait
numvar=$1
lenvar=${#arr[@]}


# This section creates GRAPHICS if the user desires for 1 cycle - identified by the file name
if [ $numvar -lt $lenvar ] 
then
	numarrv=${arr[$numvar]}
	echo $numvar
	echo ${arr[$numvar]}
	echo ${numarrv}


	# Run  parallelized loop to create GRAPHICS for various variables
	if [ "${initgraphicsstorm}" -eq 1 ]
	then
	matlab -nosplash -nodesktop -r "identbatch=${numarrc};identvar0=${numarrv};identda=0;identgraphics=0;identstorm=0;identsynoptic=0;identstormrt=0;identstormav=0;identsynopticrt=0;identsynopticav=0;identgraphicsstorm=${initgraphicsstorm};identgraphicssynoptic=0;identshear=0;identsynopticclean=0;identstormclean=0;" < ${scriptspath}/rungrb.m > ${outputpath}/OUTPUT_STORM_GRAPHICS_${stm}_${numarrc}_${numarrv}.txt &
	wait
	fi

	numvar=`expr $numvar + 1`
	
	if [ $numvar -lt $lenvar ]
	then
		sbatch ${scriptspath}/matlabstormvar_$numvar.ksh $numvar $scriptspath $outputpath $homepath $numcyc $numarrc
	else
		rm ${scriptspath}/matlabstormvar_*.ksh
		numcyc=`expr $numcyc + 1`
		typeset -a arrl
		cnt=0
		for i in $cycles; do
		arrl[${cnt}]=${i}
		cnt=`expr ${cnt} + 1`
		done
		wait
		lencyc=${#arrl[@]}
		if [ $numcyc -lt $lencyc ]
		then
			matlab -nosplash -nodesktop -r "identbatch=${numarrc};identvar0=0;identda=0;identgraphics=0;identstorm=0;identsynoptic=0;identstormrt=0;identstormav=0;identsynopticrt=0;identsynopticav=0;identgraphicsstorm=0;identgraphicssynoptic=0;identshear=0;identsynopticclean=0;identstormclean=1;" < ${scriptspath}/rungrb.m > ${outputpath}/OUTPUT_STORM_GRAPHICS_${stm}_${i}_CLEAN.txt &
			wait
			sbatch ${scriptspath}/matlabstormbatch_$numcyc.ksh $numcyc $scriptspath $outputpath $homepath
			
		else
			matlab -nosplash -nodesktop -r "identbatch=${numarrc};identvar0=0;identda=0;identgraphics=0;identstorm=0;identsynoptic=0;identstormrt=0;identstormav=0;identsynopticrt=0;identsynopticav=0;identgraphicsstorm=0;identgraphicssynoptic=0;identshear=0;identsynopticclean=0;identstormclean=1;" < ${scriptspath}/rungrb.m > ${outputpath}/OUTPUT_STORM_GRAPHICS_${stm}_${i}_CLEAN.txt &
                        wait	
			sbatch ${scriptspath}/matlabstormclean.ksh $scriptspath

		fi
	fi

fi

exit 0
