#!/bin/bash

case $# in
	0)
		paramSveglia="5:00";
		volume="70%";;
	1)
		paramSveglia=$1;
		volume="70%";;
	2)
		paramSveglia=$1;
		volume=$2;;
esac


if test $(date -d "$paramSveglia" +%s) -gt $(date +%s); then
	sveglia=$paramSveglia
else
	sveglia="tomorrow "$paramSveglia
fi

amixer -D pulse sset Master 30% on;

echo
echo "Parameters: wakeup time = \"$sveglia\", audio master volume = "$volume
echo
echo "The system will suspend to ACPI S3 and wakeup at "$(date -d "$sveglia")"."

espeak "The system will suspend and wakeup $sveglia. Press ENTER to confirm"

read -p "Press ENTER to confirm";

alarm-clock-applet &

amixer -D pulse sset Master $volume on;

sudo rtcwake -t $(date -d "$sveglia" +%s) -m mem &> /dev/null;

echo "Finished waking up at "$(date);

