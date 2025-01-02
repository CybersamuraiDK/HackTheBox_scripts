
#!/bin/bash
#A SCRIPT FOR SETTTING UP KRB5 FOR ACTIVE DIRECTORY MACHINES

# Prompt the user for the realm name
read -p "Enter the realm name (e.g., ghost.htb): " realm_name

# Convert to uppercase for the REALM configuration
realm_upper=$(echo "$realm_name" | tr '[:lower:]' '[:upper:]')

# Define the Kerberos configuration content
new_krb5_config="[libdefaults]
default_realm = $realm_name
dns_lookup_kdc = true
dns_lookup_realm = false

[realms]
$realm_upper = {
    kdc = dc01.$realm_name
}"

# Check if /etc/krb5.conf already exists
if [ -f /etc/krb5.conf ]; then
    echo "/etc/krb5.conf already exists. Comparing configurations..."

    # Compare the current configuration with the new one
    if echo "$new_krb5_config" | cmp -s - /etc/krb5.conf; then
        echo "The existing /etc/krb5.conf is already up-to-date."
    else
        echo "The existing /etc/krb5.conf differs. Replacing it with the new configuration..."
        sudo rm /etc/krb5.conf
        echo "$new_krb5_config" | sudo tee /etc/krb5.conf > /dev/null
        echo "New configuration created."
    fi
else
    echo "No /etc/krb5.conf file found. Creating a new one..."
    echo "$new_krb5_config" | sudo tee /etc/krb5.conf > /dev/null
    echo "New configuration created."
fi

# Confirmation message
echo "Kerberos configuration completed successfully."
echo "Realm: $realm_name"
cat /etc/krb5.conf
