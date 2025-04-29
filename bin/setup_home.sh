#  mkdir ~/Desktop
  mkdir ~/Documents
  mkdir ~/Downloads
  mkdir ~/Pictures
  mkdir ~/Videos
  mkdir ~/.local
  mkdir ~/.local/share
  mkdir ~/.config
  cp -R /etc/nixbook-tile/config/config/* ~/.config/


  # copy zshrc and p10k.zsh to HOME directory
  cp /etc/nixbook-tile/config/zshrc ~/.zshrc

  cp /etc/nixbook-tile/config/p10k.zsh ~/.p10k.zsh