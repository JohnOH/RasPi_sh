#!/bin/bash
args=("$@")	# Assign to array
let "t=${args[0]}"
if [ -f /tmp/avgOutside ] ;
	then
		read ts lastAvg r1 r2 r3 r4 r5 r6 r7 r8 r9 overflow < /tmp/avgOutside
	else
		let "ts=0"
		let "lastAvg = 0"
		let "r1=r2=r3=r4=r5=r6=r7=r8=r9=$t"
fi
printf -v now '%(%s)T' -2	# Epoc when shell started
if (( $now > $ts+59 )); then	# Max one sample per minute
	let "Avg=$t+$r1+$r2+$r3+$r4+$r5+$r6+$r7+$r8+$r9+5"
	let "Avg=$Avg/10"
	if [ "$lastAvg" -ne "$Avg" ]; then
		echo `date "+%d/%m/%Y %X"` $@ $Avg >> /etc/heyu/Outside.txt
		echo "$now $Avg $Avg $Avg $Avg $Avg $Avg $Avg $Avg $Avg $Avg $Avg" > /tmp/avgOutside
		echo "$now $Avg $t $r1 $r2 $r3 $r4 $r5 $r6 $r7 $r8 $r9" >> /tmp/DEBUGavgOutside
		if [ "$Avg" -gt "17" ]; then
			echo -e  "17,151p" > /tmp/RFxSerial.input
		elif [ "$Avg" -eq "17" ]; then
			echo -e  "17,152p" > /tmp/RFxSerial.input
		elif [ "$Avg" -eq "16" ]; then
			echo -e  "17,155p" > /tmp/RFxSerial.input
		elif [ "$Avg" -eq "15" ]; then
			echo -e  "17,156p" > /tmp/RFxSerial.input
		elif [ "$Avg" -eq "14" ]; then
			echo -e  "17,157p" > /tmp/RFxSerial.input
		elif [ "$Avg" -eq "13" ]; then
			echo -e  "17,158p" > /tmp/RFxSerial.input
		elif [ "$Avg" -eq "12" ]; then
			echo -e  "17,159p" > /tmp/RFxSerial.input
		elif [ "$Avg" -eq "11" ]; then
			echo -e  "17,160p" > /tmp/RFxSerial.input
		elif [ "$Avg" -eq "10" ]; then
			echo -e  "17,161p" > /tmp/RFxSerial.input
		elif [ "$Avg" -eq "9" ]; then
			echo -e  "17,162p" > /tmp/RFxSerial.input
		elif [ "$Avg" -eq "8" ]; then
			echo -e  "17,163p" > /tmp/RFxSerial.input
		elif [ "$Avg" -eq "7" ]; then	# -4
			echo -e  "17,164p" > /tmp/RFxSerial.input
		elif [ "$Avg" -lt "6" ]; then
			echo -e  "17,165p" > /tmp/RFxSerial.input
		fi
	else
		echo "$now $Avg $t $r1 $r2 $r3 $r4 $r5 $r6 $r7 $r8 $r9" > /tmp/avgOutside
	fi
fi
#