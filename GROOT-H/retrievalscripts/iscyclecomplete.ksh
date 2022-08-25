#!/bin/ksh
#SBATCH -t 00:10:00         # XXXX: Time Limit: generally sufficient; may need to increase it
#SBATCH -A aoml-osse        # XXXX: Account:   Use your project accounti
#SBATCH -q batch            # XXXX: quality of service
#SBATCH --partition=service # XXXX: request specific partition for resource allocation
#SBATCH --ntasks=1          # XXXX: maximum of 1 task / node
#SBATCH --mail-type=fail    # XXXX: NONE, BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=sarah.d.ditchek@noaa.gov
#SBATCH -J TAPE             # XXXX: Job Name: change
#SBATCH -o /scratch1/AOML/aoml-osse/Sarah.D.Ditchek/TAPE/archivecompcyc.log # XXXX: Output
#SBATCH -e /scratch1/AOML/aoml-osse/Sarah.D.Ditchek/TAPE/errorcompcyc.log # XXXX: Output

#######################################################################################
# This script emails the person specified under *emailme* when a new cycle completes! #
#######################################################################################

##########################
# START OF USER SETTINGS #
##########################

scrubdir=/scratch1/AOML/aoml-osse/${USER}/scrub   							# location of your scrub directory
currentdir=/scratch1/AOML/aoml-osse/${USER}/GROOT/GROOT-H/retrievalscripts	# location of where this script is stored
emailme=sarah.d.ditchek@noaa.gov										# who should be emailed when a new cycle is completed?
exp="GSYESFR GSYESCR"													# names of your experiments to check (e.g., exp="exp1 exp2 exp3")

# Enter this in your crontab, uncommented. Be sure to change the path to match your "currentdir" above - the below runs once a day at 5am Eastern
#0 9 * * * /scratch1/AOML/aoml-osse/Sarah.D.Ditchek/GROOT-H/retrievalscripts/iscyclecomplete.ksh

########################
# END OF USER SETTINGS #
########################

for var in ${exp}
do

# Point to old, new, and difference files
FILE1=${currentdir}/${var}_completedcycles_old.txt
FILE2=${currentdir}/${var}_completedcycles_new.txt
FILE3=${currentdir}/${var}_diffreport.txt

# Assign new to old, find all completion files, assign to new
if [ ! -e "${FILE1}" ]
then
   echo "" > ${FILE1}
   ls ${scrubdir}/${var}/log/*completion*.out > ${FILE2}
else
  rm ${FILE1}
  mv ${FILE2} ${FILE1}
  ls  ${scrubdir}/${var}/log/*completion*.out > ${FILE2}
fi

# Check if old and new files are same or different. 
diff ${FILE1} ${FILE2} > ${FILE3}

# Check if file has contents or not
if [ -s "${FILE3}" ]
then # the files differ - email with results
	mail -s "${var}: New Cycle Complete"  ${emailme} < ${FILE3}
fi

done

