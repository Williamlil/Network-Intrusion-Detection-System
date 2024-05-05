#!/bin/bash

# Defining variables
LOGFILE="/var/log/nids_project.log"  # This sets the path where log file will be stored (any detected suspicious avtivity will be logged here)
INTERFACE="eth0"  # This specifies the network interface that should be monitored
CAPTURE_DURATION="60"  # duration in seconds
THRESHOLD="100"  # Threshold for alerts

# Ensure whether it is running as root or not
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Function to check for unusual activity 
# (If too many requests from a single IP then it considered as suspicious)
check_suspicious_activity() {
    echo "Checking for unusual activity..."
    tcpdump -i $INTERFACE -nn -c 1000 -G $CAPTURE_DURATION -w /tmp/capture.pcap > /dev/null 2>&1
    local ips=$(tcpdump -nn -r /tmp/capture.pcap | grep IP | cut -d" " -f3 | cut -d"." -f1-4 | sort | uniq -c | sort -nr)
    
    echo "$ips" | while read count ip; do
        if [ "$count" -gt $THRESHOLD ]; then
            echo "$(date) - High traffic from $ip: $count requests" >> $LOGFILE
        fi
    done
}

# Main loop
while true; do
    check_suspicious_activity
    sleep 10
done
