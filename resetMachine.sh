#!/bin/bash
#RESET YOUR HTB ENVIROMENT AFTER MACHINE PWN

# Remove the Kerberos configuration file
if [ -f /etc/krb5.conf ]; then
    echo "Removing /etc/krb5.conf..."
    sudo rm /etc/krb5.conf
    echo "File /etc/krb5.conf removed successfully."
else
    echo "/etc/krb5.conf does not exist. Skipping."
fi

# Remove the last line containing '.htb' in /etc/hosts
if grep -q '\.htb' /etc/hosts; then
    echo "Removing the last line containing '.htb' from /etc/hosts..."
    sudo sed -i '/\.htb/{$!{h;d};x;d;}' /etc/hosts
    echo "Last line containing '.htb' removed from /etc/hosts."
else
    echo "No entries containing '.htb' found in /etc/hosts. Skipping."
fi

echo "System reset for hacking environment is complete."
