#!/bin/ksh
#SBATCH -t 08:00:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-osse        # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p hera	    # XXXX: Partition | keep it hera
#SBATCH --ntasks=1 	    # XXXX: tasks 
#SBATCH --mail-type=fail    # XXXX: Email Type | NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov # XXXX: Email | Use your email
#SBATCH -J VERIFCOMPSTAT    # XXXX: Job Name | change to whatever you'd like

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
cp compverif.txt ${scriptspath}/
source ./compverif.txt
cp stratverif*.txt ${scriptspath}/

# Remove slurm
#rm -f ${homepath}/GROOT/GROOT-G/slurm*

# Find how many basins were selected
typeset -a arr
cnt=0
for i in $initbasins; do
arr[${cnt}]=${i}
cnt=`expr ${cnt} + 1`
done
wait
numcyc=$1
lencyc=${#arr[@]}
source ./stratverif_${arr[$numcyc]}.txt

# Find out how many stratlists are needed
typeset -a arr2
cnt=0
for i in $initstrat; do
arr2[${cnt}]=${i}
cnt=`expr ${cnt} + 1`
done
wait
lenstrat=${#arr2[@]}
numstrat=$5

if [ $numcyc -lt $lencyc ] 
then
	numarr=${arr[$numcyc]}
	numstr=${arr2[$numstrat]}
	#echo numcyc=$numcyc
        #echo lencyc=$lencyc
        #echo numarr=${arr[$numcyc]}
        #echo numstrat=$numstrat
        #echo lenstrat=$lenstrat
        #echo numstr=${arr2[$numstrat]}
        echo Starting statistics for basin number ${numarr} and stratlist number initstrat${numstr}...
	eval con=\${initstrat$numstr}
	# INDIVIDUAL BASINS
	matlab -nosplash -nodesktop -r  "identindivstorm=0;identcomposite=1;identcompositeprep=0;identcompositerun=1;identbasins=${numarr};identcompositefin=0;identstratlist=${con};" < ${scriptspath}/runverif.m > ${outputpath}/OUTPUT_COMPVERIF_${numarr}_${numstr}.txt &
	wait
	
	if [ $numstr -lt $lenstrat ]
	then
	        numstrat=`expr $numstrat + 1`
                #echo numstrat=$numstrat
		sbatch ${scriptspath}/matlabverifcompbatch_${numcyc}_${numstrat}.ksh $numcyc $scriptspath $outputpath $homepath $numstrat
	elif [ $numarr -lt $lencyc ]
	then
		numcyc=`expr $numcyc + 1`
		#echo numcyc=${numcyc}
		sbatch ${scriptspath}/matlabverifcompbatch_${numcyc}_0.ksh $numcyc $scriptspath $outputpath $homepath 0
	else
		#echo numcyc=$numcyc
		#echo numstrat=$numstrat
	        #echo arrnumcyc=${arr[$numcyc]}
	        #echo numarr=${numarr}
		echo Starting the conventional or satellite section of GROOT ...		
                sbatch ${scriptspath}/matlabverifcompositefin.ksh $scriptspath $outputpath $homepath
	fi

fi

exit 0
