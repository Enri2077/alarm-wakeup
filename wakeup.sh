#!/bin/bash

case $# in
	0)
		#amixer -D pulse sset Master 30% on;
		#espeak "Insert wake up hour or press ENTER to set 5:00."
		read -p "Insert wake up hour or press ENTER to set 5:00 " paramSveglia
		if [[ ! $paramSveglia ]]; then
    		paramSveglia="5:00";
		fi
		
		#espeak "Wake up hour set to $paramSveglia."

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

#amixer -D pulse sset Master 30% on;

echo
echo "Parameters: wakeup time = \"$sveglia\", audio master volume = "$volume
echo
echo "The system will suspend to ACPI S3 and wakeup at "$(date -d "$sveglia")"."

#espeak "The system will suspend and wakeup $sveglia. Press ENTER to confirm"

read -p "Press ENTER to confirm";

#(alarm-clock-applet & disown)

if [[ $(pidof alarm-clock-applet) ]]; then
	amixer -D pulse sset Master $volume on;
	sudo rtcwake -s $(($(date -d "$sveglia" +%s)-$(date +%s))) -m mem;	
	echo "Finished waking up at "$(date);
else
	echo "Abort: alarm-clock-applet not running."
fi



