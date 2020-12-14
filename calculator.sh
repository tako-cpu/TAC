#! /usr/bin/bash
#AUTHOR: John Rhey Damian
#DESCRIPTION: A time aggregator and calculator for courses watch time

#Check if 'stash' directory exists
if [ ! -d "stash" ]
then
	mkdir "stash"
fi

#Check if there are arguments
if [ "$#" -ne 0 ]
then
	echo "Your file to be opened: '$1'"
	SUM=$(awk '{SUM+=$1} END {print SUM}' "$1")
	echo "Your Total Hours: $(( SUM / 3600 ))"
	echo "Your Total Seconds: ${SUM}"
	exit
fi

#MAIN
echo "=========================== Time Calculator ==========================="
read -p "Enter Title: " _TITLE
FILE="stash/$(whoami)_${_TITLE}_$(date +'%m-%d-%y_%T').txt"
COUNTER=0
while true
do
	COUNTER=$(( COUNTER + 1 ))
	echo "#${COUNTER}:"
	read -p "     Enter Hours (Enter '-1' to exit): " _HOURS
	if [ "${_HOURS}" -lt 0 ]
	then
		break
	fi
	read -p "     Enter Minutes (Enter '-1' to exit): " _MINUTES
	if [ "${_MINUTES}" -lt 0 ]
	then
		break
	fi
	read -p "     Enter Seconds (Enter '-1' to exit): " _SECONDS
	if [ "${_SECONDS}" -lt 0 ]
	then
		break
	fi

	TOTALSECONDS="$(( ((_HOURS * 3600) + (_MINUTES * 60)) + _SECONDS ))"
	echo "${TOTALSECONDS}" >> "${FILE}"
done
