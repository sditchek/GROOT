#!/bin/ksh
#SBATCH -t 04:00:00         # XXXX: Time Limit | generally sufficient; may need to increase it
#SBATCH -A aoml-osse        # XXXX: Account |  Use your project account
#SBATCH -q batch	    # XXXX: quality of service
#SBATCH -p hera	    # XXXX: Partition | keep it hera
#SBATCH --ntasks=1 	    # XXXX: tasks 
#SBATCH --mail-type=fail     # XXXX: Email Type | NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov # XXXX: Email | Use your email
#SBATCH -J HWDA		    # XXXX: Job Name | change to whatever you'd like

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

# Find which script this is an add one
typeset -a arr
cnt=0
for i in $cycles; do
arr[${cnt}]=${i}
cnt=`expr ${cnt} + 1`
done
wait
numcyc=$1
len=${#arr[@]}


if [ $numcyc -lt $len ] 
then
numarr=${arr[$numcyc]}
echo $numcyc
echo ${arr[$numcyc]}
echo ${numarr}
##
if [ "${initda}" -eq 1 ]
then
#ALL VARIABLES
matlab -nosplash -nodesktop -r "identbatch=${numarr};identconventional=0;identsatobs=0;identda=${initda};identgraphics=0;identstorm=0;identsynoptic=0;identstormrt=0;identstormav=0;identsynopticrt=0;identsynopticav=0;identgraphicsstorm=0;identgraphicssynoptic=0;identshear=0;identsynopticclean=0;identstormclean=0;" < ${scriptspath}/rungrb.m > ${outputpath}/OUTPUT_DA_${stm}_${numarr}.txt &
wait
numcyc=`expr $numcyc + 1`
sbatch ${scriptspath}/matlabdabatch_$numcyc.ksh $numcyc $scriptspath $outputpath $homepath
fi
else
sbatch ${scriptspath}/matlabdaclean.ksh $scriptspath
fi


exit 0
