#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Need an argument like \"8:30\" (with or without quotes)"
	exit 1
fi

if test $(date -d "$1" +%s) -gt $(date +%s); then
	sveglia=$1
else
	sveglia="tomorrow "$1
fi


echo
echo "Interpreted input: \""$sveglia"\""
echo
echo "The system will suspend to ACPI S3 and wakeup at ~ "$(date -d "$sveglia")
echo

read -p "Continue? [y/*] " y
    case $y in
        [Yy] ) sudo rtcwake -t $(date -d "$sveglia" +%s) -m mem &> /dev/null;;
        * ) echo "Abort.";;
    esac

sudo rtcwake -m show

echo "Waked up at "$(date)

