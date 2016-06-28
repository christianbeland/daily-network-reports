#!/bin/bash

TO_MAIL=$1

debconf-set-selections <<< "postfix postfix/mailname string christianbeland.com"
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"

sudo apt-get update
sudo apt-get install -y logwatch vnstat mailutils

# making sure script is executable
sudo chmod +x daily-network-report.sh

# update cron job to set email where to send reports
echo -n " ${TO_MAIL}" >> daily.cron

echo 'Scheduling daily reports cron job'
crontab daily.cron

echo 'Producing initial reports'
./daily-network-report.sh $TO_MAIL
