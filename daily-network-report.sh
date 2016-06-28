#!/bin/bash

# First argument is the email to which we will send to reports
TO_EMAIL=$1

{ echo "<html><H1>Bandwidth Usage Report:</H1><pre>" ; vnstat ; echo "</pre><H1>Logwatch Report:</H1></html>" ; /usr/sbin/logwatch --output stdout --format html --detail high ; } \
| mail -s "Daily Stats" -a "Content-Type: text/html; From: daily-network-reports@christianbeland.com" $TO_EMAIL

