#!/bin/bash
# This script is executed every time your instance is spawned. I use d this im my PWNBOX instance

# 1. Create a folder on the desktop named TOOLS
DESKTOP_PATH="$HOME/Desktop"
TOOLS_FOLDER="$DESKTOP_PATH/TOOLS"

echo "Creating TOOLS folder on the desktop..."
mkdir -p "$TOOLS_FOLDER"

# 2. Navigate into the TOOLS folder
cd "$TOOLS_FOLDER" || exit
echo "Moved into TOOLS folder."

# 3. Execute commands one at a time
echo "Downloading tools..."
wget https://github.com/nicocha30/ligolo-ng/releases/download/v0.7.3/ligolo-ng_proxy_0.7.3_linux_amd64.tar.gz
wget https://github.com/nicocha30/ligolo-ng/releases/download/v0.7.3/ligolo-ng_agent_0.7.3_linux_amd64.tar.gz
wget https://github.com/nicocha30/ligolo-ng/releases/download/v0.7.3/ligolo-ng_agent_0.7.3_windows_amd64.zip
wget https://github.com/liamg/traitor/releases/download/v0.0.14/traitor-386
wget https://github.com/AlessandroZ/LaZagne/releases/download/v2.4.6/LaZagne.exe
wget https://github.com/ParrotSec/mimikatz/blob/master/Win32/mimikatz.exe
wget https://github.com/ParrotSec/mimikatz/blob/master/x64/mimikatz.exe -O mimikatz64.exe
wget https://github.com/PowershellMafia/Powersploit/blob/master/Exfiltration/Invoke-Mimikatz.ps1
wget https://github.com/ropnop/kerbrute/releases/download/v1.0.3/kerbrute_linux_amd64
wget https://github.com/peass-ng/PEASS-ng/releases/download/20241222-e17c35a2/linpeas.sh

# 4. Extract downloaded Ligolo files
echo "Extracting Ligolo files..."
tar -xzvf ligolo-ng_proxy_0.7.3_linux_amd64.tar.gz
tar -xzvf ligolo-ng_agent_0.7.3_linux_amd64.tar.gz
unzip ligolo-ng_agent_0.7.3_windows_amd64.zip
rm ligolo-ng_proxy_0.7.3_linux_amd64.tar.gz
rm ligolo-ng_agent_0.7.3_linux_amd64.tar.gz
rm ligolo-ng_agent_0.7.3_windows_amd64.zip
rm LICENSE
rm README.md 

# 5. Install Python tools
echo "Installing Python tools..."
pip install pwncat-cs
pipx install git+https://github.com/CravateRouge/bloodyAD

# 6. install kerberoast klist
# Pre-set Kerberos default realm 
echo "krb5-config krb5-config/default_realm string GHOST.HTB" | sudo debconf-set-selections 

# Install krb5-user non-interactively 
sudo DEBIAN_FRONTEND=noninteractive apt install krb5-user -y

sudo apt install dirsearch -y

echo "Setup complete."
