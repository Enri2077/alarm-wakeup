#!/bin/bash

case $# in
	0)
		echo "Needs arguments: HH:MM (wakeup time) [70% (audio volume set when woke up)]"
		exit 1;;
	1)
		volume="70%";;
	2)
		volume=$2;;
esac


if test $(date -d "$1" +%s) -gt $(date +%s); then
	sveglia=$1
else
	sveglia="tomorrow "$1
fi


echo
echo "Interpreted input: \""$sveglia"\", set audio master volume to "$volume
echo
echo "The system will suspend to ACPI S3 and wakeup at ~ "$(date -d "$sveglia")
echo

read -p "Continue? [y/*] " y
    case $y in
        [Yy] )
        	amixer -D pulse sset Master $volume on;
        	sudo rtcwake -t $(date -d "$sveglia" +%s) -m mem &> /dev/null;;
        * )
        	echo "Abort.";;
    esac

sudo rtcwake -m show

echo "Waked up at "$(date)

