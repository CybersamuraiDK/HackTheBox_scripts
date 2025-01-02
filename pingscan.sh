#!/bin/bash
#Ip-range PING scan of a subnet

# Function to handle Ctrl + C (SIGINT)
handle_interrupt() {
    echo -e "\n[INFO] Script interrupted. Exiting gracefully..."
    exit 1
}

# Trap SIGINT (Ctrl + C) and call the interrupt handler
trap handle_interrupt SIGINT

# Function to convert CIDR to a range of IPs
cidr_to_ips() {
    local cidr=$1
    # Extract the base IP and subnet mask
    local base_ip=$(echo "$cidr" | cut -d'/' -f1)
    local mask=$(echo "$cidr" | cut -d'/' -f2)

    # Validate CIDR format
    if [[ ! $base_ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] || [[ ! $mask =~ ^[0-9]+$ ]]; then
        echo "Invalid CIDR format. Please use something like 192.168.0.0/24."
        exit 1
    fi

    # Calculate number of hosts
    local num_hosts=$((2 ** (32 - mask)))

    # Convert base IP to an integer
    local IFS=.
    local ip_array=($base_ip)
    local ip_int=$(( (ip_array[0] << 24) + (ip_array[1] << 16) + (ip_array[2] << 8) + ip_array[3] ))

    # Generate all IPs in the range
    for ((i = 1; i < num_hosts - 1; i++)); do
        local current_ip=$((ip_int + i))
        printf "%d.%d.%d.%d\n" $(( (current_ip >> 24) & 255 )) $(( (current_ip >> 16) & 255 )) $(( (current_ip >> 8) & 255 )) $(( current_ip & 255 ))
    done
}

# Prompt user for CIDR input
read -p "Enter the subnet in CIDR notation (e.g., 192.168.0.0/24): " CIDR

# Validate the CIDR and generate IPs
echo "Pinging all hosts in $CIDR..."
for ip in $(cidr_to_ips "$CIDR"); do
    # Ping each IP and check if it responds
    if ping -c 1 -W 1 "$ip" &> /dev/null; then
        echo "Host $ip is reachable"
    else
        echo "Host $ip is not reachable"
    fi
done
