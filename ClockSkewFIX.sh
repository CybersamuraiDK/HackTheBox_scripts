#!/bin/bash
#Fixing the ClowSKET too great issue

# Function to check if ntpdate is installed
check_ntpdate_installed() {
    if ! command -v ntpdate &> /dev/null; then
        echo "ntpdate is not installed. Installing..."
        sudo apt update
        sudo apt install ntpdate -y
    else
        echo "ntpdate is already installed."
    fi
}

# Prompt the user for the IP address
get_ntp_server_ip() {
    read -p "Enter the NTP server IP address: " ntp_server_ip
}

# Main script execution
check_ntpdate_installed
get_ntp_server_ip

# Run ntpdate with the provided IP address
if [[ -n "$ntp_server_ip" ]]; then
    echo "Synchronizing time with $ntp_server_ip..."
    sudo ntpdate "$ntp_server_ip"
else
    echo "No IP address provided. Exiting."
    exit 1
fi
