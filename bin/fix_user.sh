  sudo usermod -a -G docker $(whoami)

  sudo usermod -s /run/current-system/sw/bin/zsh $(whoami)