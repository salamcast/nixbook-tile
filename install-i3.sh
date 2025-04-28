echo "This will delete ALL local files and convert this machine to a Nixbook-tile!";
read -p "Do you want to continue? (y/n): " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
  echo "Installing i3 NixBook-tile..."

  # Set up local files
  rm -rf ~/
  source ./bin/setup_home.sh

  # The rest of the install should be hands off
  # Add Nixbook config and rebuild
  sudo sed -i '/hardware-configuration\.nix/a\      /etc/nixbook-tile/base-i3.nix' /etc/nixos/configuration.nix


  
  # Set up flathub repo while we have sudo
 # nix-shell -p flatpak --run 'sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo'

  sudo nixos-rebuild switch

#  source ./bin/setup_flatpak.sh
  
  sudo usermod -a -G docker $(whoami)

  reboot
else
  echo "Nixbook-tile Install Cancelled!"
fi
