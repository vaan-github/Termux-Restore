#!/usr/bin/env bash

# Create a temporary script file
TMP_SCRIPT=$(mktemp)

# Write all the commands to the temporary script file
cat << 'EOF' > $TMP_SCRIPT
#!/usr/bin/env bash

termux-change-repo
pkg install root-repo -y
pkg install x11-repo -y
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt --fix-broken install -y
apt autoremove -y
apt autoclean
pkg install python -y
pip install virtualenv
python -m venv ~/venv
source ~/venv/bin/activate
python -m pip install --upgrade pip
pkg install nodejs -y
apt install git curl wget -y
cd ~/
git clone https://github.com/Ja7ad/W3Schools
mkdir -p ~/.shortcuts
cd ~/.shortcuts
echo 'clear && cd ~/W3Schools && termux-open-url http://localhost:8080 && python -m http.server 8080 && clear && exit 0' > w3school.sh
chmod +x w3school.sh
cd ~/
cd ../usr/etc/profile.d
echo '#!/bin/bash

## ALIASES
alias activate="source ~/venv/bin/activate"
alias update="apt update && apt upgrade -y && apt dist-upgrade -y && apt --fix-broken install && apt autoremove -y && apt autoclean"
alias w3s="clear && cd ~/W3Schools && termux-open-url http://localhost:8080 && python -m http.server 8080 && clear && exit 0"
alias aFile="cd ~/../usr/etc/profile.d && nano startup.sh && clear && echo '\''Alias File Closed'\''"

## IN CONSOLE
echo "python: (activate), W3School: (w3s), full-update: (update), Aliases:(aFile)"
' > startup.sh
chmod +x startup.sh
bash -c "$(curl -fsSL https://git.io/Jei6P)"
cd ~/
EOF

# Make the temporary script executable
chmod +x $TMP_SCRIPT

# Execute the temporary script
$TMP_SCRIPT

# Clean up the temporary script
rm -f $TMP_SCRIPT