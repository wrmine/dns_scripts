#!/bin/bash
# for incrementing the serial number of a zone file
# WIP
# 
# PATH: /home/williamm/bin


Dat=$(date +%Y%m%d);
Ftser=$[Dat]00;
FrmNs='\t\t\tNS\t'

#Check for file
if [ -f $1 ] ; then

Ser=$(grep serial $1 | awk '{print $1}');

#Increment Future serial beyond existing serial
while [ $Ser -ge $Ftser ]; do
 ((Ftser++));
done

# Check for higher serial number
#
   if [ $Ftser -gt $Ser ]; then
    printf "$1 \t old: $Ser \t New: $Ftser \n"

# Update serial number
#
     sed -i s/"$Ser"/"$Ftser"/ $1
   else
    printf "$1 \t $Ser is equal to or greater than $Ftser \n";

    fi
else
 printf "$1 does not exist \n"
fi

