#!/bin/bash

TO_MAIL=$1

sudo debconf-set-selections <<< "postfix postfix/mailname string christianbeland.com"
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"

sudo apt-get update
sudo apt-get install -y logwatch vnstat mailutils

# making sure script is executable
sudo chmod +x daily-network-report.sh

sudo rm /usr/local/bin/daily-network-report.sh
sudo ln -s $PWD/daily-network-report.sh /usr/local/bin/daily-network-report.sh

# Create cron job file to schedule reporting
echo "00 11 * * * daily-network-report.sh ${TO_MAIL}" > daily.cron

echo 'Scheduling daily reports cron job'
crontab daily.cron

echo 'Producing initial reports'
./daily-network-report.sh $TO_MAIL
