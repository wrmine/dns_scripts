#!/bin/bash

# Script for adding new NS records to Zone files
# Usage is NS-update.sh $zone-to-update
# Which can be used in a "for i in $(ls 1/*.arpa); do NS-updte.sh $i ; done

# Replacement nameservers
Ns1=ns3.example.com.
Ns2=ns4.example.com.

# Existing (index) nameserver
Indx=ns2.example.com.

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

# Check for ns existance
#
 if egrep -q "$Ns1|$Ns2" $1; then 
  printf "The zone $1 was already has $Ns1 & $Ns2 \n"
 else

# Check for $Indx in the zone
#
  if grep -q $Indx $1; then

# Check for higher serial number
#
   if [ $Ftser -gt $Ser ]; then
    printf "$1 \t old: $Ser \t New: $Ftser \n"


# Add 2x nameservers at $Indx and replace $Indx
#
     sed -i.$Ser s/"$FrmNs$Indx"/"$FrmNs$Indx\n$FrmNs$Ns1\n$FrmNs$Ns2"/ $1

# Update serial number
#
     sed -i s/"$Ser"/"$Ftser"/ $1
   else
    printf "$1 \t $Ser is equal to or greater than $Ftser \n";

    fi
   else
    printf " $1 does not have $Indx in it \n"
   fi
  fi
else
 printf "$1 does not exist \n"
fi

