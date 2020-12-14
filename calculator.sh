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
	echo $SUM
	exit
fi

#MAIN
echo "=========================== Time Calculator ==========================="
read -p "Enter Title: " _TITLE
FILE="stash/$(whoami)_${_TITLE}_$(date +'%m-%d-%y_%T').txt"
while true
do
	read -p "Enter Hours: " _HOURS
	if [ "${_HOURS}" -lt 0 ]
	then
		break
	fi
	read -p "Enter Minutes: " _MINUTES
	if [ "${_MINUTES}" -lt 0 ]
	then
		break
	fi
	read -p "Enter Seconds: " _SECONDS
	if [ "${_SECONDS}" -lt 0 ]
	then
		break
	fi

	TOTALSECONDS="$(( ((_HOURS * 3600) + (_MINUTES * 60)) + _SECONDS ))"
	echo "${TOTALSECONDS}" >> "${FILE}"
done
