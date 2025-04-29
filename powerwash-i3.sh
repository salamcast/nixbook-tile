echo "This will delete ALL local files and reset this Nixbook!";
read -p "Do you want to continue? (y/n): " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
echo "Powerwashing NixBook..."

  sudo systemctl start auto-update-config.service;
  
  # Erase data and set up home directory again
  # Set up local files
  rm -rf ~/
  source ./bin/setup_home.sh

  sudo rm -r /var/lib/flatpak

  # Clear space and rebuild
  sudo nix-collect-garbage -d
  sudo nixos-rebuild switch --upgrade
  sudo nixos-rebuild list-generations

  # Add flathub and some apps
  sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

  source ./bin/setup_flatpak.sh

  source ./bin/fix_user.sh
  
  reboot
else
  echo "Powerwashing Cancelled!"
fi
