# Network-Intrusion-Detection-System

Step 1: Install Required Tools
# ensure tcpdump is installed, Before starting script.

     $ sudo apt update

     $ sudo apt install tcpdump -y

Step 2: Create the NIDS Script 
# Open a new file in text editor, And write the script.

     $ nano NIDS_project.sh

# write the script given in repository, Then save and close the editor.

Step 3: Make the Script Executable
# Change the permission for the script to be executable.

     $ chmod +x NIDS_project.sh

Step 4: Running the Script
# Execute the NIDS script as root.

     $ sudo ./NIDS_project.sh

# This script will continuously monitor network traffic on the specified interface (eth0) and capture the first 1000 packets every 60 seconds, and log if any single IP exceeds the threshold of 100 requests in that capture window. Logs will be written to "/var/log/nids_project.log".
