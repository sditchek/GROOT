#!/bin/ksh
#SBATCH -t 08:00:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-hafs1        # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p hera	    # XXXX: Partition | keep it hera
#SBATCH --ntasks=1 	    # XXXX: tasks 
#SBATCH --exclusive         # XXXX: memory
#SBATCH --mail-type=fail    # XXXX: Email Type | NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov # XXXX: Email | Use your email
#SBATCH -J STMVAR	    # XXXX: Job Name | change to whatever you'd like

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
scriptspath=$3
outputpath=$4
homepath=$5
numcyc=$6
numarrc=$7
lencyc=$8

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

# Find how many experiments were selected
typeset -a arrexp
cntexp=0
for i in $exp; do
arrexp[${cntexp}]=${i}
cntexp=`expr ${cntexp} + 1`
done
wait
numexp=$2
lenexp=${#arrexp[@]}

# This section creates GRAPHICS if the user desires for 1 cycle - identified by the file name
if [ $numvar -lt $lenvar ] 
then
	numarrv=${arr[$numvar]}
	echo $numvar
	echo ${arr[$numvar]}
	echo ${numarrv}

	if [ $numexp -lt $lenexp ]
        then
                numarre=${arrexp[$numexp]}
                echo $numexp
                echo ${arrexp[$numexp]}
                echo ${numarre}

		# Run  parallelized loop to create GRAPHICS for various variables
		if [ "${initgraphicsstorm}" -eq 1 ]
		then
			matlab -nosplash -nodesktop -r "identbatch=${numarrc};identvar0=${numarrv};identvarexp0=${numarre};identda=0;identgraphics=0;identstorm=0;identsynoptic=0;identstormrt=0;identstormav=0;identsynopticrt=0;identsynopticav=0;identgraphicsstorm=${initgraphicsstorm};identgraphicssynoptic=0;identshear=0;identsynopticclean=0;identstormclean=0;" < ${scriptspath}/rungrb.m > ${outputpath}/OUTPUT_STORM_GRAPHICS_${stm}_${numarrc}_${numarrv}_${numarre}.txt &
			wait
		fi
		numexp=`expr $numexp + 1`
                if [ $numexp -lt $lenexp ]
                then
                    sbatch ${scriptspath}/matlabstormvar_${numvar}_${numexp}.ksh $numvar $numexp $scriptspath $outputpath $homepath $numcyc $numarrc
                else	
			numvar=`expr $numvar + 1`
	
			if [ $numvar -lt $lenvar ]
			then
				echo $numvar
				sbatch ${scriptspath}/matlabstormvar_${numvar}_0.ksh $numvar 0 $scriptspath $outputpath $homepath $numcyc $numarrc
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
					matlab -nosplash -nodesktop -r "identbatch=${numarrc};identvar0=0;identvarexp0=0;identda=0;identgraphics=0;identstorm=0;identsynoptic=0;identstormrt=0;identstormav=0;identsynopticrt=0;identsynopticav=0;identgraphicsstorm=0;identgraphicssynoptic=0;identshear=0;identsynopticclean=0;identstormclean=1;" < ${scriptspath}/rungrb.m > ${outputpath}/OUTPUT_STORM_GRAPHICS_${stm}_${i}_CLEAN.txt &
					wait
					sbatch ${scriptspath}/matlabstormbatch_$numcyc.ksh $numcyc $scriptspath $outputpath $homepath
			
				else
					matlab -nosplash -nodesktop -r "identbatch=${numarrc};identvar0=0;identvarexp0=0;identda=0;identgraphics=0;identstorm=0;identsynoptic=0;identstormrt=0;identstormav=0;identsynopticrt=0;identsynopticav=0;identgraphicsstorm=0;identgraphicssynoptic=0;identshear=0;identsynopticclean=0;identstormclean=1;" < ${scriptspath}/rungrb.m > ${outputpath}/OUTPUT_STORM_GRAPHICS_${stm}_${i}_CLEAN.txt &
                		        wait	
					sbatch ${scriptspath}/matlabstormclean.ksh $scriptspath $homepath
				fi
			fi
		fi
	fi
fi

exit 0
