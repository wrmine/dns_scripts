#!/bin/bash
#
# Script for creating backup zone files based on serial number.

Zone=$1
TTY=`tty`
#Nam=`logname`

# Test for command line options
if [ -z $1 ]; then
 printf "Your tty is $TTY \n";
#
# Start input
#
 printf "What is the Zone file name?\n";
 read Zone < $TTY;
fi
if [ -n $Zone ]; then
 Serl=`awk '/serial/ {print $1}' $Zone`
 cp $Zone $Zone.$Serl
 printf "Created backup $Zone.$Serl \n"
else
printf "$Zone not right\n"
fi

