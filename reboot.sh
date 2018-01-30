#!/bin/bash
#
cd /etc/heyu
killall RFxConsole
nohup ./restart.sh >> /tmp/RFxConsole.txt 2>&1 &
#
/usr/bin/tail -n1 /etc/heyu/GasMeter > /tmp/GasMeter               # /tmp is a ram disk on RPi
read date time meter jeecount  < /tmp/GasMeter
echo $meter 0 > /tmp/Min5Gas
echo "System Startup on `date`"  > /tmp/receive.txt
#
df -h > /tmp/mail_report.log
free -m >> /tmp/mail_report.log
/usr/sbin/ssmtp itaide@googlemail.com << EOF
To: John O'Hare <itaide@googlemail.com>
Date: `date`
From: RasPi1-2 <raspi1-2@it-aide.net>
Subject: Raspberry Pi #1-2 Startup on `date -R`: reboot.sh
Body:
------------------------
`cat /tmp/mail_report.log`
------------------------

EOF
#
