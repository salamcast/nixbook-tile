#!/run/current-system/sw/bin/bash
if [ $# -eq 1 ]
then
    email=$1
else
    echo 
    echo "you need to provide your email for SSH key"
    echo
    echo "> $0 <email>"
    echo
    exit 1
fi

mkdir ~/.ssh 2>/dev/null
ssh-keygen -t ed25519 -C "$email"