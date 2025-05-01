#!/run/current-system/sw/bin/bash

# This script copies the configuration files from /etc/nixbook-tile/config``
cp -Rv /etc/nixbook-tile/config/config/* ~/.config/
# copy the local dir to ~/.local
cp -Rv /etc/nixbook-tile/config/local/* ~/.local/

# copy zshrc and p10k.zsh to HOME directory
cp /etc/nixbook-tile/config/zshrc ~/.zshrc

cp /etc/nixbook-tile/config/p10k.zsh ~/.p10k.zsh

